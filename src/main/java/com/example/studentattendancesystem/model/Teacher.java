package com.example.studentattendancesystem.model;

import lombok.Data;

@Data
public class Teacher {
    /**
    * 教师id
    */
    private Long id;

    /**
     * 教师姓名
     */
    private String name;

    /**
     * 账号
     */
    private Long account;

    /**
     * 密码
     */
    private String password;
}