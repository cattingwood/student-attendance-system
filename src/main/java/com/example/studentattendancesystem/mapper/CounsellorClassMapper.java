package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.CounsellorClass;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CounsellorClassMapper {
    int insert(CounsellorClass record);

    int insertSelective(CounsellorClass record);
}