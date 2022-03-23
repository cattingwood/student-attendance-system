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
                <button class="layui-btn js-search" onclick="searchCourse()"><i class="layui-icon">&#xe615;</i></button>
                <button class="layui-btn" onclick="addCourseWindow()">新增课程</button>
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
                            <select id="isPublic"lay-filter="isPublic">
                                <option value="1">是</option>
                                <option value="0">否</option>
                            </select>
                        </div>
                    </div>

                    <div class="layui-input-inline">
                        <label class="layui-form-label">专业</label>
                        <div class="layui-form layui-input-block">
                            <select id="majorAdd" lay-filter="majorAdd" lay-search disabled="disabled">
                                <option value='-1'>请选择</option>
                                <#if majorList??>
                                    <#list majorList as ml>
                                        <option value="${ml.id}">${ml.name}</option>
                                    </#list>
                                </#if>
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

        <div hidden id="updateCourse" lay-verify="updateCourse">
            <div style="margin: 50px;width: 500px;">
                <form class="layui-form" action="">
                    <div class="layui-form-item"> <label class="layui-form-label">课程名</label>
                        <div class="layui-input-block">
                            <input type="text" id="updateName" lay-verify="name" autocomplete="off" placeholder="请输入课程名" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">是否为公共课</label>
                        <div class="layui-form layui-input-block">
                            <select id="isPublicUpdate" lay-filter="isPublicUpdate">
                                <option value="1">是</option>
                                <option value="0">否</option>
                            </select>
                        </div>
                    </div>

                    <div class="layui-input-inline">
                        <label class="layui-form-label">专业</label>
                        <div class="layui-form layui-input-block">
                            <select id="majorUpdate" lay-filter="majorUpdate" lay-search disabled="disabled">
                                <option value='-1'>请选择</option>
                                <#if majorList??>
                                    <#list majorList as ml>
                                        <option value="${ml.id}">${ml.name}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">是否为必修课</label>
                        <div class="layui-form layui-input-block">
                            <select id="isRequiredUpdate" lay-filter="">
                                <option value="1">是</option>
                                <option value="0">否</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-btn"  onclick="updateCourse()">更新课程</div>
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
                    //根据是否为公共课选择专业  添加课程
                    form.on('select(isPublic)', function(data){
                        var isPublic = data.value;
                        if(isPublic == 1){
                            $("#majorAdd").attr("disabled","disabled");
                            form.render('select');
                        }else{
                            $("#majorAdd").removeAttr("disabled");
                            form.render('select');
                        }
                    });

                    //根据是否为公共课选择专业  更新课程
                    form.on('select(isPublicUpdate)', function(data){
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
                    form.on('select(majorAdd)', function(data){
                        updateMajor = data.value;
                    });

                });

            }


            /*根据下拉框值查找课程*/
            function searchCourse() {
                if(nowClass != -1){
                    classCourse(nowClass);
                }else if(nowMajor != -1){
                    majorCourse(nowMajor);
                }else if(nowMajor != -1){
                    departmentCourse(nowDepartment);
                }else{
                    allCourse();
                }
            }

            /*弹出添加课程窗口*/
            function addCourseWindow(){
                var layer = layui.layer;
                layer.open({
                    type: 1,
                    title: '新增课程',
                    area: ['40%', '50%'],//弹框大小
                    content: $("#addCourse"),
                    // 打开弹窗的回调函数，用于回显页面数据
                    success: function () {
                    },
                    end: function () {
                        $("#addCourse").hide();
                    }
                })
            }

            /*添加课程*/
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

                var majorId = -1;
                if(isPublic == '0'){
                    majorId = updateMajor;
                }

                var isRequired = parent.$('#isRequired').val();
                if (isRequired == '') {
                    layer.alert("请选择是否为必修课! ");
                    return false;
                }
                $.post("/course/addCourse", {
                    "name": name,
                    "marjorId": majorId,
                    "isPublic": isPublic,
                    "isRequired": isRequired
                }, function (res) {
                    if(res == 1){
                        layer.close(layer.index);
                        layer.alert("添加成功! ");
                        $("#name").val("");
                        updateMajor = -1;
                    }
                });

            }

            /*弹出编辑课程窗口*/
            function editCourseWindow(id){
                var layer = layui.layer;
                var form = layui.form;
                layer.open({
                    type: 1,
                    title: '更新课程',
                    area: ['40%', '70%'],//弹框大小
                    content: $("#updateCourse"),
                    // 打开弹窗的回调函数，用于回显页面数据
                    success: function () {
                        $.post("/course/selectCourseById", {
                            "courseId": id
                        }, function (res){
                            $("#updateName").val(res.name);
                            $("#isPublicUpdate").find("option[value="+res.isPublic+"]").attr("selected",'');
                            if(res.isPublic){
                                $("#majorUpdate").attr("disabled","disabled");
                            }else{
                                $("#majorUpdate").removeAttr("disabled");
                                $("#majorUpdate").find("option[value="+res.marjorId+"]").attr("selected",'');
                            }
                            form.render();
                        });
                    },
                    end: function () {
                        $("#updateCourse").hide();
                    }
                })
            }

            /*编辑课程信息*/
            function editCourse(id){
                editCourseWindow(id);
            }

            /*删除课程*/
            function deleteCourse(id,name){
                layer.open({
                    title: '删除课程'
                    ,content: '是否删除' + name + "该项课程？"
                    ,btn: ['是', '否']
                    ,yes: function(index){
                        $.post("/course/deleteCourse", {
                                "courseId": id
                        }, function (res){
                            if(res == 1){
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
                        ,height: 312
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
                                    var ops = "<button class=\"layui-btn layui-btn layui-btn-xs\" title=\"编辑\" onclick=\"editCourse('" + res.id + "')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe642;</i>编辑</button> &nbsp;&nbsp;";
                                        ops +="<button class=\"layui-btn-normal layui-btn layui-btn-xs\" title=\"上架\" onclick=\"deleteCourse('" + res.id + "','" + res.name + "')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe619;</i>删除</button>";
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
                        ,height: 312
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
                                    var ops = "<button class=\"layui-btn layui-btn layui-btn-xs\" title=\"编辑\" onclick=\"editCourse('" + res.id + "')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe642;</i>编辑</button> &nbsp;&nbsp;";
                                    ops +="<button class=\"layui-btn-normal layui-btn layui-btn-xs\" title=\"上架\" onclick=\"deleteCourse('" + res.id + "','" + res.name + "')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe619;</i>删除</button>";
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
                        ,height: 312
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
            function allCourse() {
                layui.use('table', function(){
                    table = layui.table;
                    table.render({
                        elem: '#courseTable'
                        ,height: 312
                        ,url: '/course/AllCourse' //数据接口
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