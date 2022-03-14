package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.CourseTime;
import org.apache.ibatis.annotations.Mapper;import java.util.List;

@Mapper
public interface CourseTimeMapper {
    int insert(CourseTime record);

    int insertSelective(CourseTime record);

    List<CourseTime> selectByCourseId(Long courseId);
}