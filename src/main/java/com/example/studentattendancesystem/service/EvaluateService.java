package com.example.studentattendancesystem.service;

import com.example.studentattendancesystem.model.EvaluateDetail;
import com.example.studentattendancesystem.model.Teacher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.mapper.EvaluateMapper;
import com.example.studentattendancesystem.model.Evaluate;

import java.util.ArrayList;
import java.util.List;

@Service
public class EvaluateService{

    @Autowired
    private StudentService studentService;

    @Autowired
    private TeacherService teacherService;

    @Autowired
    private CounsellorService counsellorService;

    @Autowired
    private AdminService adminService;

    @Resource
    private EvaluateMapper evaluateMapper;

    
    public int deleteByPrimaryKey(Long id) {
        return evaluateMapper.deleteByPrimaryKey(id);
    }

    
    public int insert(Evaluate record) {
        return evaluateMapper.insert(record);
    }

    
    public int insertSelective(Evaluate record) {
        return evaluateMapper.insertSelective(record);
    }

    public List<EvaluateDetail> selectAll() {
        List<Evaluate> evaluateList = evaluateMapper.selectAll();
        List<EvaluateDetail> evaluateDetailList = new ArrayList<>();
        for (int i = 0; i < evaluateList.size(); i++) {
            evaluateDetailList.add(getEvaluateDetail(evaluateList.get(i)));
        }
        return evaluateDetailList;
    }

    public EvaluateDetail getEvaluateDetail(Evaluate evaluate){
        EvaluateDetail evaluateDetail = new EvaluateDetail();
        evaluateDetail.setId(evaluate.getId());
        evaluateDetail.setScore(evaluate.getScore());
        evaluateDetail.setContent(evaluate.getContent());
        Integer type = evaluate.getUserType();
        evaluateDetail.setUserId(evaluate.getUserId());
        if(type == 1){
            evaluateDetail.setUserType("学生");
            evaluateDetail.setUserName(studentService.selectByPrimaryKey(evaluate.getUserId()).getName());
        }else if(type == 2){
            evaluateDetail.setUserType("教师");
            evaluateDetail.setUserName(teacherService.selectByPrimaryKey(evaluate.getUserId()).getName());
        }else if(type == 3){
            evaluateDetail.setUserType("辅导员");
            evaluateDetail.setUserName(counsellorService.selectByPrimaryKey(evaluate.getUserId()).getName());
        }else if(type == 4){
            evaluateDetail.setUserType("管理员");
            evaluateDetail.setUserName(adminService.selectByPrimaryKey(Integer.parseInt(evaluate.getUserId().toString())).getName());
        }
        return evaluateDetail;
    }

    public Evaluate selectByPrimaryKey(Long id) {
        return evaluateMapper.selectByPrimaryKey(id);
    }

    
    public int updateByPrimaryKeySelective(Evaluate record) {
        return evaluateMapper.updateByPrimaryKeySelective(record);
    }

    
    public int updateByPrimaryKey(Evaluate record) {
        return evaluateMapper.updateByPrimaryKey(record);
    }

}
