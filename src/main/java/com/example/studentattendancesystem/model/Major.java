package com.example.studentattendancesystem.model;

import lombok.Data;

@Data
public class Major {
    /**
     * 专业ID
     */
    private Integer id;

    /**
     * 专业名
     */
    private String name;

    /**
     * 所属学院ID
     */
    private Integer departmentId;
}