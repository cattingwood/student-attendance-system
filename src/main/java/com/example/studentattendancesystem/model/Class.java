package com.example.studentattendancesystem.model;

import lombok.Data;

@Data
public class Class {
    /**
    * 班级id
    */
    private Long id;

    /**
    * 班级名称
    */
    private String name;

    /**
    * 班级专业
    */
    private String major;

    /**
    * 学院id
    */
    private Integer departmentId;
}