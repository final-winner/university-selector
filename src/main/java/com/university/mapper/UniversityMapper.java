package com.university.mapper;

import com.university.model.University;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.Map;

@Mapper
public interface UniversityMapper {
    List<University> selectAll();
    University selectById(Integer id);
    List<University> selectByProvince(String province);
    List<University> selectByCity(String city);
    List<Map<String, Object>> getCollegesByUniversityId(Integer universityId);
    int insert(University university);
    int update(University university);
    int deleteById(Integer id);
}
