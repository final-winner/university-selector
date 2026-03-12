package com.university.model;

import lombok.Data;
import java.util.Date;

@Data
public class UniversityDepartment {
    private Integer id;
    private Integer universityId;
    private Integer campusId;
    private String name;
    private String shortName;
    private String website;
    private String contact;
    private String introduction;
    private Date updateTime;
    
}