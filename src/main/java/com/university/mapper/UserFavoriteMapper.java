package com.university.mapper;

import com.university.model.UserFavorite;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface UserFavoriteMapper {
    List<UserFavorite> selectByUserId(@Param("userId") Integer userId);
    
    int insert(UserFavorite favorite);
    
    int deleteByUserIdAndUniversityId(@Param("userId") Integer userId, @Param("universityId") Integer universityId);
    
    UserFavorite selectByUserIdAndUniversityId(@Param("userId") Integer userId, @Param("universityId") Integer universityId);
}
