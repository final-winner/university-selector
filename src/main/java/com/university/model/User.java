package com.university.model;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class User {
    private Integer id;
    private String username;
    private String password;
    private String email;
    private String phone;
    private Double targetScore;
    private String preferredRegion;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
