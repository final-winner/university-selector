package com.university.controller;

import com.university.model.University;
import com.university.model.UniversityCompareResult;
import com.university.service.UniversityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
    
    @GetMapping("/hot")
    public List<University> getHotUniversities() {
        return universityService.getHotUniversities();
    }
    
    @GetMapping("/search")
    public List<University> searchUniversities(String name) {
        return universityService.searchByName(name);
    }

    @GetMapping("/compare")
    public List<UniversityCompareResult> compareUniversities(
            @RequestParam("universityIds") String universityIds,
            @RequestParam("majorId") Integer majorId) {
        // 将逗号分隔的字符串转换为List<Integer>
        List<Integer> ids = Arrays.stream(universityIds.split("\\,")).map(Integer::parseInt).collect(Collectors.toList());
        return universityService.compareUniversities(ids, majorId);
    }

    @GetMapping("/majors")
    public List<Map<String, Object>> getAllMajors() {
        return universityService.getAllMajors();
    }

    @GetMapping("/check-major")
    public boolean checkMajorExists(
            @RequestParam("universityId") Integer universityId,
            @RequestParam("majorName") String majorName,
            @RequestParam("majorCode") String majorCode) {
        return universityService.checkMajorExistsByNameAndCode(universityId, majorName, majorCode);
    }
}

