package com.university.model;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class UniversityScore {
    private Integer id;
    private Integer universityId;
    private Integer year;
    private Double politicalScore;
    private Double englishScore;
    private Double mathScore;
    private Double professionalScore;
    private Double totalScore;
    private Double admissionRatio;
    private Double reExamRatio;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
