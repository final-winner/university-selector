package com.university.model;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class UserFavorite {
    private Integer id;
    private Integer userId;
    private Integer universityId;
    private LocalDateTime createdAt;
}
