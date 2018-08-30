<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018/2/18
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Train COLLEGE | Enroll Offline</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- Select2 -->
    <link href="https://cdn.bootcss.com/select2/4.0.6-rc.1/css/select2.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- Ionicons -->
    <link href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet">
    <!-- Theme style -->
    <link href="https://cdn.bootcss.com/admin-lte/2.4.3/css/AdminLTE.min.css" rel="stylesheet">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link href="https://cdn.bootcss.com/admin-lte/2.4.3/css/skins/_all-skins.min.css" rel="stylesheet">
</head>
<style>
    .skin-green-light .main-header .navbar {
        background-color: #7E3D76;
    }
</style>
<body class="skin-green-light sidebar-mini">
<div class="wrapper">
    <jsp:include page="../public/college_header.jsp" flush="true" />

    <jsp:include page="../public/college_nav.jsp" flush="true" >
        <jsp:param name="offline" value="active menu-open"/>
        <jsp:param name="enroll" value="active"/>
    </jsp:include>

    <div class="content-wrapper">

        <!-- 大标题 -->
        <section class="content-header">
            <h1>
                线下报名
                <small>包含不同的班级</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/college/homepage"><i class="fa fa-home"></i> 主页</a></li>
                <li class="active">${lesson.name}</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <form action="/college/enroll_offline" method="post">
                <%--学员信息--%>
                <div class="col-md-6">

                    <div class="box box-info">
                        <div class="box-header">
                            <h3 class="box-title"><i class="fa fa-angle-right"></i> 填写学员信息</h3>
                        </div>
                        <div class="box-body">

                            <div class="form-group">
                                <label>学员类型：</label>
                                <select onchange="isVIP()" id="type-select" name="type" class="form-control select2" style="width: 100%;" required>
                                    <option value="1">是会员</option>
                                    <option value="0" selected>不是会员</option>
                                </select>
                            </div>

                            <div class="form-group" id="id-group">
                                <label>邮箱：</label>
                                <input name="id" class="form-control" required>
                                <span class="help-block"></span>
                                <!-- /.input group -->
                            </div>
                            <!-- /.form group -->

                            <div class="form-group">
                                <label>联系电话：</label>
                                <input id="phone" name="phone" type="tel" class="form-control" required>
                                <!-- /.input group -->
                            </div>
                            <!-- /.form group -->
                        </div>
                        <!-- /.box-body -->

                        <div class="box-footer">
                            <button class="btn btn-success pull-right" type="submit">提交</button>
                        </div>
                        <!-- /.box-footer -->
                    </div>
                    <!-- /.box -->
                </div>
                <!-- /.col (1) -->

                <%--课程信息--%>
                <div class="col-md-6">

                    <div class="box box-info">
                        <div class="box-header">
                            <h3 class="box-title"><i class="fa fa-angle-right"></i> 选择课程</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group">
                                <label>课程计划选择：</label>
                                <select id="lesson-select" onchange="selectLesson()" name="lid" class="form-control select2" style="width: 100%;" required>
                                    <c:forEach items="${lessonList}" var="item" >
                                        <option value="${item.id}">${item.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>班级选择：</label>
                                <select  id="class-select" name="classId" class="form-control select2" style="width: 100%;" required>

                                </select>
                                <span class="help-block"></span>
                            </div>

                        </div>
                    </div>
                    <!-- /.box -->
                </div>
                <!-- /.col (1) -->
            </form>

        </section>

    </div>

    <jsp:include page="../public/footer.jsp" flush="true" />
</div>

<!-- Select2 -->
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>


<!-- Bootstrap 3.3.7 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<%--<!-- SlimScroll -->--%>
<script src="https://cdn.bootcss.com/jQuery-slimScroll/1.3.8/jquery.slimscroll.js"></script>
<script src="https://cdn.bootcss.com/select2/4.0.6-rc.1/js/select2.full.min.js"></script>
<!-- DataTables -->
<script src="https://cdn.bootcss.com/datatables/1.10.13/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.bootcss.com/datatables/1.10.16/js/dataTables.bootstrap.min.js"></script>
<%--<!-- FastClick -->--%>
<script src="https://cdn.bootcss.com/fastclick/1.0.6/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.4.3/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.4.3/js/demo.js"></script>

<script>
    function selectLesson() {
        var lid = $('#lesson-select option:selected').val();
        $("#class-select").empty();
        if(lid!=undefined){
            $("#class-select").attr("readonly",false);
            $.post("/datadb/classes_by_lid",
                {
                    lid: lid
                },
                function (data) {
                    for(var i in data){
                        $("#class-select").append("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
                    }
                });
        }
    }

    function isVIP() {
        var type = $('#type-select option:selected').val();
        if(type=='0'){
        //    不是会员
            $('#id-group label').text("学员姓名：");
            $('#id-group input').attr("onchange","");
            $('#id-group span').text("");
            $('#phone').attr("disabled",false).val("");
        }else{
            $('#id-group label').text("会员邮箱：");
            $('#id-group input').attr("onchange","check(this)");
            $('#id-group span').text("填写注册邮箱,手机号无需填写");
            $('#phone').attr("disabled",true).val("");
        }
    }

    function check(node) {
        var email = $('#id-group input').val();
        $.post("/student/get_student_by_email",
            {
                email: email
            },
            function (data) {
                if (data==true) {
                    $('#id-group').attr("class","form-group has-success")
                    $('#id-group span').html('<i class="fa fa-check"></i> 该邮箱会员存在');
                }
                else {
                    $('#id-group').attr("class","form-group has-error")
                    $('#id-group span').html('<i class="fa fa-check"></i> 该邮箱会员不存在');
                }
            });
    }
</script>
</body>
</html>
