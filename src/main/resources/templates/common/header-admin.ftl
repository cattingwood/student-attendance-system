<link rel="stylesheet" href="../lib/layui/css/layui.css">
<link rel="stylesheet" href="../css/common.css">
<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>

<div class="layui-header">
    <ul class="layui-nav header" style="background-color: #1A1B20;pointer-events: none;position: fixed;width: 100%">
        <li class="layui-nav-item">
            <span style="font-size: 23px">
                学生考勤系统
            </span>
            <span style="font-size: 13px">-管理员版</span>
        </li>
    </ul>
</div>


<div class="layui-side" style="top: 60px">
    <div class="layui-side-scroll" style="background-color: #1A1B20">
    <ul class="layui-nav layui-nav-tree side" style="background-color: #1A1B20">
        <li class="layui-nav-item" name="toMajorManage"><a href="/major/toMajorManage">专业管理</a></li>
        <li class="layui-nav-item" name="toStudentManage"><a href="/student/toStudentManage">学生管理</a></li>
        <li class="layui-nav-item" name="toTeacherManage"><a href="/teacher/toTeacherManage">教师管理</a></li>
        <li class="layui-nav-item" name="toCourseManage"><a href="/course/toCourseManage">课程管理</a></li>
        <li class="layui-nav-item" name="toCourseTimeManage"><a href="/courseTime/toCourseTimeManage">课表时间管理</a></li>
        <li class="layui-nav-item" name="toSignRecordManage"><a href="/sign/toSignRecordManage">考勤记录管理</a></li>
        <li class="layui-nav-item" name="toAllSignData"><a href="/sign/toAllSignData">考勤统计</a></li>
        <li class="layui-nav-item" name="toEvaluateRecord"><a href="/evaluate/toEvaluateRecord">评价记录查询</a></li>
    </ul>
    </div>
</div>
<script>
    $(document).ready(function () {
        var menuFlag = '${menuFlag}';
        $(".side li").each(function(index){
            $(this).removeClass("layui-this");
            if(menuFlag == $(this).attr("name")){
                $(this).addClass("layui-this");
                return;
            }
        });
    });

    function timeTable(){
        window.location.href = '/course/toTimeTable';
    }


</script>

<#include "../common/evaluate.ftl"/>