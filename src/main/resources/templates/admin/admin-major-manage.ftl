<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>专业管理</title>
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
                <button class="layui-btn js-search" onclick="searchMajor()"><i class="layui-icon">&#xe615;</i></button>
                <button class="layui-btn" onclick="addMajorWindow()">新增专业</button>
            </div>
        </div>
        <div class="layui-card-body schedule">
            <div class="table" id="majorTable"></div>
        </div>

        <div id="addMajor" hidden  lay-verify="addMajor">
            <div style="margin: 50px;width: 500px;">
                <form class="layui-form" action="">
                    <div class="layui-form-item">
                        <label class="layui-form-label">专业名</label>
                        <div class="layui-input-block">
                            <input type="text" id="addName" lay-verify="name" autocomplete="off" placeholder="请输入专业名" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">所属学院</label>
                        <div class="layui-input-block">
                            <select id="addDepartmentSelect" lay-filter="addDepartmentSelect">
                                <#if departmentList??>
                                    <#list departmentList as dl>
                                        <option value="${dl.id}">${dl.name}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                    </div>
                    <div class="layui-btn"  onclick="addMajor()">添加专业</div>
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
            /*初始化*/
            window.onload = function () {
                var form = layui.form;
                //记录所选学院
                form.on('select(departmentSelect)',function(data){
                    nowDepartment = data.value;
                });
            }

            function addMajorWindow(){
                var layer = layui.layer;
                layer.open({
                    type: 1,
                    title: '新增课程',
                    area: ['40%', '50%'],//弹框大小
                    content: $("#addMajor"),
                    // 打开弹窗的回调函数，用于回显页面数据
                    success: function () {
                    },
                    end: function () {
                        $("#addCourse").hide();
                    }
                })
            }

            function addMajor() {
                var name = parent.$('#addName').val();
                if (name == '') {
                    layer.alert("请输入专业名称! ");
                    return false;
                }
                var departmentId = parent.$('#addDepartmentSelect').val();
                $.post("/major/addMajor", {
                    "name": name,
                    "departmentId": departmentId
                }, function (res) {
                    if(res == 1){
                        layer.close(layer.index);
                        layer.alert("添加成功! ");
                        $("#name").val("");
                        updateMajor = -1;
                    }
                });
            }

            function searchMajor(){
                if(nowDepartment != -1){
                    getMajorByDepartment(nowDepartment);
                }else{
                    allMajor();
                }
            }

            function getMajorByDepartment(id) {
                layui.use('table', function(){
                    table = layui.table;
                    table.render({
                        elem: '#majorTable'
                        ,height: 312
                        ,url: '/major/getMajorByDepartment?id='+id //数据接口
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
                            ,{field: 'name', title: '专业名', width:200}
                            ,{field: 'departmentId', title: '学院id', width:80}
                            ,{field: 'departmentName', title: '学院名', width:200}
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

            /*查找所有课程并显示*/
            function allMajor() {
                layui.use('table', function(){
                    table = layui.table;
                    table.render({
                        elem: '#majorTable'
                        ,height: 312
                        ,url: '/major/AllMajor' //数据接口
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
                            ,{field: 'name', title: '专业名', width:200}
                            ,{field: 'departmentId', title: '学院id', width:80}
                            ,{field: 'departmentName', title: '学院名', width:200}
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


        </script>
    </body>
</html>