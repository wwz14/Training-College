<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018/2/20
  Time: 15:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Train COLLEGE | Grade</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->
    <!-- bootstrap datetimepicker -->
    <link href="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
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
        <jsp:param name="lesson_more" value="active menu-open"/>
        <jsp:param name="attendance" value="active"/>
    </jsp:include>

    <div class="content-wrapper">

        <!-- 大标题 -->
        <section class="content-header">
            <h1>
                考勤签到
                <small>以班级为单位</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/college/homepage"><i class="fa fa-home"></i> 主页</a></li>
                <li><a href="/college/show_students?classId=${classes.id}&classNo=${classNo}"> ${classes.name}</a></li>
                <li class="active"> 考勤签到</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <form action="/college/new_grade" method="post">
                        <div class="box box-success">
                            <div class="box-header">
                                <h3 class="box-title">${classNo}班签到表</h3>

                            </div>
                            <input type="hidden" value="${progressList.size()}" name="proSize">
                            <input type="hidden" value="${classes.id}" name="classId">
                            <!-- /.box-header -->
                            <div class="box-body table-responsive">

                                <div class="control-group">
                                    <label class="control-label">日期：</label>
                                    <div class="controls input-append date form_datetime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input1">
                                        <input type="text" value="" readonly required>
                                        <span class="add-on"><i class="icon-remove"></i></span>
                                        <span class="add-on"><i class="icon-th"></i></span>
                                    </div>
                                    <input name="date" type="hidden" id="dtp_input1" value="" /><br/>
                                </div>
                                <!-- /.form group -->

                                <table class="table table-hover">
                                    <tr>
                                        <th>学员姓名</th>
                                        <th>联系方式</th>
                                        <th>分数</th>
                                    </tr>
                                    <c:forEach var="i" begin="0" end="${progressList.size()-1}" step="1">
                                        <c:set var="lp0" scope="page" value="${progressList.get(i)}"/>
                                        <c:set var="normal0" scope="page" value="${studentList.get(i)}"/>
                                        <tr>
                                            <td>${normal0.username}</td>
                                            <td>${normal0.phone}</td>
                                            <td>
                                                <input type="hidden" name="lessonProId${i}" value="${lp0.id}">
                                                <input type="hidden" name="uid${i}" value="${lp0.uid}">
                                                <div class="form-group">
                                                    <input name="grade${i}" type="number" value="60">
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                            <!-- /.box-body -->

                            <div class="box-footer">
                                <button type="submit" class="btn btn-info pull-right" style="margin-right: 10px">保存</button>
                                <button type="button" class="btn btn-default pull-right" onclick="javascript:history.go(-1);"
                                        style="margin-right: 10px">取消</button>
                            </div>
                            <!-- /.box-footer -->
                        </div>
                        <!-- /.box -->
                    </form>
                </div>
            </div>

        </section>

    </div>

    <jsp:include page="../public/footer.jsp" flush="true" />
</div>


<script src="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap-datetimepicker/2.1.30/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>

<!-- jQuery 3 -->
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<%--<!-- SlimScroll -->--%>
<script src="https://cdn.bootcss.com/jQuery-slimScroll/1.3.8/jquery.slimscroll.js"></script>
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
    $(function () {
        $('.form_datetime').datetimepicker({
            language:  'zh-CN',
            weekStart: 1,
            todayBtn:  1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            forceParse: 0,
            showMeridian: 1
        });
    })
</script>
</body>
</html>

