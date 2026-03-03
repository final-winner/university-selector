package com.university.service.impl;

import com.university.mapper.UniversityMapper;
import com.university.model.University;
import com.university.service.UniversityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class UniversityServiceImpl implements UniversityService {

    @Autowired
    private UniversityMapper universityMapper;

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
}
