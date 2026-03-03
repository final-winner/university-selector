package com.university.model;

import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class UniversityScore {
    private Integer id;
    private Integer majorId;
    private Integer enrollmentPlan;
    private Integer year;
    private Integer retestScore;
    private String dataSource;
    private Integer applyNum;
    private Integer retestNum;
    private Integer admissionNum;
    private Integer highestScore;
    private Integer lowestScore;
    private BigDecimal averageScore;
    private LocalDateTime updateTime;
}
