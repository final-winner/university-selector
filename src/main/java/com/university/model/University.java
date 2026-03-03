package com.university.model;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class University {
    private Integer id;
    private String name;
    private Integer collectionNum;
    private String address;
    private String city;
    private String code;
    private String level;
    private String officialWebsite;
    private String graduateSchoolName;
    private String graduateSchoolWebsite;
    private String AB;
    private String province;
    private String introduction;
    private String type;
    private String logoUrl;
    private String region;
    private LocalDateTime updateTime;
}
