package com.example.studentattendancesystem.model;

import lombok.Data;

@Data
public class CounsellorClass {
    private Long id;

    /**
    * 辅导员ID
    */
    private Long counsellorId;

    /**
    * 班级ID
    */
    private Long classId;
}