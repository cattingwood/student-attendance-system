<link rel="stylesheet" href="../lib/layui/css/layui.css">
<link rel="stylesheet" href="../css/common.css">
<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>


<div class="layui-header">
    <ul class="layui-nav header" style="background-color: #1A1B20;pointer-events: none">
        <li class="layui-nav-item">
            <span style="font-size: 23px">
                学生考勤系统
            </span>
            <span style="font-size: 13px">-学生版</span>
        </li>
    </ul>
</div>


<div class="layui-side" style="top: 60px">
    <div class="layui-side-scroll" style="background-color: #1A1B20">
    <ul class="layui-nav layui-nav-tree side" style="background-color: #1A1B20">
        <li class="layui-nav-item layui-this" name="toSign"><a href="/sign/toSign">考勤</a></li>
        <li class="layui-nav-item" name="toStudentVacate"><a href="/sign/toStudentVacate">请假</a></li>
        <li class="layui-nav-item" name="toSchedule"><a href="/course/toTimeTable">课表</a></li>
        <li class="layui-nav-item" name="toSignData"><a href="/sign/toSignData">考勤统计</a></li>
    </ul>
    </div>
</div>
<script>
    $(document).ready(function () {
        var menuFlag = '${menuFlag}';
        if(menuFlag != null){
            $(".side li").each(function(index){
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


<div id="dg" style="z-index: 9999; position: fixed ! important; right: 50px; bottom: 100px;">
    <table width=""100% style="position: absolute; width:260px; right: 50px; bottom: 100px;">
        <button class="layui-btn layui-btn-radius" onclick="evaluate()" style="">
            <i class="layui-icon">&#xe6b2;</i>评价
        </button>
    </table>
</div>

<div hidden>

</div>
<script>
    function evaluate() {

    }
</script>