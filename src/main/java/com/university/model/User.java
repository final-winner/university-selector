package com.university.model;
import lombok.Data;
import java.time.LocalDateTime;

@Data
public class User {
    private Integer id;
    private String phone;
    private String email;
    private Integer targetScore;
    private String avatarUrl;
    private Integer targetUniversityId;
    private LocalDateTime infoUpdateTime;
    private String username;
    private String password;
    private Integer undergraduateUniversityId;
    private Integer postgraduateYear;
    private LocalDateTime createTime;
}
