<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>考勤统计</title>
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
        <script type="text/javascript" src="../js/echarts.js"></script>
        <link rel="stylesheet" href="../lib/layui/css/layui.css">
        <link rel="stylesheet" href="../css/common.css">
        <link rel="stylesheet" href="../css/signData.css">
    </head>
    <body style="background-color: #F1F1F1;">
        <#include "../common/header-admin.ftl"/>

        <div class="layui-card-body" id="timeFilter">
            <form class="layui-form" action="">
                <div class="layui-form-item">
                    <a class="layui-btn layui-btn-primary"
                       lay-submit lay-filter="search" id="searchBtn" onclick="getAllSignData()">统计所有考勤记录</a>
                    <a class="layui-btn layui-btn-primary"
                       lay-submit lay-filter="search" id="searchBtn" onclick="getSignDataByDepart()">根据学院统计考勤记录</a>
                </div>
                <div class="layui-form-item">

                </div>
                <div class="layui-input-inline">
                    <label class="layui-form-label">选择课程：</label>
                    <div class="layui-form layui-input-block" style="width: 10rem">
                        <select id="courseSelect" lay-filter="courseSelect">
                            <option value="-1">请选择课程</option>
                            <#if courseList??>
                                <#list courseList as cl>
                                    <option type="course" value="${cl.id}">${cl.name}</option>
                                </#list>
                            </#if>
                        </select>
                    </div>
                </div>
                <a class="layui-btn layui-btn-primary" onclick="getSignDataByCourse()">按照课程查询</a>
            </form>
        </div>

        <div class="layui-card-body signData">
            <div class="table" id="signData"></div>
        </div>

        <script>
            var nowCourse = -1;/*当前所选学院*/

            $(document).ready(function () {
                $(".layui-unselect").css("width","100%");
            })

            layui.use(['form'], function() {
                form = layui.form;
                form.on('select(courseSelect)', function (data) {
                    var CourseId = data.value;
                    nowCourse = CourseId;/*记录当前*/
                });
            })

            function getSignDataByDepart() {
                $.ajax({
                    type:"post",
                    url:"/sign/getSignDataByDepart",
                    dataType:"json",
                    success:function (res) {
                        var size =  res.size;
                        var html = "";
                        for(var i=0;i<size;i++){
                            html += "<div class=\"table signPie\" id=\"signData" + i + "\"></div>";
                        }
                        $(".signData").html(html);
                        for(var i=0;i<size;i++){
                            myChart(res[i].name,res[i],"signData" + i);
                        }
                        $(".signPie").css("display","inline-block");
                    }
                })
            }
            
            function getSignDataByCourse() {
                var courseId = parseInt(nowCourse);
                var courseName = $("option[type='course'][value=" + courseId +"]").html();
                $.ajax({
                    type:"post",
                    url:"/sign/getSignDataByCourse",
                    dataType:"json",
                    data: {
                        "courseId":courseId
                    },
                    success:function (res) {
                        $(".signData").html("<div class=\"table\" id=\"signData\"></div>");
                        myChart(courseName + '考勤统计图',res,"signData");
                    }
                })
            }

            function getAllSignData() {
                $.ajax({
                    type:"post",
                    url:"/sign/AllSignData",
                    dataType:"json",
                    success:function (res) {
                        $(".signData").html("<div class=\"table\" id=\"signData\"></div>");
                        myChart('考勤统计总图',res,"signData");
                    }
                })
            }

            /*name:统计图名,res:数据,elementId:dom元素id*/
            function myChart(name,res,elementId) {
                var data = res;
                // 基于准备好的dom，初始化echarts实例
                var signData = document.getElementById(elementId);
                //用于使chart自适应高度和宽度,通过窗体高宽计算容器高宽
                var resizeMainContainer = function () {
                    signData.style.width = window.innerWidth*0.3+'px';
                    signData.style.height = window.innerHeight*0.3+'px';
                };
                //设置div容器高宽
                resizeMainContainer();
                // 初始化图表
                var myChart = echarts.init(signData);
                $(window).on('resize',function(){//
                    //屏幕大小自适应，重置容器高宽
                    resizeMainContainer();
                    myChart.resize();
                });
                // 指定图表的配置项和数据
                var option = {
                    title: {
                        text: name
                    },
                    series: [{
                        name: ['签到','补签','请假','缺勤'],
                        type: 'pie',
                        data: [
                            {value:data["sign"], name:data["sign"]+'-签到'},
                            {value:data["resign"], name:data["resign"]+'-补签'},
                            {value:data["vacate"], name:data["vacate"]+'-请假'},
                            {value:data["absenceCount"], name:data["absenceCount"]+'-缺勤'}
                        ]
                    }]
                };
                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
            }

        </script>
    </body>
</html>