package com.university.service.impl;

import com.university.mapper.UserFavoriteMapper;
import com.university.mapper.UserMapper;
import com.university.mapper.UniversityMapper;
import com.university.model.User;
import com.university.model.University;
import com.university.model.UserFavorite;
import com.university.service.UserService;
import com.university.service.UniversityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;
    
    @Autowired
    private UserFavoriteMapper userFavoriteMapper;
    
    @Autowired
    private UniversityMapper universityMapper;
    
    @Autowired
    private UniversityService universityService;

    @Override
    public User selectByUsername(String username) {
        return userMapper.selectByUsername(username);
    }

    @Override
    public User selectByPhone(String phone) {
        return userMapper.selectByPhone(phone);
    }

    @Override
    public int insert(User user) {
        return userMapper.insert(user);
    }

    @Override
    public int updateById(User user) {
        return userMapper.updateById(user);
    }

    @Override
    public User selectById(Integer id) {
        return userMapper.selectById(id);
    }

    @Override
    public User login(String username, String password) {
        User user = userMapper.selectByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    @Override
    public boolean register(User user) {
        if (userMapper.selectByUsername(user.getUsername()) != null) {
            return false;
        }
        if (user.getPhone() != null && userMapper.selectByPhone(user.getPhone()) != null) {
            return false;
        }
        user.setCreateTime(java.time.LocalDateTime.now());
        return userMapper.insert(user) > 0;
    }

    @Override
    public List<University> getFavoritesByUserId(Integer userId) {
        List<UserFavorite> favorites = userFavoriteMapper.selectByUserId(userId);
        return favorites.stream()
                .map(favorite -> universityMapper.selectById(favorite.getUniversityId()))
                .filter(u -> u != null)
                .toList();
    }

    @Override
    public boolean addFavorite(Integer userId, Integer universityId) {
        if (userFavoriteMapper.selectByUserIdAndUniversityId(userId, universityId) != null) {
            return false;
        }
        UserFavorite favorite = new UserFavorite();
        favorite.setUserId(userId);
        favorite.setUniversityId(universityId);
        int insertResult = userFavoriteMapper.insert(favorite);
        boolean success = insertResult > 0;
        if (success) {
            universityMapper.updateCollectionNum(universityId, 1);
        }
        return success;
    }

    @Override
    public boolean removeFavorite(Integer userId, Integer universityId) {
        int deleteResult = userFavoriteMapper.deleteByUserIdAndUniversityId(userId, universityId);
        boolean success = deleteResult > 0;
        if (success) {
            universityMapper.updateCollectionNum(universityId, -1);
        }
        return success;
    }

    @Override
    public boolean isFavorite(Integer userId, Integer universityId) {
        return userFavoriteMapper.selectByUserIdAndUniversityId(userId, universityId) != null;
    }
}
