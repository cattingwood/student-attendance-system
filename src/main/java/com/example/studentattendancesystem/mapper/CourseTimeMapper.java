package com.example.studentattendancesystem.mapper;

import com.example.studentattendancesystem.model.CourseTime;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CourseTimeMapper {
    int insert(CourseTime record);

    int insertSelective(CourseTime record);

    List<CourseTime> selectByCourseId(Long courseId);

    List<CourseTime> selectAll();
    List<CourseTime> getSameCourseTime(@Param(value="classId")Long classId,
                                       @Param(value="teacherId")Long teacherId,
                                       @Param(value="day")Integer day,
                                       @Param(value="time")Integer time,
                                       @Param(value="week")Integer week);

    List<CourseTime> getCourseTimeByAllId(@Param(value="courseId")Long courseId,
                                          @Param(value="teacherId")Long teacherId,
                                          @Param(value="classId")Long classId);

    List<CourseTime> getCourseTimeByTime(@Param(value="beginTime")int beginTime,
                                         @Param(value="endTime")int endTime,
                                         @Param(value="studentId")Long studentId);

    int deleteCourseTime(@Param(value="courseId")Long courseId,
                         @Param(value="classId")Long classId,
                         @Param(value="teacherId")Long teacherId);

    int selectCourseCountByStudentId(@Param(value="studentId")Long studentId,
                                     @Param(value="weekCount")Integer weekCount,
                                     @Param(value="dayCount")Integer dayCount);

    int selectCourseCountByCourseAndStudent(@Param(value="studentId")Long studentId,
                                            @Param(value="weekCount")Integer weekCount,
                                            @Param(value="dayCount")Integer dayCount,
                                            @Param(value="courseId")Long courseId);

}