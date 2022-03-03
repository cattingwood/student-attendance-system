package com.example.studentattendancesystem.model;

import lombok.Data;

@Data
public class CourseTime {
    /**
    * 课程id
    */
    private Long courseId;

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