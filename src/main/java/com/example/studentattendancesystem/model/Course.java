package com.example.studentattendancesystem.model;

import lombok.Data;

@Data
public class Course {
    /**
     * 课程id
     */
    private Long id;

    /**
     * 课程名
     */
    private String name;

    /**
     * 专业id
     */
    private Integer marjorId;

    /**
     * 是否为公共课
     */
    private Integer isPublic;

    /**
     * 是否为必修课
     */
    private Integer isRequired;
}