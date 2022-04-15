package com.example.studentattendancesystem.model;

import lombok.Data;

@Data
public class StudentDetail {
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
     * 学院名称
     */
    private String departmentName;

    /**
     * 班级ID
     */
    private Long classId;

    /**
     * 班级名称
     */
    private String className;

    /**
     * 第几届学生
     */
    private Integer period;

    /**
     * 专业ID
     */
    private Integer majorId;

    /**
     * 专业名
     */
    private String majorName;
}
