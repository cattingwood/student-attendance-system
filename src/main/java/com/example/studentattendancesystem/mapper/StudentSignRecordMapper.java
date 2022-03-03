package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.StudentSignRecord;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StudentSignRecordMapper {
    int deleteByPrimaryKey(Long id);

    int insert(StudentSignRecord record);

    int insertSelective(StudentSignRecord record);

    StudentSignRecord selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(StudentSignRecord record);

    int updateByPrimaryKey(StudentSignRecord record);
}