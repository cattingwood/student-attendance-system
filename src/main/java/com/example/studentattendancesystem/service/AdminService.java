package com.example.studentattendancesystem.service;

import com.example.studentattendancesystem.mapper.AdminMapper;
import com.example.studentattendancesystem.model.Admin;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class AdminService {

    @Resource
    private AdminMapper adminMapper;

    public Admin selectByAccount(Long account) {
        return adminMapper.selectByAccount(account);
    }
}
