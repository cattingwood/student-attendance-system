<link rel="stylesheet" href="../lib/layui/css/layui.css">
<link rel="stylesheet" href="../css/common.css">
<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>


<div class="layui-header" style="width: 70%">
    <ul class="layui-nav header" style="background-color: #1A1B20;pointer-events: none">
        <li class="layui-nav-item">
            <span style="font-size: 2.3rem;">
                学生考勤系统
            </span>
            <span style="font-size: 1.3rem;">-学生版</span>
        </li>
    </ul>
</div>


<div class="layui-header" style="width: 70%">
    <ul class="layui-nav header" style="background-color: #1A1B20">
        <li class="layui-nav-item layui-this" name="toSignPhone"><a href="/sign/toSignPhone" style="font-size: 1.7rem;">考勤</a></li>
        <li class="layui-nav-item" name="toStudentVacatePhone"><a href="/sign/toStudentVacatePhone" style="font-size: 1.7rem;">请假</a></li>
        <li class="layui-nav-item" name="toSchedulePhone"><a href="/course/toTimeTablePhone" style="font-size: 1.7rem;">课表</a></li>
        <li class="layui-nav-item" name="toSignDataPhone"><a href="/sign/toSignDataPhone" style="font-size: 1.7rem;">考勤统计</a></li>
    </ul>
    </div>
</div>
<script>
    $(document).ready(function () {
        var menuFlag = '${menuFlag}';
        if(menuFlag != null){
            $(".header li").each(function(index){
                $(this).removeClass("layui-this");
                if(menuFlag == $(this).attr("name")){
                    $(this).addClass("layui-this");
                    return;
                }
            });
        }else{
            console.log("menuFlag为空！");
        }

    });

    function timeTable(){
        window.location.href = '/course/toTimeTable';
    }


</script>
