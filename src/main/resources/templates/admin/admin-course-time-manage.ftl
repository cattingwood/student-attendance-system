<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>排课管理</title>
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
        <link rel="stylesheet" href="../lib/layui/css/layui.css">
        <link rel="stylesheet" href="../css/common.css">
        <link rel="stylesheet" href="../css/schedule.css">
        <script src="https://eqcn.ajz.miesnfu.com/wp-content/plugins/wp-3d-pony/live2dw/lib/L2Dwidget.min.js"></script>
    </head>
    <body style="background-color: #F1F1F1;">
        <#include "../common/header-admin.ftl"/>

        <div class="layui-card-body" id="filter">
            <div class="layui-form">
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: auto;">学院</label>
                    <div class="layui-form layui-input-inline">
                        <select id="departmentSelect" lay-filter="departmentSelect">
                            <option value="-1">请选择</option>
                            <#if departmentList??>
                                <#list departmentList as dl>
                                    <option value="${dl.id}">${dl.name}</option>
                                </#list>
                            </#if>
                        </select>
                    </div>
                </div>

                <div class="layui-input-inline">
                    <label class="layui-form-label">专业</label>
                    <div class="layui-form layui-input-block">
                        <select id="majorSelect" lay-filter="majorSelect">
                            <option value="-1">请先选择学院</option>
                        </select>
                    </div>
                </div>

                <div class="layui-input-inline">
                    <label class="layui-form-label">班级</label>
                    <div class="layui-form layui-input-block" lay-filter="classSelect">
                        <select id="classSelect" lay-filter="classSelect">
                            <option value="-1">请先选择专业</option>
                        </select>
                    </div>
                </div>
                <button class="layui-btn js-search" onclick="searchCourseTime()"><i class="layui-icon">&#xe615;</i></button>
                <button class="layui-btn" onclick="addCourseTimeWindow()">新增排课</button>
            </div>
        </div>

        <select id="majorSelectHidden" hidden>
            <#if majorList??>
                <#list majorList as ml>
                    <option value="${ml.id}" departmentIdHidden="${ml.departmentId}">${ml.name}</option>
                </#list>
            </#if>
        </select>

        <select id="classSelectHidden" hidden>
            <#if classList??>
                <#list classList as cl>
                    <option value="${cl.id}" majorIdHidden="${cl.majorId}">${cl.name}</option>
                </#list>
            </#if>
        </select>

        <div class="layui-card-body schedule">
            <div class="table" id="courseTable"></div>
        </div>

        <div hidden id="addCourseTime">
            <div style="margin: 50px;width: 500px;">
                <form class="layui-form" action="">
                    <div class="layui-form-item">
                        <label class="layui-form-label">课程</label>
                        <div class="layui-input-block">
                            <select id="courseAdd" lay-filter="courseAdd" lay-search>
                                <option value="-1">请选择</option>
                                <#if courseList??>
                                    <#list courseList as cl>
                                        <option value="${cl.id}">${cl.name}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">教师</label>
                        <div class="layui-input-block">
                            <select id="teacherAdd" lay-filter="teacherAdd" lay-search>
                                <option value="-1">请选择</option>
                                <#if teacherList??>
                                    <#list teacherList as tl>
                                        <option value="${tl.id}">${tl.name}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">星期</label>
                        <div class="layui-input-block">
                            <select id="dayAdd" lay-filter="dayAdd">
                                <option value="-1">请选择</option>
                                <option value="1">星期一</option>
                                <option value="2">星期二</option>
                                <option value="3">星期三</option>
                                <option value="4">星期四</option>
                                <option value="5">星期五</option>
                                <option value="6">星期六</option>
                                <option value="7">星期日</option>
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">班级</label>
                        <div class="layui-input-block">
                            <select id="classAdd" lay-filter="classAdd" lay-search>
                                <option value="-1">请选择</option>
                                <#if classList??>
                                    <#list classList as cl>
                                        <option value="${cl.id}">${cl.name}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">节数</label>
                        <div class="layui-input-block">
                            <input type="checkbox" name="time" lay-skin="primary" value="1" title="第一节">
                            <input type="checkbox" name="time" lay-skin="primary" value="2" title="第二节">
                            <input type="checkbox" name="time" lay-skin="primary" value="3" title="第三节">
                            <input type="checkbox" name="time" lay-skin="primary" value="4" title="第四节">
                            <input type="checkbox" name="time" lay-skin="primary" value="5" title="第五节">
                            <input type="checkbox" name="time" lay-skin="primary" value="6" title="第六节">
                            <input type="checkbox" name="time" lay-skin="primary" value="7" title="第七节">
                            <input type="checkbox" name="time" lay-skin="primary" value="8" title="第八节">
                            <input type="checkbox" name="time" lay-skin="primary" value="9" title="第九节">
                            <input type="checkbox" name="time" lay-skin="primary" value="10" title="第十节">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">周数</label>
                        <div class="layui-input-block">
                            <input type="checkbox" name="week" lay-skin="primary" value="1" title="第1周">
                            <input type="checkbox" name="week" lay-skin="primary" value="2" title="第2周">
                            <input type="checkbox" name="week" lay-skin="primary" value="3" title="第3周">
                            <input type="checkbox" name="week" lay-skin="primary" value="4" title="第4周">
                            <input type="checkbox" name="week" lay-skin="primary" value="5" title="第5周">
                            <input type="checkbox" name="week" lay-skin="primary" value="6" title="第6周">
                            <input type="checkbox" name="week" lay-skin="primary" value="7" title="第7周">
                            <input type="checkbox" name="week" lay-skin="primary" value="8" title="第8周">
                            <input type="checkbox" name="week" lay-skin="primary" value="9" title="第9周">
                            <input type="checkbox" name="week" lay-skin="primary" value="10" title="第10周">
                            <input type="checkbox" name="week" lay-skin="primary" value="11" title="第11周">
                            <input type="checkbox" name="week" lay-skin="primary" value="12" title="第12周">
                            <input type="checkbox" name="week" lay-skin="primary" value="13" title="第13周">
                            <input type="checkbox" name="week" lay-skin="primary" value="14" title="第14周">
                            <input type="checkbox" name="week" lay-skin="primary" value="15" title="第15周">
                            <input type="checkbox" name="week" lay-skin="primary" value="16" title="第16周">
                            <input type="checkbox" name="week" lay-skin="primary" value="17" title="第17周">
                            <input type="checkbox" name="week" lay-skin="primary" value="18" title="第18周">
                            <input type="checkbox" name="week" lay-skin="primary" value="19" title="第19周">
                            <input type="checkbox" name="week" lay-skin="primary" value="20" title="第20周">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">操作</label>
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" onclick="allWeekSelected()">全选</button>
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" onclick="singleWeekSelected()">单周</button>
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" onclick="doubleWeekSelected()">双周</button>
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" onclick="allWeekNotSelected()">全不选</button>
                    </div>

                    <div class="layui-btn"  onclick="addCourseTime()">添加排课</div>
                </form>
            </div>
        </div>

        <div hidden id="editCourseTime">
            <div style="margin: 50px;width: 500px;">
                <form class="layui-form" action="">
                    <div class="layui-form-item">
                        <label class="layui-form-label">课程</label>
                        <div class="layui-input-block">
                            <select id="courseEdit" lay-filter="courseEdit" lay-search disabled>
                                <option value="-1">请选择</option>
                                <#if courseList??>
                                    <#list courseList as cl>
                                        <option value="${cl.id}">${cl.name}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">教师</label>
                        <div class="layui-input-block">
                            <select id="teacherEdit" lay-filter="teacherEdit" lay-search disabled>
                                <option value="-1">请选择</option>
                                <#if teacherList??>
                                    <#list teacherList as tl>
                                        <option value="${tl.id}">${tl.name}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">班级</label>
                        <div class="layui-input-block">
                            <select id="classEdit" lay-filter="classEdit" lay-search disabled>
                                <option value="-1">请选择</option>
                                <#if classList??>
                                    <#list classList as cl>
                                        <option value="${cl.id}">${cl.name}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">星期</label>
                        <div class="layui-input-block">
                            <select id="dayEdit" lay-filter="dayEdit">
                                <option value="-1">请选择</option>
                                <option value="1">星期一</option>
                                <option value="2">星期二</option>
                                <option value="3">星期三</option>
                                <option value="4">星期四</option>
                                <option value="5">星期五</option>
                                <option value="6">星期六</option>
                                <option value="7">星期日</option>
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">节数</label>
                        <div class="layui-input-block">
                            <input type="checkbox" name="timeEdit" lay-skin="primary" value="1" title="第一节">
                            <input type="checkbox" name="timeEdit" lay-skin="primary" value="2" title="第二节">
                            <input type="checkbox" name="timeEdit" lay-skin="primary" value="3" title="第三节">
                            <input type="checkbox" name="timeEdit" lay-skin="primary" value="4" title="第四节">
                            <input type="checkbox" name="timeEdit" lay-skin="primary" value="5" title="第五节">
                            <input type="checkbox" name="timeEdit" lay-skin="primary" value="6" title="第六节">
                            <input type="checkbox" name="timeEdit" lay-skin="primary" value="7" title="第七节">
                            <input type="checkbox" name="timeEdit" lay-skin="primary" value="8" title="第八节">
                            <input type="checkbox" name="timeEdit" lay-skin="primary" value="9" title="第九节">
                            <input type="checkbox" name="timeEdit" lay-skin="primary" value="10" title="第十节">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">周数</label>
                        <div class="layui-input-block">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="1" title="第1周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="2" title="第2周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="3" title="第3周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="4" title="第4周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="5" title="第5周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="6" title="第6周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="7" title="第7周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="8" title="第8周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="9" title="第9周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="10" title="第10周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="11" title="第11周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="12" title="第12周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="13" title="第13周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="14" title="第14周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="15" title="第15周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="16" title="第16周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="17" title="第17周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="18" title="第18周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="19" title="第19周">
                            <input type="checkbox" name="weekEdit" lay-skin="primary" value="20" title="第20周">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">操作</label>
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" onclick="allWeekSelected()">全选</button>
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" onclick="singleWeekSelected()">单周</button>
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" onclick="doubleWeekSelected()">双周</button>
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" onclick="allWeekNotSelected()">全不选</button>
                    </div>

                    <div class="layui-btn"  onclick="editCourseTime()">编辑排课</div>
                </form>
            </div>
        </div>

        <!-- L2Dwidget.js L2D网页动画人物 -->
        <script>
            L2Dwidget.init({
                "model": { "jsonPath":"https://unpkg.com/live2d-widget-model-miku@1.0.5/assets/miku.model.json", "scale": 1, "hHeadPos":0.5, "vHeadPos":0.618 },
                "display": { "position": "left", "width": 100, "height": 200, "hOffset": 0, "vOffset": 0 },
                "mobile": { "show": true, "scale": 0.5 },
                "react": { "opacityDefault": 1, "opacityOnHover": 0.2 }
            });
        </script>
        <!--
            其他可选的模型：
                小帅哥： https://unpkg.com/live2d-widget-model-chitose@1.0.5/assets/chitose.model.json
                萌娘：https://unpkg.com/live2d-widget-model-shizuku@1.0.5/assets/shizuku.model.json
                小可爱（女）：https://unpkg.com/live2d-widget-model-koharu@1.0.5/assets/koharu.model.json
                小可爱（男）：https://unpkg.com/live2d-widget-model-haruto@1.0.5/assets/haruto.model.json
                初音：https://unpkg.com/live2d-widget-model-miku@1.0.5/assets/miku.model.json
        -->

        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-primary layui-btn-xs" onclick="editCourse()">编辑</a>
            <a class="layui-btn layui-btn-xs" onclick="deleteCourse()">删除</a>
        </script>

        <script>
            var nowDepartment = -1;/*当前所选学院*/
            var nowMajor = -1;/*当前所选专业*/
            var nowClass = -1;/*当前所选班级*/
            var updateMajor = -1;/*新增课程时所选专业*/

            /*初始化*/
            window.onload = function () {
                var table = layui.table;
                var form = layui.form;

                layui.use(['form'], function(){
                    form = layui.form;
                    // 监听select切换事件

                    //根据所选学院显示专业
                    form.on('select(departmentSelect)',function(data){
                        var majorList = "<option value='-1'>请选择</option>";
                        var departmentId = data.value;
                        nowDepartment = departmentId;
                        nowMajor = -1;
                        nowClass = -1;/*存储当前选择情况*/
                        $('option[departmentIdHidden=' + departmentId + ']').each(function (i) {
                            if($(this).parent().attr('id') == "majorSelectHidden"){/*只从事先准备好的列表获取 防止重复*/
                                majorList += this.outerHTML;
                            }
                        });
                        $("#majorSelect").html(majorList);
                        $("#classSelect").html("");
                        form.render('select');
                    });
                    //根据所选专业显示班级
                    form.on('select(majorSelect)', function(data){
                        var classList = "<option value='-1'>请选择</option>";
                        var majorId = data.value;
                        nowMajor = majorId;
                        nowClass = -1;/*存储当前选择情况*/
                        $('option[majorIdHidden=' + majorId + ']').each(function (i) {
                            if($(this).parent().attr('id') == "classSelectHidden"){/*只从事先准备好的列表获取 防止重复*/
                                classList += this.outerHTML;
                            }
                        });
                        $("#classSelect").html(classList);
                        form.render('select',"classSelect");
                    });
                    //记录所选班级
                    form.on('select(classSelect)', function(data){
                        nowClass = data.value;
                    });
                    //根据是否为公共课选择专业
                    form.on('select(isPublic)', function(data){
                        var isPublic = data.value;
                        if(isPublic == 1){
                            $("#majorUpdate").attr("disabled","disabled");
                            form.render('select');
                        }else{
                            $("#majorUpdate").removeAttr("disabled");
                            form.render('select');
                        }
                    });
                    //记录新增课程时所选专业
                    form.on('select(majorUpdate)', function(data){
                        updateMajor = data.value;
                    });

                });

            }

            function allWeekSelected() {
                $("input[name='week']").attr("checked", true);
                layui.use(['form'],function() {/*重新渲染*/
                    var form=layui.form;
                    form.render("checkbox");
                });
            }

            function singleWeekSelected() {
                $("input[name='week']").each(function () {
                    if(parseInt($(this).val())%2 != 0){
                        $(this).attr("checked", true);
                    }else{
                        $(this).attr("checked", false);
                    }
                })
                layui.use(['form'],function() {/*重新渲染*/
                    var form=layui.form;
                    form.render("checkbox");
                });
            }

            function doubleWeekSelected() {
                $("input[name='week']").each(function () {
                    if(parseInt($(this).val())%2 == 0){
                        $(this).attr("checked", true);
                    }else{
                        $(this).attr("checked", false);
                    }
                })
                layui.use(['form'],function() {/*重新渲染*/
                    var form=layui.form;
                    form.render("checkbox");
                });
            }

            function allWeekNotSelected() {
                $("input[name='week']").attr("checked", false);
                layui.use(['form'],function() {/*重新渲染*/
                    var form=layui.form;
                    form.render("checkbox");
                });
            }

            /*根据下拉框值查找课程*/
            function searchCourseTime() {
                if(nowClass != -1){
                    classCourse(nowClass);
                }else if(nowMajor != -1){
                    majorCourse(nowMajor);
                }else if(nowMajor != -1){
                    departmentCourse(nowDepartment);
                }else{
                    allCourseTime();
                }
            }

            /*弹出添加排课窗口*/
            function addCourseTimeWindow(){
                var layer = layui.layer;
                layer.open({
                    type: 1,
                    title: '新增排课',
                    area: ['40%', '70%'],//弹框大小  屏幕宽度的80%，高度的80%；
                    content: $("#addCourseTime"),
                    // 打开弹窗的回调函数，用于回显页面数据
                    success: function () {
                    },
                    end: function () {
                        $("#addCourseTime").hide();
                    }
                })
            }

            /*添加课程*/
            function addCourseTime(){
                var courseId = parent.$('#courseAdd').val();
                if (courseId == -1) {
                    layer.alert("请选择课程! ");
                    return false;
                }
                var teacherId = parent.$('#teacherAdd').val();
                if (teacherId == -1) {
                    layer.alert("请选择教师! ");
                    return false;
                }
                var classId = parent.$('#classAdd').val();
                if (classId == -1) {
                    layer.alert("请选择班级! ");
                    return false;
                }
                var day = parent.$('#dayAdd').val();
                if (day == -1) {
                    layer.alert("请选择星期! ");
                    return false;
                }
                var time = "";
                var week = "";
                $('input[type=checkbox]:checked').each(function() {
                    if($(this).attr("name") == "time"){
                        time += $(this).val() + ","
                    }else if($(this).attr("name") == "week"){
                        week += $(this).val() + ","
                    }
                });

                if(time.length == 0){
                    layer.alert("请选择节数! ");
                    return false;
                }

                if(week.length == 0){
                    layer.alert("请选择周数! ");
                    return false;
                }

                time = time.slice(0,time.length-1)
                week = week.slice(0,week.length-1)

                $.post("/courseTime/addCourseTime", {
                    "courseId": courseId,
                    "teacherId": teacherId,
                    "classId": classId,
                    "day": day,
                    "time": time,
                    "week": week
                }, function (res) {
                    if(res == -1){
                        layer.alert("已有重复排课! ");
                    }else if(res == 1){
                        layer.close(layer.index);
                        layer.alert("添加成功! ");
                    }
                });
            }

            /*编辑课程排课信息*/
            function editCourseTimeWindow(courseId,teacherId,classId){
                var layer = layui.layer;
                layer.open({
                    type: 1,
                    title: '更新排课',
                    area: ['40%', '70%'],//弹框大小  屏幕宽度的80%，高度的80%；
                    content: $("#editCourseTime"),
                    // 打开弹窗的回调函数，用于回显页面数据
                    success: function () {
                        $.post("/courseTime/getCourseTimeByAllId", {
                            "courseId": courseId,
                            "teacherId": teacherId,
                            "classId": classId,
                        }, function (res){
                            $("input[name='timeEdit']").removeAttr("checked");/*清除之前编辑的内容*/
                            $("input[name='weekEdit']").removeAttr("checked");
                            $("#courseEdit").find("option[value="+res[0].courseId+"]").attr("selected",'').siblings().removeAttr("selected");
                            $("#teacherEdit").find("option[value="+res[0].teacherId+"]").attr("selected",'').siblings().removeAttr("selected");
                            $("#dayEdit").find("option[value="+res[0].courseDay+"]").attr("selected",'').siblings().removeAttr("selected");
                            $("#classEdit").find("option[value="+res[0].classId+"]").attr("selected",'').siblings().removeAttr("selected");
                            for(var i=0;i<res.length;i++){
                                $("input[name='timeEdit'][value=" + res[i].courseSort + "]").attr("checked",true);
                                $("input[name='weekEdit'][value=" + res[i].courseWeek + "]").attr("checked",true);
                            }
                            layui.form.render();
                        });
                    },
                    end: function () {
                        $("#editCourseTime").hide();
                    }
                })
            }

            function editCourseTime(){
                var courseId = parent.$('#courseEdit').val();
                if (courseId == -1) {
                    layer.alert("请选择课程! ");
                    return false;
                }
                var teacherId = parent.$('#teacherEdit').val();
                if (teacherId == -1) {
                    layer.alert("请选择教师! ");
                    return false;
                }
                var classId = parent.$('#classEdit').val();
                if (classId == -1) {
                    layer.alert("请选择班级! ");
                    return false;
                }
                var day = parent.$('#dayEdit').val();
                if (day == -1) {
                    layer.alert("请选择星期! ");
                    return false;
                }
                var time = "";
                var week = "";
                $('input[type=checkbox]:checked').each(function() {
                    if($(this).attr("name") == "timeEdit"){
                        time += $(this).val() + ","
                    }else if($(this).attr("name") == "weekEdit"){
                        week += $(this).val() + ","
                    }
                });

                if(time.length == 0){
                    layer.alert("请选择节数! ");
                    return false;
                }

                if(week.length == 0){
                    layer.alert("请选择周数! ");
                    return false;
                }

                time = time.slice(0,time.length-1)
                week = week.slice(0,week.length-1)

                $.post("/courseTime/editCourseTime", {
                    "courseId": courseId,
                    "teacherId": teacherId,
                    "classId": classId,
                    "day": day,
                    "time": time,
                    "week": week
                }, function (res) {
                    if(res == -1){
                        layer.alert("已有重复排课! ");
                    }else if(res == 1){
                        layer.close(layer.index);
                        layer.alert("更新成功! ");
                    }
                });
            }

            /*删除课程*/
            function deleteCourse(courseName,teacherName,className,courseId,teacherId,classId){
                layer.open({
                    title: '删除排课'
                    ,content: '是否删除该项排课？<br>' + '课程：' + courseName
                                    + '<br>教师：' + teacherName + '<br>班级：' + className
                    ,btn: ['是', '否']
                    ,yes: function(index){
                        $.post("/courseTime/deleteCourseTime", {
                                "courseId": courseId,
                                "teacherId": teacherId,
                                "classId": classId
                        }, function (res){
                            if(res >= 1){
                                layer.open({
                                    title: false
                                    ,content: '删除成功！'
                                });
                            }
                        });
                    }
                    ,btn2: function(index){
                    }
                });
            }

            /*根据班级查找课程并显示*/
            function classCourse(classId) {
                layui.use('table', function(){
                    table = layui.table;
                    table.render({
                        elem: '#courseTable'
                        ,height: 450
                        ,url: '/course/ClassCourse?classId='+classId //数据接口
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code": 0, //解析接口状态
                                "msg": '成功', //解析提示文本
                                "count": res.total, //解析数据长度
                                "data": res //解析数据列表
                            };
                        }
                        ,page: true //开启分页
                        ,cols: [[ //表头
                            {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
                            ,{field: 'name', title: '课程名', width:200}
                            ,{field: 'isPublic', title: '公共课', width:80,
                                templet:function (res) {
                                    if (res.isPublic === 1) {
                                        return '是';
                                    } else {
                                        return '否';
                                    }
                                }
                            }
                            ,{field: 'isRequired', title: '必修课', width:80,
                                templet:function (res) {
                                    if (res.isRequired === 1) {
                                        return '是';
                                    } else {
                                        return '否';
                                    }
                                }
                            }
                            , {field: '',width: 250, title: '操作',
                                templet: function (res) {
                                    var ops = "<button class=\"layui-btn layui-btn layui-btn-xs\" title=\"编辑\" onclick=\"editCourse('" + res.id + "')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe642;</i>排课编辑</button> &nbsp;&nbsp;";
                                    return ops ;
                                }
                            }
                        ]]
                    });
                });
            }

            /*根据专业查找课程并显示*/
            function majorCourse(majorId) {
                layui.use('table', function(){
                    table = layui.table;
                    table.render({
                        elem: '#courseTable'
                        ,height: 450
                        ,url: '/course/MajorCourse?majorId='+majorId //数据接口
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code": 0, //解析接口状态
                                "msg": '成功', //解析提示文本
                                "count": res.total, //解析数据长度
                                "data": res //解析数据列表
                            };
                        }
                        ,page: true //开启分页
                        ,cols: [[ //表头
                            {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
                            ,{field: 'name', title: '课程名', width:200}
                            ,{field: 'isPublic', title: '公共课', width:80,
                                templet:function (res) {
                                    if (res.isPublic === 1) {
                                        return '是';
                                    } else {
                                        return '否';
                                    }
                                }
                            }
                            ,{field: 'isRequired', title: '必修课', width:80,
                                templet:function (res) {
                                    if (res.isRequired === 1) {
                                        return '是';
                                    } else {
                                        return '否';
                                    }
                                }
                            }
                            , {field: '',width: 250, title: '操作',
                                templet: function (res) {
                                    var ops = "<button class=\"layui-btn layui-btn layui-btn-xs\" title=\"编辑\" onclick=\"editCourse('" + res.id + "')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe642;</i>排课编辑</button> &nbsp;&nbsp;";
                                    return ops ;
                                }
                            }
                        ]]
                    });
                });
            }

            /*根据学院查找课程并显示*/
            function departmentCourse(departmentId) {
                layui.use('table', function(){
                    table = layui.table;
                    table.render({
                        elem: '#courseTable'
                        ,height: 450
                        ,url: '/course/DepartmentCourse?departmentId='+departmentId //数据接口
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code": 0, //解析接口状态
                                "msg": '成功', //解析提示文本
                                "count": res.total, //解析数据长度
                                "data": res //解析数据列表
                            };
                        }
                        ,page: true //开启分页
                        ,cols: [[ //表头
                            {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
                            ,{field: 'name', title: '课程名', width:200}
                            ,{field: 'isPublic', title: '公共课', width:80,
                                templet:function (res) {
                                    if (res.isPublic === 1) {
                                        return '是';
                                    } else {
                                        return '否';
                                    }
                                }
                            }
                            ,{field: 'isRequired', title: '必修课', width:80,
                                templet:function (res) {
                                    if (res.isRequired === 1) {
                                        return '是';
                                    } else {
                                        return '否';
                                    }
                                }
                            }
                            , {field: '',width: 250, title: '操作',
                                templet: function (res) {
                                    var ops = "<button class=\"layui-btn layui-btn layui-btn-xs\" title=\"编辑\" onclick=\"editCourse('" + res.id + "')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe642;</i>排课编辑</button> &nbsp;&nbsp;";
                                    return ops ;
                                }
                            }
                        ]]
                    });
                });
            }

            /*查找所有排课并显示*/
            function allCourseTime() {
                layui.use('table', function(){
                    table = layui.table;
                    table.render({
                        elem: '#courseTable'
                        ,height: 450
                        ,url: '/courseTime/AllCourseTime' //数据接口
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code": 0, //解析接口状态
                                "msg": '成功', //解析提示文本
                                "count": res.total, //解析数据长度
                                "data": res //解析数据列表
                            };
                        }
                        ,page: true //开启分页
                        ,cols: [[ //表头
                            {field: 'courseId', title: '课程ID', width:100, sort: true, fixed: 'left'}
                            ,{field: 'courseName', title: '课程名', width:200}
                            ,{field: 'teacherId', title: '教师ID', width:100}
                            ,{field: 'teacherName', title: '教师名', width:100}
                            ,{field: 'classId', title: '班级ID', width:100}
                            ,{field: 'className', title: '班级名', width:200}
                            , {field: '',width: 200, title: '操作',
                                templet: function (res) {
                                    var ops = "<button class=\"layui-btn layui-btn layui-btn-xs\" title=\"编辑\" onclick=\"editCourseTimeWindow('" + res.courseId + "','" + res.teacherId + "','" + res.classId + "')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe642;</i>编辑</button> &nbsp;&nbsp;";
                                    ops +="<button class=\"layui-btn-normal layui-btn layui-btn-xs\" title=\"删除\" onclick=\"deleteCourse('" + res.courseName + "','" + res.teacherName + "','" + res.className + "','" + res.courseId + "','" + res.teacherId + "','" + res.classId + "')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe619;</i>删除</button>";
                                    return ops ;
                                }
                            }
                        ]]
                    });
                });
            }


        </script>
    </body>
</html>