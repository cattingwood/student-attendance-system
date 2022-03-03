<link rel="stylesheet" href="../lib/layui/css/layui.css">
<link rel="stylesheet" href="../css/common.css">

<div class="layui-header">
    <ul class="layui-nav header" style="background-color: #1A1B20">
        <li class="layui-nav-item">
            <a style="font-size: 23px">
                学生考勤系统
            </a>
        </li>
    </ul>
</div>


<div class="layui-side" style="top: 60px">
    <div class="layui-side-scroll" style="background-color: #1A1B20">
    <ul class="layui-nav layui-nav-tree side" style="background-color: #1A1B20">
        <li class="layui-nav-item layui-this" name="toSign"><a href="/sign/toSign">考勤</a></li>
        <li class="layui-nav-item" name="toSchedule"><a href="/course/toTimeTable">课表</a></li>
        <li class="layui-nav-item" name=""><a href="">导航</a></li>
        <li class="layui-nav-item" name=""><a href="">个人中心</a></li>
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
