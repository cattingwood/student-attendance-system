package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.Course;
import org.apache.ibatis.annotations.Mapper;import java.util.List;

@Mapper
public interface CourseMapper {
    int insert(Course record);

    int insertSelective(Course record);

    List<Course> selectStudentCourseById(Long studentId);

    List<Course> selectCourseByClass(Long classId);

    List<Course> selectCourseByMajor(Integer majorId);

    List<Course> selectCourseByDepartment(Integer departmentId);

    List<Course> selectAll();
}