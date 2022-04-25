package com.example.studentattendancesystem.model;

import lombok.Data;

@Data
public class EvaluateDetail {
    private Long id;

    /**
    * 评分
    */
    private Integer score;

    /**
    * 评价内容
    */
    private String content;

    /**
    * 用户类型
    */
    private String userType;

    /**
    * 用户id
    */
    private Long userId;

    /**
     * 用户id
     */
    private String userName;
}