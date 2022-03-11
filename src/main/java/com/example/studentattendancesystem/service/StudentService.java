package com.example.studentattendancesystem.service;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.model.Student;
import com.example.studentattendancesystem.mapper.StudentMapper;

@Service
public class StudentService {

    @Resource
    private StudentMapper studentMapper;

    public Student selectByAccount(Long account) {
        return studentMapper.selectByAccount(account);
    }


    public int deleteByPrimaryKey(Long id) {
        return studentMapper.deleteByPrimaryKey(id);
    }


    public int insert(Student record) {
        return studentMapper.insert(record);
    }


    public int insertSelective(Student record) {
        return studentMapper.insertSelective(record);
    }


    public Student selectByPrimaryKey(Long id) {
        return studentMapper.selectByPrimaryKey(id);
    }


    public int updateByPrimaryKeySelective(Student record) {
        return studentMapper.updateByPrimaryKeySelective(record);
    }


    public int updateByPrimaryKey(Student record) {
        return studentMapper.updateByPrimaryKey(record);
    }

}





