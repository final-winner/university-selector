package com.university.model;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class UserFavorite {
    private Integer id;
    private Integer userId;
    private Integer majorId;
    private LocalDateTime collectTime;
    private String remark;
    private Integer universityId;
}
