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
}