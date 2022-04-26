package com.example.studentattendancesystem.model;

import java.util.Date;
import lombok.Data;

@Data
public class CustomSign {
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
     * 班级ID
     */
    private Long classId;

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