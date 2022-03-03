package com.example.studentattendancesystem.model;

import lombok.Data;

@Data
public class Student {
    /**
     * id
     */
    private Long id;

    /**
     * 学号/账号
     */
    private Long account;

    /**
     * 姓名
     */
    private String name;

    /**
     * 密码
     */
    private String password;

    /**
     * 学院ID
     */
    private Integer departmentId;

    /**
     * 班级ID
     */
    private Integer classId;

    /**
     * 第几届学生
     */
    private Integer period;

    /**
     * 专业
     */
    private String major;
}