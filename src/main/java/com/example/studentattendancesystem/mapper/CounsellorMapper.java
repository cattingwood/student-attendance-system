package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.Counsellor;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CounsellorMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Counsellor record);

    int insertSelective(Counsellor record);

    Counsellor selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Counsellor record);

    int updateByPrimaryKey(Counsellor record);

    Counsellor selectByAccount(Long acount);
}