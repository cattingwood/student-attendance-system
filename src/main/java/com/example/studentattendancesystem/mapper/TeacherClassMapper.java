package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.TeacherClass;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TeacherClassMapper {
    int insert(TeacherClass record);

    int insertSelective(TeacherClass record);
}