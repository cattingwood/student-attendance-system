package com.example.studentattendancesystem.controller;

import com.example.studentattendancesystem.model.*;
import com.example.studentattendancesystem.service.EvaluateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RequestMapping("/evaluate")
@Controller
public class EvaluateController {

    @Autowired
    EvaluateService evaluateService;


    /*评价提交*/
    @RequestMapping("/evaluateSubmit")
    @ResponseBody
    public int evaluateSubmit(Integer score,String evaluateContent,HttpServletRequest request){
        try{
            Evaluate evaluate = new Evaluate();
            evaluate.setScore(score);
            evaluate.setContent(evaluateContent);
            HttpSession session = request.getSession();
            Student student = (Student) session.getAttribute("student");
            if(student != null){
                evaluate.setUserType(1);
                evaluate.setUserId(student.getId());
            }
            Teacher teacher = (Teacher) session.getAttribute("teacher");
            if(teacher != null){
                evaluate.setUserType(2);
                evaluate.setUserId(teacher.getId());
            }
            Counsellor counsellor = (Counsellor) session.getAttribute("counsellor");
            if(counsellor != null){
                evaluate.setUserType(3);
                evaluate.setUserId(counsellor.getId());
            }
            Admin admin = (Admin) session.getAttribute("admin");
            if(admin != null){
                evaluate.setUserType(4);
                evaluate.setUserId(Long.parseLong(admin.getId().toString()));
            }
            evaluateService.insertSelective(evaluate);
        }catch (Exception e){
            return 0;
        }
        return 1;
    }

}
