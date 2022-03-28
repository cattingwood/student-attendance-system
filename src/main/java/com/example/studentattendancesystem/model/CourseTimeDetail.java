package com.example.studentattendancesystem.model;

import lombok.Data;

@Data
public class CourseTimeDetail {
    /**
     * 课程id
     */
    private Long courseId;

    /**
     * 课程id
     */
    private String courseName;

    /**
     * 第几周
     */
    private Integer courseWeek;

    /**
     * 星期几
     */
    private Integer courseDay;

    /**
     * 第几节
     */
    private Integer courseSort;

    /**
     * 教师id
     */
    private Long teacherId;

    /**
     * 教师名
     */
    private String teacherName;

    /**
     * 班级id
     */
    private Long classId;

    /**
     * 班级名
     */
    private String className;
}
