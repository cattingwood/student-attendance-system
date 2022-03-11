package com.example.studentattendancesystem.model;

import lombok.Data;

@Data
public class Admin {
    /**
     * 管理员id
     */
    private Integer id;

    /**
     * 账号
     */
    private Long account;

    /**
     * 密码
     */
    private String password;

    /**
     * 名称
     */
    private String name;
}