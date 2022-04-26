package com.example.studentattendancesystem.model;

import java.util.Date;
import lombok.Data;

@Data
public class CustomSignRecord {
    private Long id;

    /**
    * 学生ID
    */
    private Long studentId;

    /**
    * 考勤发布ID
    */
    private Long customSignId;

    /**
    * 考勤时间
    */
    private Date signTime;
}