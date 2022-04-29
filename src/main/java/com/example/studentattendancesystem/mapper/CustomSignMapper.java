package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.CustomSign;
import org.apache.ibatis.annotations.Mapper;import java.util.List;

@Mapper
public interface CustomSignMapper {
    int insert(CustomSign record);

    int insertSelective(CustomSign record);

    List<CustomSign> selectByTeacher(Long teacherId);

    List<CustomSign> selectByCounsellor(Long counsellorId);

    List<CustomSign> selectByStudent(Long studentId);
}