package com.university.service;

import com.university.model.University;

import java.util.List;
import java.util.Map;

public interface UniversityService {
    List<University> selectAll();
    University selectById(Integer id);
    List<Map<String, Object>> getCollegesByUniversityId(Integer universityId);
}
