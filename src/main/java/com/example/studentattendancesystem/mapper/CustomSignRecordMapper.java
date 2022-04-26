package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.CustomSignRecord;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CustomSignRecordMapper {
    int insert(CustomSignRecord record);

    int insertSelective(CustomSignRecord record);

    int countBySignId(Long signId);
}