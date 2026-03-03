package com.university.controller;

import com.university.model.University;
import com.university.service.UniversityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/university")
public class UniversityController {

    @Autowired
    private UniversityService universityService;

    @GetMapping("/list")
    public List<University> getAllUniversities() {
        return universityService.selectAll();
    }

    @GetMapping("/detail/{id}")
    public University getUniversityById(@PathVariable Integer id) {
        return universityService.selectById(id);
    }

    @GetMapping("/colleges/{id}")
    public List<Map<String, Object>> getCollegesByUniversityId(@PathVariable Integer id) {
        return universityService.getCollegesByUniversityId(id);
    }
}

