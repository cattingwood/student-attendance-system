package com.example.studentattendancesystem.model;

import lombok.Data;

@Data
public class Counsellor {
    /**
    * 辅导员ID
    */
    private Long id;

    /**
    * 辅导员名
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