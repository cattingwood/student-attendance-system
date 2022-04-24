<link rel="stylesheet" href="../lib/layui/css/layui.css">
<link rel="stylesheet" href="../css/common.css">
<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>


<div class="layui-header">
    <ul class="layui-nav header" style="background-color: #1A1B20;pointer-events: none">
        <li class="layui-nav-item">
            <span style="font-size: 23px">
                学生考勤系统
            </span>
            <span style="font-size: 13px">-教师版</span>
        </li>
    </ul>
</div>


<div class="layui-side" style="top: 60px">
    <div class="layui-side-scroll" style="background-color: #1A1B20">
    <ul class="layui-nav layui-nav-tree side" style="background-color: #1A1B20">
        <li class="layui-nav-item" name="toTeacherCourse"><a href="/course/toTeacherCourse">课表</a></li>
        <li class="layui-nav-item" name="toTeacherResign"><a href="/sign/toTeacherResign">补签处理</a></li>
        <li class="layui-nav-item" name="toTeacherVacateCheck"><a href="/sign/toTeacherVacateCheck">学生请假记录</a></li>
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