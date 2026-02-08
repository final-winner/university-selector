package com.university;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan("com.university.mapper")
@SpringBootApplication
public class SelectorOfUniversityApplication {

    public static void main(String[] args) {
        SpringApplication.run(SelectorOfUniversityApplication.class, args);
        System.out.println("http://localhost:8080");
    }

}
