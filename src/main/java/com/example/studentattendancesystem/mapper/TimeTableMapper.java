package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.TimeTable;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TimeTableMapper {
    int insert(TimeTable record);

    int insertSelective(TimeTable record);

    TimeTable selectOne();
}