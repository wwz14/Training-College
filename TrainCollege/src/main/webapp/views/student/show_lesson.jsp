<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018/2/7
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Train COLLEGE | Show Lesson</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <!-- daterange picker -->
    <link href="https://cdn.bootcss.com/bootstrap-daterangepicker/2.1.27/daterangepicker.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
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
    .box.box-success {
        border-top-color: #7E3D76;
    }
</style>
<body class="skin-green-light sidebar-mini">
<div class="wrapper">
    <jsp:include page="../public/student_header.jsp" flush="true" />

    <jsp:include page="../public/student_nav.jsp" flush="true" >
        <jsp:param name="browse" value="active"/>
    </jsp:include>

    <div class="content-wrapper">

        <!-- 大标题 -->
        <section class="content-header">
            <h1>
                课程计划
                <small>包含不同的班级</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/student/homepage"><i class="fa fa-home"></i> 主页</a></li>
                <li><a href="/student/all_lessons"> 所有课程计划</a></li>
                <li class="active">${lesson.name}</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="invoice">
            <!-- 课程标题 -->
            <div class="row">
                <div class="col-xs-12">
                    <h2 class="page-header">
                        <i class="fa fa-calendar"></i> ${lesson.name}
                        <small class="pull-right" id="lesson-state"></small>
                    </h2>
                </div>
                <!-- /.col -->
            </div>
            <!-- 基础信息 -->
            <div class="row invoice-info">

                <div class="col-sm-3 invoice-col">
                    <b>课程名称：</b> ${lesson.name}<br>
                    <br>
                    <b>课程类型：</b> ${lesson.type}<br>
                    <b>课程周期：</b> <fmt:formatDate value="${lesson.startDay}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${lesson.endDay}" pattern="yyyy-MM-dd"/><br>
                    <b>每周课时：</b> ${lesson.timePerWeek} 课时/周<br>
                    <b>周次数量：</b> ${lesson.weekNum} 周
                </div>
                <!-- /.col -->

                <div class="col-sm-3 invoice-col">
                    <b>所属机构：</b> ${college.name}<br>
                    <br>
                    <b>联系电话：</b> ${college.phone}<br>
                    <b>地理位置：</b> ${college.location}<br>
                    <b>师资力量：</b> ${college.teacher}
                </div>
                <!-- /.col -->

                <div class="col-sm-6 invoice-col">
                    <b>课程介绍</b><br>
                    <br>
                    <address>${lesson.intro}</address>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->

            <!-- Table row -->
            <div class="row">
                <div class="col-xs-12 table-responsive">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>班级名称</th>
                            <th>每班人数</th>
                            <th>班级个数</th>
                            <th>授课教师</th>
                            <th>价格</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${classList}" var="item" >
                            <tr>
                                <td><c:out value="${item.name}"/></td>
                                <td><c:out value="${item.size}"/></td>
                                <td><c:out value="${item.num}"/></td>
                                <td><c:out value="${item.teacher}"/></td>
                                <td>￥<c:out value="${item.price}"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->

            <!-- 不被打印的按钮们 -->
            <div class="row no-print">
                <div class="col-xs-12">


                    <button class="btn btn-success pull-right" onclick="$('#rule-modal').modal('show')"><i class="fa fa-check-square-o"></i> 我要报名</button>
                </div>
            </div>

            <div class="modal fade" id="rule-modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">自动配班规则</h4>
                        </div>
                        <div class="modal-body">
                            <div class="box-body">
                                <ul>
                                    <li>选择班级不成功，自动退款</li>
                                    <ul>
                                        <li>未选择班级,自动配班，配班失败，退款</li>
                                    </ul>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <!-- /.modal-content -->

                        <div class="modal-footer">
                            <a href="/student/enroll_lesson_without?lid=${lesson.id}" class="btn btn-success pull-left">自动配班</a>
                            <a href="/student/enroll_lesson_with_class?lid=${lesson.id}" class="btn btn-primary">手动选班</a>
                        </div>
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal lesson -->
            </div>

        </section>
        <!-- /.content -->
        <div class="clearfix"></div>
    </div>

    <jsp:include page="../public/footer.jsp" flush="true"/>
</div>

<!-- jQuery 3 -->
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- Select2 -->
<script src="https://cdn.bootcss.com/select2/4.0.6-rc.0/js/select2.full.min.js"></script>
<!-- DataTables -->
<script src="https://cdn.bootcss.com/datatables/1.10.13/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.bootcss.com/datatables/1.10.16/js/dataTables.bootstrap.min.js"></script>
<%--<!-- SlimScroll -->--%>
<script src="https://cdn.bootcss.com/jQuery-slimScroll/1.3.8/jquery.slimscroll.js"></script>
<%--<!-- FastClick -->--%>
<script src="https://cdn.bootcss.com/fastclick/1.0.6/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.4.3/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.4.3/js/demo.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        var state = ${lesson.state};
        switch (state) {
            case 1:
                $('#lesson-state').text("报名中");
                break;
            case 2:
                $('#lesson-state').text("报名截止");
                $('#enroll-button').attr("disabled","true");
                break;
            case 3:
                $('#lesson-state').text("已结束");
                $('#enroll-button').attr("disabled","true");
                break;
        }
    });
</script>
</body>
</html>
