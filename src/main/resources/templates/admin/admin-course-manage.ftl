<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>课表管理</title>
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
                        <select id="majorSelect"lay-filter="majorSelect">
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
                <button class="layui-btn js-search" onclick="searchCourse()"><i class="layui-icon">&#xe615;</i></button>
                <button class="layui-btn" onclick="addCourseWindow()">新增课程</button>
            </div>
        </div>

        <select id="majorSelectHidden" hidden>
            <#if majorList??>
                <#list majorList as ml>
                    <option value="${ml.id}" departmentIdHidden="${ml.departmentId}">"${ml.name}"</option>
                </#list>
            </#if>
        </select>
        <select id="classSelectHidden" hidden>
            <#if classList??>
                <#list classList as cl>
                    <option value="${cl.id}" majorIdHidden="${cl.majorId}">"${cl.name}"</option>
                </#list>
            </#if>
        </select>

        <div class="layui-card-body schedule">
            <div class="table" id="courseTable"></div>
        </div>

        <div hidden id="addCourse">
            <div style="margin: 50px;width: 500px;">
                <form class="layui-form" action="">
                    <div class="layui-form-item"> <label class="layui-form-label">课程名</label>
                        <div class="layui-input-block">
                            <input type="text" id="name" lay-verify="title" autocomplete="off" placeholder="请输入课程名" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">是否为公共课</label>
                        <div class="layui-form layui-input-block">
                            <select id="isPublic"lay-filter="majorSelect">
                                <option value="1">是</option>
                                <option value="0">否</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">是否为必修课</label>
                        <div class="layui-form layui-input-block">
                            <select id="isRequired"lay-filter="majorSelect">
                                <option value="1">是</option>
                                <option value="0">否</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-btn"  onclick="addCourse()">新增课程</div>
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
            var nowDepartment = -1;
            var nowMajor = -1;
            var nowClass = -1;
            window.onload = function () {
                /*classCourse(1);*/
                var table = layui.table;
                var form = layui.form;

                layui.use(['form'], function(){
                    form = layui.form;
                    // 监听select切换事件
                    form.on('select(departmentSelect)',function(data){//根据所选学院显示专业
                        var majorList = "";
                        var departmentId = data.value;
                        nowDepartment = departmentId;
                        nowMajor = -1;
                        nowClass = -1;/*存储当前选择情况*/
                        $('option[departmentIdHidden="' + departmentId + '"]').each(function (i) {
                            majorList += this.outerHTML;
                        });
                        $("#majorSelect").html(majorList);
                        form.render('select');
                    });
                    form.on('select(majorSelect)', function(data){//根据所选专业显示班级
                        var classList = "";
                        var majorId = data.value;
                        nowMajor = majorId;
                        nowClass = -1;/*存储当前选择情况*/
                        $('option[majorIdHidden="' + majorId + '"]').each(function (i) {
                            classList += this.outerHTML;
                        });
                        $("#classSelect").html(classList);
                        form.render('select',"classSelect");
                    });
                    form.on('select(classSelect)', function(data){//根据所选专业显示班级
                        nowClass = data.value;
                    });
                });

            }


            /*根据下拉框值查找课程*/
            function searchCourse() {
                if(nowClass != -1){
                    classCourse(nowClass);
                }else if(nowMajor != -1){
                    classCourse(nowMajor);
                }else{
                    classCourse(nowDepartment);
                }
            }

            function addCourseWindow(){
                var layer = layui.layer;
                layer.open({
                    type: 1,
                    title: '新增课程',
                    area: ['40%', '50%'],//弹框大小  屏幕宽度的80%，高度的80%；
                    content: $("#addCourse"),
                    // 打开弹窗的回调函数，用于回显页面数据
                    success: function () {
                    },
                    end: function () {
                        $("#addCourse").hide();
                    }
                })
            }

            function addCourse(){
                var name = parent.$('#name').val();
                if (name == '') {
                    layer.alert("请输入课程名称! ");
                    return false;
                }
                var isPublic = parent.$('#isPublic').val();
                if (isPublic == '') {
                    layer.alert("请选择是否为公共课! ");
                    return false;
                }
                var isRequired = parent.$('#isRequired').val();
                if (isRequired == '') {
                    layer.alert("请选择是否为必修课! ");
                    return false;
                }
                $.post("/course/addCourse", {
                    "name": name,
                    "isPublic": isPublic,
                    "isRequired": isRequired
                }, function (res) {
                    if(res == 1){
                        layer.alert("添加成功! ");
                    }
                });

            }

            function editCourse(id){
                alert(id);
            }

            function deleteCourse(id,name){
                layer.open({
                    title: '删除课程'
                    ,content: '是否删除' + name + "该项课程？"
                    ,btn: ['是', '否']
                    ,yes: function(index){
                        $.post("/backend/", {
                                "courseId": id
                        }, function (res){
                            if(res == 1){
                                layui.alert("删除成功！");
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
                        ,height: 312
                        ,url: '/course/ClassCourse?classId='+classId //数据接口
                        ,parseData: function(res){ //res 即为原始返回的数据
                            console.log(res)
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
                                    var ops = "<button class=\"layui-btn layui-btn layui-btn-xs\" title=\"编辑\" onclick=\"editCourse('" + res.id + "')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe642;</i>编辑</button> &nbsp;&nbsp;";
                                        ops +="<button class=\"layui-btn-normal layui-btn layui-btn-xs\" title=\"上架\" onclick=\"deleteCourse('" + res.id + "','" + res.name + "')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe619;</i>删除</button>";
                                    return ops ;
                                }
                            }
                        ]]
                    });
                });
            }

            table.on('toolbar(test)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id)
                    ,data = checkStatus.data; //获取选中的数据
                switch(obj.event){
                    case 'add':
                        layer.msg('添加');
                        break;
                    case 'update':
                        if(data.length === 0){
                            layer.msg('请选择一行');
                        } else if(data.length > 1){
                            layer.msg('只能同时编辑一个');
                        } else {
                            layer.alert('编辑 [id]：'+ checkStatus.data[0].id);
                        }
                        break;
                    case 'delete':
                        if(data.length === 0){
                            layer.msg('请选择一行');
                        } else {
                            layer.msg('删除');
                        }
                        break;
                };
            });

        </script>
    </body>
</html>