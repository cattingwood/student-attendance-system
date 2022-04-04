package com.example.studentattendancesystem.model;

import java.util.Date;
import lombok.Data;

@Data
public class StudentSignRecord {
    /**
    * 签到记录id
    */
    private Long id;

    /**
    * 学生id
    */
    private Long studentId;

    /**
    * 课程id
    */
    private Long courseId;

    /**
    * 签到时间
    */
    private Date signTime;

    /**
    * 签到类型
    */
    private Integer type;

    /**
    * 签到周数
    */
    private Integer signWeek;

    /**
    * 签到日
    */
    private Integer signDay;

    /**
     * 状态
     */
    private Integer status;

    /**
     * 排序
     */
    private Integer sort;
}