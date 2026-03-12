package com.university.model;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Correction {
    private Integer id;
    private Integer userId;
    private Integer universityId;
    private String type;
    private String field;
    private String currentValue;
    private String suggestedValue;
    private String description;
    private String status;
    private LocalDateTime submitTime;
    private LocalDateTime processTime;
}