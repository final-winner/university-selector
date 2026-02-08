package com.university.model;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class University {
    private Integer id;
    private String universityCode;
    private String name;
    private String location;
    private String type;
    private String region;
    private String level;
    private String dormitory;
    private String tuition;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
