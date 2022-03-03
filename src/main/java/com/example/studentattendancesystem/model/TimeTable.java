package com.example.studentattendancesystem.model;

import java.util.Date;
import lombok.Data;

@Data
public class TimeTable {
    /**
     * 开学日
     */
    private Date termBeginDay;

    /**
     * 学期
     */
    private Integer term;

    /**
     * 学年
     */
    private Integer year;
}