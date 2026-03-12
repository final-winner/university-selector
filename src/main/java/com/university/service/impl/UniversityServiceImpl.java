package com.university.service.impl;

import com.university.mapper.MajorMapper;
import com.university.mapper.UniversityMapper;
import com.university.model.University;
import com.university.model.UniversityCompareResult;
import com.university.service.UniversityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UniversityServiceImpl implements UniversityService {

    @Autowired
    private UniversityMapper universityMapper;
    
    @Autowired
    private MajorMapper majorMapper;

    @Override
    public List<University> selectAll() {
        return universityMapper.selectAll();
    }
    @Override
    public University selectById(Integer id) {
        return universityMapper.selectById(id);
    }
    @Override
    public List<Map<String, Object>> getCollegesByUniversityId(Integer universityId) {
        return universityMapper.getCollegesByUniversityId(universityId);
    }
    @Override
    public List<University> getHotUniversities() {
        return universityMapper.selectHotUniversities();
    }
    @Override
    public void updateCollectionNum(Integer universityId, int increment) {
        universityMapper.updateCollectionNum(universityId, increment);
    }
    @Override
    public List<University> searchByName(String name) {
        return universityMapper.selectByName(name);
    }

    @Override
    public List<UniversityCompareResult> compareUniversities(List<Integer> universityIds, Integer majorId) {
        List<UniversityCompareResult> results = new ArrayList<>();

        // 城市层级字典定义
        Map<String, Integer> cityLevelMap = new HashMap<>();
        // 一线城市
        List<String> firstTierCities = Arrays.asList("北京", "上海", "广州", "深圳");
        firstTierCities.forEach(city -> cityLevelMap.put(city, 10));
        // 新一线城市
        List<String> newFirstTierCities = Arrays.asList("成都", "重庆", "杭州", "武汉", "西安", "天津", "苏州", "南京", "郑州", "长沙", "东莞", "宁波", "佛山", "合肥", "青岛");
        newFirstTierCities.forEach(city -> cityLevelMap.put(city, 8));
        // 二线城市
        List<String> secondTierCities = Arrays.asList("昆明", "沈阳", "济南", "无锡", "厦门", "福州", "温州", "金华", "哈尔滨", "大连", "贵阳", "南宁", "泉州", "石家庄", "长春", "南昌", "惠州", "常州", "嘉兴", "徐州", "南通", "太原", "保定", "珠海", "中山", "兰州", "临沂", "潍坊", "烟台", "绍兴");
        secondTierCities.forEach(city -> cityLevelMap.put(city, 5));

        // 遍历每个院校ID，计算对比数据
        for (Integer universityId : universityIds) {
            UniversityCompareResult result = new UniversityCompareResult();

            // 查询院校基础信息
            University university = universityMapper.selectById(universityId);
            if (university == null) {
                // 容错处理：院校不存在
                continue;
            }

            // 封装基础信息
            result.setUniversityName(university.getName());
            result.setUniversityLevel(university.getLevel());
            result.setCity(university.getCity());

            // 查询近3年复试线数据
            List<Map<String, Object>> retestScores = universityMapper.getRetestScoresByUniversityAndMajor(universityId, majorId);
            result.setRetestScoreTrend(retestScores);

            // 计算最新复试线
            Integer latestRetestScore = null;
            if (!retestScores.isEmpty()) {
                latestRetestScore = (Integer) retestScores.get(retestScores.size() - 1).get("retestScore");
            }
            result.setLatestRetestScore(latestRetestScore);

            // 计算复试线涨幅
            String trendDescription = "暂无完整数据";
            if (retestScores.size() >= 2) {
                int firstYearScore = (Integer) retestScores.get(0).get("retestScore");
                int lastYearScore = (Integer) retestScores.get(retestScores.size() - 1).get("retestScore");
                int scoreDiff = lastYearScore - firstYearScore;

                if (scoreDiff > 10) {
                    trendDescription = String.format("近3年稳步上涨（+%d分）", scoreDiff);
                } else if (scoreDiff >= -5 && scoreDiff <= 10) {
                    String sign = scoreDiff > 0 ? "+": "";
                    trendDescription = String.format("近3年基本平稳（%s%d分）", sign, scoreDiff);
                } else {
                    trendDescription = String.format("近3年略有回落（-%d分）", Math.abs(scoreDiff));
                }
            }
            result.setRetestScoreTrendDescription(trendDescription);

            // 计算难度评分
            double difficultyScore = calculateDifficultyScore(university, retestScores, cityLevelMap);
            result.setDifficultyScore(difficultyScore);

            // 设置难度语义描述
            String difficultyDescription;
            if (difficultyScore >= 8) {
                difficultyDescription = "极高难度";
            } else if (difficultyScore >= 6) {
                difficultyDescription = "较高难度";
            } else if (difficultyScore >= 4) {
                difficultyDescription = "中等难度";
            } else {
                difficultyDescription = "较低难度";
            }
            result.setDifficultyDescription(difficultyDescription);

            results.add(result);
        }

        return results;
    }

    @Override
    public List<Map<String, Object>> getAllMajors() {
        return majorMapper.getAllMajors();
    }

    @Override
    public boolean checkMajorExistsByNameAndCode(Integer universityId, String majorName, String majorCode) {
        return majorMapper.checkMajorExistsByNameAndCode(universityId, majorName, majorCode) > 0;
    }

    /**
     * 计算难度评分（1-10分，保留1位小数）
     */
    private double calculateDifficultyScore(University university, List<Map<String, Object>> retestScores, Map<String, Integer> cityLevelMap) {
        // 1. 院校层次得分（40%折算）
        double universityLevelScore = 0;
        String level = university.getLevel();
        if (level != null) {
            if (level.contains("985")) {
                universityLevelScore = 10 * 0.4;
            } else if (level.contains("211")) {
                universityLevelScore = 8 * 0.4;
            } else {
                universityLevelScore = 5 * 0.4;
            }
        } else {
            universityLevelScore = 5 * 0.4; // 默认双非
        }

        // 2. 复试线涨幅得分（30%折算）
        double retestTrendScore = 0;
        if (retestScores.size() >= 2) {
            int firstYearScore = (Integer) retestScores.get(0).get("retestScore");
            int lastYearScore = (Integer) retestScores.get(retestScores.size() - 1).get("retestScore");
            int scoreDiff = lastYearScore - firstYearScore;

            if (scoreDiff > 20) {
                retestTrendScore = 10 * 0.3;
            } else if (scoreDiff >= 10) {
                retestTrendScore = 8 * 0.3;
            } else if (scoreDiff >= -5) {
                retestTrendScore = 5 * 0.3;
            } else {
                retestTrendScore = 3 * 0.3;
            }
        } else {
            retestTrendScore = 5 * 0.3; // 数据不全默认中等
        }

        // 3. 地区热度得分（30%折算）
        double regionHotScore = 0;
        String city = university.getCity();
        if (city != null) {
            // 城市名标准化
            String normalizedCity = normalizeCityName(city);
            // 获取城市基础分
            Integer baseScore = cityLevelMap.getOrDefault(normalizedCity, 3);
            regionHotScore = baseScore * 0.3;
        } else {
            regionHotScore = 3 * 0.3; // 默认其他城市
        }

        // 计算总分
        double totalScore = universityLevelScore + retestTrendScore + regionHotScore;

        // 兜底规则
        totalScore = Math.max(totalScore, 1.0);
        totalScore = Math.min(totalScore, 10.0);

        // 保留1位小数
        return Math.round(totalScore * 10.0) / 10.0;
    }

    /**
     * 城市名标准化处理
     */
    private String normalizeCityName(String city) {
        // 去除"市"后缀
        String normalized = city.replaceAll("市$", "");
        // 去除"省"后缀
        normalized = normalized.replaceAll("省$", "");
        // 处理复合城市名，只保留最后一个城市名
        if (normalized.contains("省")) {
            normalized = normalized.substring(normalized.lastIndexOf("省") + 1);
        }
        // 去除前后空格
        return normalized.trim();
    }
}
