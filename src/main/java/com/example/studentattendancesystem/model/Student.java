package com.example.studentattendancesystem.model;

import lombok.Data;

@Data
public class Student {
    /**
     * id
     */
    private Long id;

    /**
     * 姓名
     */
    private String name;

    /**
     * 学号/账号
     */
    private Long account;

    /**
     * 密码
     */
    private String password;

    /**
     * 第几届学生
     */
    private Integer period;

    /**
     * 学院ID
     */
    private Integer departmentId;

    /**
     * 专业
     */
    private Integer majorId;

    /**
     * 班级ID
     */
    private Long classId;
}