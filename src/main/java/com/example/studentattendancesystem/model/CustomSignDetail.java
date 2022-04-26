package com.example.studentattendancesystem.model;

import lombok.Data;

import java.util.Date;

@Data
public class CustomSignDetail {
    private Long id;

    /**
     * 考勤名称
     */
    private String signName;

    /**
    * 发布者类型1教师2辅导员
    */
    private Integer releaseType;

    /**
    * 发布者ID
    */
    private Long releaseId;

    /**
     * 发布者名称
     */
    private String releaseName;

    /**
    * 班级ID
    */
    private Long classId;

    /**
     * 班级名
     */
    private String className;

    /**
     * 班级名
     */
    private Integer SignCount;

    /**
    * 开始时间
    */
    private Date beginTime;

    /**
    * 结束时间
    */
    private Date endTime;

    /**
    * 创建时间
    */
    private Date createTime;
}