<link rel="stylesheet" href="../lib/layui/css/layui.css">
<link rel="stylesheet" href="../css/common.css">
<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>


<div class="layui-header">
    <ul class="layui-nav header" style="background-color: #1A1B20;pointer-events: none">
        <li class="layui-nav-item">
            <span style="font-size: 2.3rem;">
                学生考勤系统
            </span>
            <span style="font-size: 1.3rem;">-教师版</span>
        </li>
    </ul>
</div>


<div class="layui-header">
    <ul class="layui-nav header" style="background-color: #1A1B20">
        <li class="layui-nav-item" name="toTeacherCoursePhone"><a href="/course/toTeacherCoursePhone" style="font-size: 1.7rem;">课表</a></li>
        <li class="layui-nav-item" name="toTeacherResignPhone"><a href="/sign/toTeacherResignPhone" style="font-size: 1.7rem;">补签处理</a></li>
        <li class="layui-nav-item" name="toTeacherVacateCheckPhone"><a href="/sign/toTeacherVacateCheckPhone" style="font-size: 1.7rem;">学生请假记录</a></li>
    </ul>
</div>
<script>
    $(document).ready(function () {
        var menuFlag = '${menuFlag}';
        $(".header li").each(function(index){
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
