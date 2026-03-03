package com.university.service;

import com.university.model.User;
import com.university.model.University;
import java.util.List;

public interface UserService {
    User selectByUsername(String username);
    
    User selectByPhone(String phone);
    
    int insert(User user);
    
    int updateById(User user);
    
    User selectById(Integer id);
    
    User login(String username, String password);
    
    boolean register(User user);
    
    List<University> getFavoritesByUserId(Integer userId);
    
    boolean addFavorite(Integer userId, Integer universityId);
    
    boolean removeFavorite(Integer userId, Integer universityId);
    
    boolean isFavorite(Integer userId, Integer universityId);
}
