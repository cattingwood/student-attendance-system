<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>学生签到统计</title>
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
        <script type="text/javascript" src="../js/echarts.js"></script>
        <link rel="stylesheet" href="../lib/layui/css/layui.css">
        <link rel="stylesheet" href="../css/common.css">
        <link rel="stylesheet" href="../css/signData.css">
    </head>
    <body style="background-color: #F1F1F1;">
        <#include "../common/header-student.ftl"/>

        <div class="layui-card-body" id="timeFilter">
            <form class="layui-form" action="">
                <div class="layui-form-item">
                    <a class="layui-btn layui-btn-primary"
                       lay-submit lay-filter="search" id="searchBtn" onclick="getAllSignData()">查询所有签到记录</a>
                </div>
                <div class="layui-form-item">
                    第
                    <input type="text" id="week" required  lay-verify="required"
                           value="1" autocomplete="off" class="layui-input">
                    周考勤记录
                    <a class="layui-btn layui-btn-primary"
                       lay-submit lay-filter="search" id="searchBtn" onclick="getSignDataByWeek()">按照周数查询</a>
                </div>
                <div class="layui-input-inline">
                    <label class="layui-form-label">选择课程：</label>
                    <div class="layui-form layui-input-block">
                        <select id="courseSelect" lay-filter="courseSelect">
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
            <div class="table" id="timeTable"></div>
        </div>

        <script>
            var nowCourse = 1;/*当前所选课程*/

            $(document).ready(function(){
                $('.layui-input.layui-unselect').css("width","13rem");
            });

            layui.use(['form'], function() {
                form = layui.form;
                form.on('select(courseSelect)', function (data) {
                    var CourseId = data.value;
                    nowCourse = CourseId;/*记录当前*/
                });
            })

            function getSignDataByWeek() {
                var week = $("#week").val();
                $.ajax({
                    type:"post",
                    url:"/sign/getSignRecordByWeekAndStudent",
                    dataType:"json",
                    data: {
                        "week":week
                    },
                    success:function (res) {
                        console.log(res.courseDetailListTree);
                        var courseWeekList = res.courseDetailListTree;
                        var signDetailList = res.signDetailListTree;
                        var timeTableHtml = "";
                        for (var i = 1; i <= 5; i++) {
                            timeTableHtml += "<div class=\"table layui-col-md2\">" +
                                "            <div class=\"layui-row grid\">";

                            timeTableHtml += "<div class=\"layui-col-md12\">\n" +
                                "                    <div class=\"grid2 layui-bg-green\">\n" +
                                "                        星期" + i + "\n" +
                                "                    </div>\n" +
                                "                </div>";
                            for (var j = 1; j <= 10; j++) {
                                var courseDetail = courseWeekList[i + "-" + j];
                                var signDetail = signDetailList[i + "-" + j];
                                if (courseDetail != null) {
                                    timeTableHtml += "<div class=\"layui-col-md12 course\">" +
                                        "                    <div class=\"grid2\" style=\"height: 2.87rem;\" >" +
                                        courseDetail.name;
                                    if(signDetail != null){
                                        if(signDetail.type == 1){
                                            timeTableHtml += "   已签到"
                                        }else if(signDetail.type == 2 && signDetail.status == 1){
                                            timeTableHtml += "   已补签"
                                        }else if(signDetail.type == 2 && signDetail.status == 0){
                                            timeTableHtml += "   补签待确认"
                                        }else if(signDetail.type == 3){
                                            timeTableHtml += "   请假"
                                        }
                                    }else {
                                            timeTableHtml += "   旷课"
                                    }
                                    timeTableHtml +=  "                    </div>" +
                                        "                </div>";
                                } else {
                                    timeTableHtml += "<div class=\"layui-col-md12 course\">" +
                                        "                    <div class=\"grid2\" style=\"height: 2.87rem;\" >" +
                                        "无" +
                                        "                    </div>" +
                                        "                </div>";
                                }
                            }
                            timeTableHtml += "</div>" +
                                "        </div>";

                        }
                        $("#timeTable").html(timeTableHtml);
                        $(".course").css("border-width", "1px");
                        $(".course").css("border-style", "solid");
                        $(".course").css("border-color", "#e2e2e2");
                        $(".signData").css("height", $(".table").css("height"));
                    }
                })
            }

            function getSignDataByCourse() {
                var courseId = parseInt(nowCourse);
                var courseName = $("option[type='course'][value=" + courseId +"]").html();
                $.ajax({
                    type:"post",
                    url:"/sign/getSignDataByCourseAndStudent",
                    dataType:"json",
                    data: {
                        "courseId":courseId
                    },
                    success:function (res) {
                        var data = res;
                        // 基于准备好的dom，初始化echarts实例
                        var signData = document.getElementById('signData');
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
                                text: courseName + '考勤统计图'
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
                })
            }

            function getAllSignData() {
                $.ajax({
                    type:"post",
                    url:"/sign/StudentSignData",
                    dataType:"json",
                    success:function (res) {
                        var data = res;
                        // 基于准备好的dom，初始化echarts实例
                        var signData = document.getElementById('signData');
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
                                text: '考勤统计总图'
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
                })
            }

        </script>
    </body>
</html>