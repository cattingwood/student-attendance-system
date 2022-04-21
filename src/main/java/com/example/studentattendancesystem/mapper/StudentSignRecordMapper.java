package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.StudentSignRecord;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface StudentSignRecordMapper {
    int deleteByPrimaryKey(Long id);

    int insert(StudentSignRecord record);

    int insertSelective(StudentSignRecord record);

    StudentSignRecord selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(StudentSignRecord record);

    int updateByPrimaryKey(StudentSignRecord record);

    List<StudentSignRecord> selectByStudentAndDay(@Param(value="studentId")Long studentId,
                                                  @Param(value="week")int week,
                                                  @Param(value="day")int day);

    List<StudentSignRecord> selectAll();

    List<StudentSignRecord> selectResignByTeacherId(Long teacherId);

    List<StudentSignRecord> selectVacateDetailByTeacherId(Long teacherId);

    int selectSignCountByStudentId(Long studentId);

    int selectResignCountByStudentId(Long studentId);

    int selectVacateCountByStudentId(Long studentId);

    int selectSignCountByCourseAndStudent(@Param(value="courseId")Long courseId,
                                          @Param(value="studentId")Long studentId);

    int selectResignCountByCourseAndStudent(@Param(value="courseId")Long courseId,
                                            @Param(value="studentId")Long studentId);

    int selectVacateCountByCourseAndStudent(@Param(value="courseId")Long courseId,
                                            @Param(value="studentId")Long studentId);
}