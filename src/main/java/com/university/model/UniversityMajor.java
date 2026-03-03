package com.university.model;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class UniversityMajor {
    private Integer id;
    private Integer universityId;
    private String name;
    private String code;
    private Integer departmentId;
    private String rating;
    private Integer tuition;
    private String introduction;
    private String examSubjects;
    private String retestSubjects;
    private Integer schoolingLength;
    private String acceptTransfer;
    private String masterType;
    private String dormitory;
    private String employment;
    private LocalDateTime updateTime;
}
