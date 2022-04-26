package com.example.studentattendancesystem.service;

import com.example.studentattendancesystem.mapper.CustomSignRecordMapper;
import com.example.studentattendancesystem.model.CustomSignDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import com.example.studentattendancesystem.model.CustomSign;
import com.example.studentattendancesystem.mapper.CustomSignMapper;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class CustomSignService {

    @Resource
    private CustomSignRecordMapper customSignRecordMapper;

    @Resource
    private CustomSignMapper customSignMapper;

    @Autowired
    TeacherService teacherService;

    @Autowired
    CounsellorService counsellorService;

    @Autowired
    ClassService classService;

    public int insert(CustomSign record) {
        return customSignMapper.insert(record);
    }


    public int insertSelective(CustomSign record) {
        return customSignMapper.insertSelective(record);
    }

    public List<CustomSignDetail> selectByStudent(Long studentId) {
        List<CustomSign> list = customSignMapper.selectByStudent(studentId);
        List<CustomSignDetail> detailList = new ArrayList<>();
        Date date = new Date();
        for (int i = 0; i < list.size(); i++) {
            if(date.after(list.get(i).getBeginTime()) && date.before(list.get(i).getEndTime())){
                detailList.add(getCustomSignDetail(list.get(i),1,studentId));
            }
        }
        return detailList;
    }

    public List<CustomSignDetail> selectByTeacher(Long teacherId) {
        List<CustomSign> list = customSignMapper.selectByTeacher(teacherId);
        List<CustomSignDetail> detailList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            detailList.add(getCustomSignDetail(list.get(i),2,teacherId));
        }
        return detailList;
    }

    public CustomSignDetail getCustomSignDetail(CustomSign sign,Integer type,Long id){
        CustomSignDetail detail = new CustomSignDetail();
        detail.setId(sign.getId());
        detail.setSignName(sign.getSignName());
        detail.setReleaseType(sign.getReleaseType());
        detail.setReleaseId(sign.getReleaseId());
        if(sign.getReleaseType() == 1){
            detail.setReleaseName(teacherService.selectByPrimaryKey(sign.getReleaseId()).getName());
        }else if(sign.getReleaseType() == 2){
            detail.setReleaseName(counsellorService.selectByPrimaryKey(sign.getReleaseId()).getName());
        }
        detail.setClassId(sign.getClassId());
        detail.setClassName(classService.selectClassById(sign.getClassId()).getName());
        detail.setSignCount(customSignRecordMapper.countBySignId(sign.getId()));
        detail.setBeginTime(sign.getBeginTime());
        detail.setEndTime(sign.getEndTime());
        detail.setCreateTime(sign.getCreateTime());
        if(type == 1){
            Integer count =  customSignRecordMapper.countByStudentAndSign(id,sign.getId());
            if(count > 0){
                detail.setStatus(1);
            }
        }
        return detail;
    }

}

