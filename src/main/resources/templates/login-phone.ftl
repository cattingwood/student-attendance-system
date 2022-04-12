<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=0.7,user-scalable=no"/>
    <title>学生考勤系统-登录</title>
    <script src="../lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
    <link rel="stylesheet" href="../lib/layui/css/layui.css">
    <link rel="stylesheet" href="../css/loginPhone.css">
</head>
<body class="login-bg">
<div class="login layui-main">

    <div class="message">学生考勤系统登录</div>

    <form method="post" class="layui-form">
        <input name="account" lay-filter="account" placeholder="账号" type="number" lay-verify="required|number" class="layui-input">
        <input name="password" lay-filter="password" lay-verify="required" placeholder="密码" type="password" class="layui-input">
        <div class="layui-form-item" id="loginType">
            <div class="layui-input-block">
                登录方式：
                <input type="radio" name="type" lay-filter="type" value="学生" title="学生" checked="">
                <input type="radio" name="type" lay-filter="type"value="老师" title="老师">
            </div>
        </div>
        <a class="layui-btn layui-btn-primary"lay-submit lay-filter="login" id="loginBtn">登录</a>
    </form>
</div>

<script>
    $(function () {
        layui.use('form',function () {
            var form = layui.form;
            form.on('submit(login)',function (data) {
                $.post("/login/login", data.field, function (res) {
                    if (res) {
                        window.location.href="/login/toMainPagePhone";
                    } else {
                        layer.alert("账号或密码错误！");
                    }
                });
            })
        })
    })
</script>

</body>
</html>