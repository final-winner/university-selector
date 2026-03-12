package com.university.mapper;

import com.university.model.Correction;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CorrectionMapper {
    int insert(Correction correction);
    List<Correction> selectAll();
    List<Correction> selectByStatus(@Param("status") String status);
    Correction selectById(@Param("id") Integer id);
    int updateStatus(@Param("id") Integer id, @Param("status") String status, @Param("processTime") String processTime);
}