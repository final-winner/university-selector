package com.university.mapper;

import com.university.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {
    User selectByUsername(@Param("username") String username);
    
    User selectByPhone(@Param("phone") String phone);
    
    int insert(User user);
    
    int updateById(User user);
    
    User selectById(@Param("id") Integer id);
}
