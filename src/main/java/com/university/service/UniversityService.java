package com.university.service;

import com.university.model.University;
import com.university.model.UniversityCompareResult;

import java.util.List;
import java.util.Map;

public interface UniversityService {
    List<University> selectAll();
    University selectById(Integer id);
    List<Map<String, Object>> getCollegesByUniversityId(Integer universityId);
    List<University> getHotUniversities();
    void updateCollectionNum(Integer universityId, int increment);
    List<University> searchByName(String name);
    List<UniversityCompareResult> compareUniversities(List<Integer> universityIds, Integer majorId);
    
    /**
     * 获取所有专业列表
     * @return 专业列表
     */
    List<Map<String, Object>> getAllMajors();
    
    /**
     * 检查指定院校是否开设了指定名称和代码的专业
     * @param universityId 院校ID
     * @param majorName 专业名称
     * @param majorCode 专业代码
     * @return 存在返回true，否则返回false
     */
    boolean checkMajorExistsByNameAndCode(Integer universityId, String majorName, String majorCode);
}
