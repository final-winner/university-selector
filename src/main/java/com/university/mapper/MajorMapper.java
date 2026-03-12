package com.university.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface MajorMapper {
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
     * @return 存在返回1，否则返回0
     */
    int checkMajorExistsByNameAndCode(@Param("universityId") Integer universityId, @Param("majorName") String majorName, @Param("majorCode") String majorCode);
}