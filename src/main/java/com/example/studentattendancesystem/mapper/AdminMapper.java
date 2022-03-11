package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.Admin;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper {

    Admin selectByAccount(Long account);
}