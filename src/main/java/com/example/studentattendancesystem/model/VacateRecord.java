package com.example.studentattendancesystem.model;

import java.util.Date;
import lombok.Data;

@Data
public class VacateRecord {
    /**
     * id
     */
    private Long id;

    /**
     * 学生id
     */
    private Long studentId;

    /**
     * 开始周
     */
    private Integer beginWeek;

    /**
     * 开始日
     */
    private Integer beginDay;

    /**
     * 开始时间
     */
    private Integer beginTime;

    /**
     * 结束周
     */
    private Integer endWeek;

    /**
     * 结束日
     */
    private Integer endDay;

    /**
     * 结束时间
     */
    private Integer endTime;

    /**
     * 1为成功-1为失败0为待确认
     */
    private Integer status;

    /**
     * 创建时间
     */
    private Date createTime;
}