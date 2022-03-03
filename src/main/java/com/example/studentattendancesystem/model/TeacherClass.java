package com.example.studentattendancesystem.model;

import lombok.Data;

@Data
public class TeacherClass {
    /**
    * 教师id
    */
    private Integer teacherId;

    /**
    * 课程id
    */
    private Integer courseId;

    /**
    * 班级id
    */
    private Integer classId;
}