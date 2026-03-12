package com.university.mapper;

import com.university.model.University;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface UniversityMapper {
    List<University> selectAll();
    University selectById(Integer id);
    List<University> selectByProvince(String province);
    List<University> selectByCity(String city);
    List<Map<String, Object>> getCollegesByUniversityId(Integer universityId);
    List<Map<String, Object>> getRetestScoresByUniversityAndMajor(@Param("universityId") Integer universityId, @Param("majorId") Integer majorId);
    List<University> selectHotUniversities();
    int updateCollectionNum(@Param("universityId") Integer universityId, @Param("increment") int increment);
    int insert(University university);
    int update(University university);
    int deleteById(Integer id);
    List<University> selectByName(String name);
}
