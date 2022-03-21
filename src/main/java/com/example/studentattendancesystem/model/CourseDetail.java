package com.example.studentattendancesystem.model;

import lombok.Data;

@Data
public class CourseDetail {
    /**
     * 课程id
     */
    private Long id;

    /**
     * 课程名
     */
    private String name;

    /**
     * 授课教师ID
     */
    private Long teacherId;

    /**
     * 授课教师
     */
    private String teacherName;

    /**
     * 授课班级ID
     */
    private Long classId;

    /**
     * 授课班级
     */
    private String className;

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
}
