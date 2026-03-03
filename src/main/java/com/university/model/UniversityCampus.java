package com.university.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import java.util.Date;

@Data
public class UniversityCampus {
    private Integer id;
    private Integer universityId; // 关联院校ID
    private String campusName; // 校区名称
    private String address; // 校区地址
    private String city; // 校区城市
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;
}