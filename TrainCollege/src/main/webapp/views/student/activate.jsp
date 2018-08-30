<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018/1/23
  Time: 21:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Training College | Activate Page</title>
    <link href="https://cdn.bootcss.com/admin-lte/2.4.3/css/AdminLTE.min.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<!-- Content Wrapper. Contains page content -->
<!-- Main content -->
<section class="login-page">
    <div class="error-page">

            <form action="/student/mactivate" method="post">
                <div class="form-group has-feedback">
                    <input required name="email" type="email" class="form-control" placeholder="邮箱">
                    <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <input required name="validateCode" type="password" class="form-control" placeholder="密码">
                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                </div>
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat">注册</button>
                </div>
            </form>
            <h3><i class="fa fa-warning text-yellow"></i> ${message}</h3>
            <p>
                现在去登陆 <a href="../index"></a><br>
                重新注册新学员 <a href="/student/register"></a>
            </p>
        <!-- content -->
    </div>
    <!-- page -->
</section>
</body>
</html>
