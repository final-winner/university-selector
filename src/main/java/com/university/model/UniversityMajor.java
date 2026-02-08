package com.university.model;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class UniversityMajor {
    private Integer id;
    private Integer universityId;
    private String majorName;
    private String examSubjects;
    private String researchDirection;
    private String tutorInfo;
    private String disciplineEvaluation;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
