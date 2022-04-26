package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.CustomSignRecord;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CustomSignRecordMapper {
    int insert(CustomSignRecord record);

    int insertSelective(CustomSignRecord record);

    int countBySignId(Long signId);

    int countByStudentAndSign(@Param(value="studentId")Long studentId,
                              @Param(value="signId")Long signId);
}