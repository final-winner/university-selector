package com.university.model;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class UniversityAdmission {
    private Integer id;
    private Integer universityId;
    private Integer year;
    private Integer totalRecruitment;
    private Integer recommendedRecruitment;
    private Integer actualRecruitment;
    private String notes;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
