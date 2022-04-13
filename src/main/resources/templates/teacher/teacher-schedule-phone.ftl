<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="initial-scale=0.7,user-scalable=no"/>
        <title>教师课表</title>
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
        <link rel="stylesheet" href="../lib/layui/css/layui.css">
        <link rel="stylesheet" href="../css/common.css">
        <link rel="stylesheet" href="../css/schedulePhone.css">
    </head>
    <body style="background-color: #F1F1F1;">
        <#include "../common/header-teacher-phone.ftl"/>

        <div class="layui-card-body" id="timeFilter">
            <form class="layui-form" action="">
                <div class="layui-form-item">
                    第
                    <input type="text" id="week" required  lay-verify="required"
                           value="1" autocomplete="off" class="layui-input">
                    周
                    <a class="layui-btn layui-btn-primary"
                       lay-submit lay-filter="search" id="searchBtn">查询</a>
                </div>
            </form>
        </div>

        <div class="layui-card-body schedule">

            <div class="table layui-col-md2 sort">
                <div class="layui-row grid">
                    <div class="layui-col-md12">
                        <div class="grid2 layui-bg-green">
                            周
                        </div>
                    </div>
                    <#--<div class="layui-col-md6">
                        <div class="grid layui-bg-green" style="height: 12rem;line-height: 12rem;">
                            上午
                        </div>
                    </div>-->
                    <div class="layui-col-md6">
                        <div class="grid2 layui-bg-green">
                            第1节
                        </div>
                    </div>
                    <div class="layui-col-md6">
                        <div class="grid2 layui-bg-green">
                            第2节
                        </div>
                    </div>
                    <div class="layui-col-md6">
                        <div class="grid2 layui-bg-green">
                            第3节
                        </div>
                    </div>
                    <div class="layui-col-md6">
                        <div class="grid2 layui-bg-green">
                            第4节
                        </div>
                    </div>
                    <#--<div class="layui-col-md6">
                        <div class="grid layui-bg-green" style="height: 12rem;line-height: 12rem;">
                            下午
                        </div>
                    </div>-->
                    <div class="layui-col-md6">
                        <div class="grid2 layui-bg-green">
                            第5节
                        </div>
                    </div>
                    <div class="layui-col-md6">
                        <div class="grid2 layui-bg-green">
                            第6节
                        </div>
                    </div>
                    <div class="layui-col-md6">
                        <div class="grid2 layui-bg-green">
                            <table>
                                第7节
                            </table>
                        </div>
                    </div>
                    <div class="layui-col-md6">
                        <div class="grid2 layui-bg-green">
                            第8节
                        </div>
                    </div>
                </div>
            </div>

            <div class="table" id="timeTable"></div>
        </div>

        <script>
            window.onload = function () {
                var mo=function(e){e.preventDefault();};
                document.body.style.overflow='hidden';
                document.addEventListener("touchmove",mo,false);
                weekCourse(1);
            }

            $(function () {
                layui.use('form',function () {
                    var form = layui.form;
                    form.on('submit(search)',function (data) {
                        var week = $('#week').val();
                        weekCourse(week);
                    })
                })
            })

            $("#searchBtn").click(function () {
                var week = $("#week").val();
                weekCourse(week);
            })

            /*根据周数查找课程并显示*/
            function weekCourse(week) {
                $.ajax({
                    type: "post",
                    url: "/course/teacherWeekCourse",
                    dataType: "json",
                    data: {
                        teacherId: 1,
                        week: week
                    },
                    success: function (data) {
                        var courseWeekList = data;
                        var timeTableHtml = "";
                        for (var i = 1; i <= 5; i++) {
                            timeTableHtml += "<div class=\"table layui-col-md2 day" + i + "\">" +
                                "            <div class=\"layui-row grid\">";

                            timeTableHtml += "<div class=\"layui-col-md12\">\n" +
                                "                    <div class=\"grid2 layui-bg-green\">\n" +
                                "                        星期" + i + "\n" +
                                "                    </div>\n" +
                                "                </div>";
                            for (var j = 1; j <= 8; j++) {
                                var courseDetail = courseWeekList[i + "-" + j];
                                if (courseDetail != null) {
                                    timeTableHtml += "<div class=\"layui-col-md12 course\">" +
                                        "                    <div class=\"grid2\">" +
                                        courseDetail.name +
                                        "                    </div>" +
                                        "                </div>";
                                } else {
                                    timeTableHtml += "<div class=\"layui-col-md12 course\">" +
                                        "                    <div class=\"grid2\">" +
                                        "无" +
                                        "                    </div>" +
                                        "                </div>";
                                }
                            }
                            timeTableHtml += "</div>" +
                                "        </div>";

                        }
                        $("#timeTable").html(timeTableHtml);
                        $(".day1").css("width", "4rem");
                        $(".day1").css("position", "relative");
                        $(".day1").css("left", "3rem");
                        $(".day1").css("top", "-1.5rem");

                        $(".day2").css("width", "4rem");
                        $(".day2").css("position", "relative");
                        $(".day2").css("left", "7rem");
                        $(".day2").css("top", "-3rem");

                        $(".day3").css("width", "4rem");
                        $(".day3").css("position", "relative");
                        $(".day3").css("left", "11rem");
                        $(".day3").css("top", "-4.5rem");

                        $(".day4").css("width", "4rem");
                        $(".day4").css("position", "relative");
                        $(".day4").css("left", "15rem");
                        $(".day4").css("top", "-6rem");

                        $(".day5").css("width", "4rem");
                        $(".day5").css("position", "relative");
                        $(".day5").css("left", "19rem");
                        $(".day5").css("top", "-7.5rem");

                        $(".course").css("border-width", "1px");
                        $(".course").css("border-style", "solid");
                        $(".course").css("border-color", "#e2e2e2");
                        $(".schedule").css("height", "30rem");
                    }
                })
            }


        </script>
    </body>
</html>