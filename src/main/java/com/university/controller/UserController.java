package com.university.controller;

import com.university.model.University;
import com.university.model.User;
import com.university.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody Map<String, String> params) {
        Map<String, Object> result = new HashMap<>();
        String username = params.get("username");
        String password = params.get("password");
        
        User user = userService.login(username, password);
        if (user != null) {
            // 确保用户有角色，默认为user
            if (user.getRole() == null) {
                user.setRole("user");
            }
            // 为了演示，将用户名为"admin"的用户设置为管理员
            if ("admin".equals(username)) {
                user.setRole("admin");
            }
            System.out.println("Login user role: " + user.getRole());
            result.put("success", true);
            result.put("message", "登录成功");
            result.put("user", user);
        } else {
            result.put("success", false);
            result.put("message", "用户名或密码错误");
        }
        return result;
    }

    @PostMapping("/register")
    public Map<String, Object> register(@RequestBody User user) {
        Map<String, Object> result = new HashMap<>();
        
        boolean success = userService.register(user);
        if (success) {
            result.put("success", true);
            result.put("message", "注册成功");
        } else {
            result.put("success", false);
            result.put("message", "用户名或邮箱已被注册");
        }
        return result;
    }

    @GetMapping("/favorite/{userId}")
    public List<University> getFavorites(@PathVariable Integer userId) {
        return userService.getFavoritesByUserId(userId);
    }

    @PostMapping("/favorite/add")
    public Map<String, Object> addFavorite(@RequestBody Map<String, Integer> params) {
        Map<String, Object> result = new HashMap<>();
        Integer userId = params.get("userId");
        Integer universityId = params.get("universityId");
        
        boolean success = userService.addFavorite(userId, universityId);
        result.put("success", success);
        result.put("message", success ? "收藏成功" : "已收藏或收藏失败");
        return result;
    }

    @PostMapping("/favorite/remove")
    public Map<String, Object> removeFavorite(@RequestBody Map<String, Integer> params) {
        Map<String, Object> result = new HashMap<>();
        Integer userId = params.get("userId");
        Integer universityId = params.get("universityId");
        
        boolean success = userService.removeFavorite(userId, universityId);
        result.put("success", success);
        result.put("message", success ? "取消收藏成功" : "取消收藏失败");
        return result;
    }

    @GetMapping("/favorite/check")
    public Map<String, Object> checkFavorite(@RequestParam Integer userId, @RequestParam Integer universityId) {
        Map<String, Object> result = new HashMap<>();
        boolean isFavorite = userService.isFavorite(userId, universityId);
        result.put("isFavorite", isFavorite);
        return result;
    }
    @PostMapping("/update")
    public Map<String, Object> update(@RequestBody Map<String, Object> params) {
        Map<String, Object> result = new HashMap<>();
        Integer userId = (Integer) params.get("userId");
        Integer targetScore = params.get("targetScore") != null ? Integer.parseInt(params.get("targetScore").toString()) : null;
        Integer postgraduateYear = params.get("postgraduateYear") != null ? Integer.parseInt(params.get("postgraduateYear").toString()) : null;
        
        User user = new User();
        user.setId(userId);
        user.setTargetScore(targetScore);
        user.setPostgraduateYear(postgraduateYear);
        user.setInfoUpdateTime(java.time.LocalDateTime.now());
        
        int rows = userService.updateById(user);
        if (rows > 0) {
            result.put("success", true);
            result.put("message", "更新成功");
        } else {
            result.put("success", false);
            result.put("message", "更新失败");
        }
        return result;
    }
}
