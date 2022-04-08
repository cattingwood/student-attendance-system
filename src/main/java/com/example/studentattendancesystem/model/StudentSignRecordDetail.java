package com.example.studentattendancesystem.model;

import lombok.Data;

import java.util.Date;

@Data
public class StudentSignRecordDetail {
    /**
    * 签到记录id
    */
    private Long id;

    /**
    * 学生id
    */
    private Long studentId;

    /**
     * 学生名
     */
    private String studentName;

    /**
    * 课程id
    */
    private Long courseId;

    /**
     * 课程名
     */
    private String courseName;

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

    /**
     * 教师ID
     */
    private Long teacherId;

    /**
     * 教师名
     */
    private String teacherName;
}