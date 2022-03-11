<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>学生考勤系统-登录</title>
        <script src="../lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
        <link rel="stylesheet" href="../lib/layui/css/layui.css">
        <link rel="stylesheet" href="../css/login.css">
    </head>
    <body class="login-bg">
        <!--若是手机则跳转到手机网页-->
        <script>
            function goPAGE() {
                if ((navigator.userAgent.match(/(phone|pad|pod|iPhone|iPod|ios|iPad|Android|Mobile|BlackBerry|IEMobile|MQQBrowser|JUC|Fennec|wOSBrowser|BrowserNG|WebOS|Symbian|Windows Phone)/i))) {
                    window.location.href="/login/loginPhone";
                }
            }
            goPAGE();
        </script>

        <div class="login layui-main">

            <div class="message">学生考勤系统登录</div>

            <form method="post" class="layui-form">
                <input name="account" lay-filter="account" placeholder="账号" type="number" lay-verify="required|number" class="layui-input">
                <input name="password" lay-filter="password" lay-verify="required" placeholder="密码" type="password" class="layui-input">
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        登录方式：
                        <input type="radio" name="type" lay-filter="type" value="学生" title="学生" checked="">
                        <input type="radio" name="type" lay-filter="type"value="老师" title="老师">
                        <input type="radio" name="type" lay-filter="type" value="管理员" title="管理员">
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
                                window.location.href="/login/toMainPage";
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