<%--
  Created by IntelliJ IDEA.
  Date: 2018/1/21
  Time: 20:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Train COLLEGE | Log in</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <!-- Ionicons -->
<link href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet">
    <!-- Theme style -->
    <link href="https://cdn.bootcss.com/admin-lte/2.4.3/css/AdminLTE.min.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/admin-lte/2.4.3/css/skins/_all-skins.min.css" rel="stylesheet">
    <!-- iCheck -->
    <%--<link rel="stylesheet" href="../../plugins/iCheck/square/blue.css">--%>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Google Font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>
<style>
    .login-page, .register-page {
        background: #7E3D76;
    }

    .btn-primary {

        background-color:  #7E3D76;
        border-color:  #7E3D76;

    }
</style>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <b>Training college</b>
    </div>
    <!-- /.login-logo -->
    <div class="login-box-body" style="background-color: transparent;">

        <form action="/login" method="post">

            <div class="input-group">
                <div class="input-group-btn">
                    <button id="typename" type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown">学员
                        <span class="fa fa-caret-down"></span></button>
                    <ul class="dropdown-menu">
                        <li><a onclick="chooose_student()">学员</a></li>
                        <li><a onclick="chooose_college()">机构</a></li>
                    </ul>
                </div>
                <!-- /btn-group -->
                <input required name="id" type="email" class="form-control" placeholder="邮箱">
            </div>
            <%--学员类型为0，机构类型为1--%>
            <input name="type" type="hidden" value="0">
            <p style="color: red">${error}</p>

            <div class="input-group">
                <div class="input-group-btn" disabled>
                    <button type="button" class="btn btn-warning">密码</button>
                </div>
                <!-- /btn-group -->
                <input required name="password" type="password" class="form-control" placeholder="密码">
            </div>
            <br>

            <div class="row">
                <div class="col-xs-8">
                </div>
                <!-- /.col -->
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat">登陆</button>
                </div>
                <!-- /.col -->
            </div>
        </form>

        <a href="/student/activate" class="text-center">学生账户激活</a>
        <a href="/student/register" class="text-center">学生注册</a><br>
        <a href="/college/register" class="text-center">机构注册</a>


    </div>
    <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 3 -->
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.js"></script>

<script>
    function chooose_student() {
        document.getElementById("typename").innerText="学员";
        node = document.getElementsByName("id").item(0);
        node.type="email";
        node.placeholder="邮箱";
        document.getElementsByName("type").item(0).value = 0;
    }

    function chooose_college() {
        document.getElementById("typename").innerText="机构";
        node = document.getElementsByName("id").item(0);
        node.type="text";
        node.placeholder="机构编号";
        document.getElementsByName("type").item(0).value = 1;
    }
</script>
</body>
</html>

