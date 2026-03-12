package com.university.model;

import lombok.Data;
import java.util.List;
import java.util.Map;

@Data
public class UniversityCompareResult {
    private String universityName;
    private String universityLevel;
    private String city;
    private Integer latestRetestScore;
    private List<Map<String, Object>> retestScoreTrend;
    private String retestScoreTrendDescription;
    private Double difficultyScore;
    private String difficultyDescription;
}