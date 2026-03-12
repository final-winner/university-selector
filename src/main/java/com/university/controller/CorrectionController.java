package com.university.controller;

import com.university.model.Correction;
import com.university.service.CorrectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/correction")
public class CorrectionController {

    @Autowired
    private CorrectionService correctionService;

    @PostMapping("/submit")
    public Map<String, Object> submitCorrection(@RequestBody Correction correction) {
        int result = correctionService.submitCorrection(correction);
        if (result > 0) {
            return Map.of("success", true, "message", "纠错信息提交成功");
        } else {
            return Map.of("success", false, "message", "纠错信息提交失败");
        }
    }

    @GetMapping("/list")
    public List<Correction> getCorrections() {
        return correctionService.getAllCorrections();
    }

    @GetMapping("/list/{status}")
    public List<Correction> getCorrectionsByStatus(@PathVariable String status) {
        return correctionService.getCorrectionsByStatus(status);
    }

    @PostMapping("/approve/{id}")
    public Map<String, Object> approveCorrection(@PathVariable Integer id) {
        boolean result = correctionService.approveCorrection(id);
        if (result) {
            return Map.of("success", true, "message", "审核通过成功");
        } else {
            return Map.of("success", false, "message", "审核通过失败");
        }
    }

    @PostMapping("/reject/{id}")
    public Map<String, Object> rejectCorrection(@PathVariable Integer id) {
        boolean result = correctionService.rejectCorrection(id);
        if (result) {
            return Map.of("success", true, "message", "拒绝成功");
        } else {
            return Map.of("success", false, "message", "拒绝失败");
        }
    }
}