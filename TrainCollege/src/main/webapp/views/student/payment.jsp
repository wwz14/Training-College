<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018/2/18
  Time: 17:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Train COLLEGE | Payment</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->
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
</style>
<body class="skin-green-light sidebar-mini">
<div class="wrapper">
    <jsp:include page="../public/student_header.jsp" flush="true" />

    <jsp:include page="../public/student_nav.jsp" flush="true" >
        <jsp:param name="personal" value="active menu-open"/>
        <jsp:param name="payment" value="active"/>
    </jsp:include>

    <div class="content-wrapper">

        <!-- 大标题 -->
        <section class="content-header">
            <h1>
                交易记录
                <small>查看付费/退款记录</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/student/homepage"><i class="fa fa-home"></i> 主页</a></li>
                <li class="active">交易记录</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <c:set var="last" value="1970-01-01"/>
            <!-- row -->
            <div class="row">
                <div class="col-md-12">
                    <!-- The time line -->
                    <ul class="timeline">
                        <c:forEach items="${paymentList}" var="item" >
                            <c:set var="current" value='${item.paytime.year}-${item.paytime.month}-${item.paytime.day}'/>
                            <c:if test="${last!=current}">
                                <!-- timeline time label -->
                                <li class="time-label">
                            <span class="bg-green">
                                <fmt:formatDate value="${item.paytime}" pattern="yyyy-MM-dd"/>
                            </span>
                                </li>
                                <!-- /.timeline-label -->
                            </c:if>

                            <!-- timeline item -->
                            <li>
                                <c:choose>
                                    <c:when test="${item.type==0}">
                                        <i class="fa fa-arrow-circle-right bg-purple"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa fa-arrow-circle-left bg-light-blue"></i>
                                    </c:otherwise>
                                </c:choose>

                                <div class="timeline-item">
                                    <span class="time"><i class="fa fa-clock-o"></i> <fmt:formatDate value="${item.paytime}" pattern="HH:mm"/></span>

                                    <h3 class="timeline-header"><b>${item.collegeName}</b> 与你进行交易</h3>

                                    <div class="timeline-body">
                                        <c:choose>
                                            <c:when test="${item.type==0}">
                                                你向 <b>${item.collegeName}</b> 转账${item.payment}元。
                                            </c:when>
                                            <c:otherwise>
                                                <b>${item.collegeName}</b> 向你退款${item.payment}元。
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="timeline-footer">
                                        <a class="btn btn-warning btn-xs" href="/student/show_order?oid=${item.oid}">查看订单</a>
                                    </div>
                                </div>
                            </li>
                            <c:set var="last" value='${item.paytime.year}-${item.paytime.month}-${item.paytime.day}'/>
                            <!-- END timeline item -->
                        </c:forEach>

                        <li>
                            <i class="fa fa-clock-o bg-gray"></i>
                        </li>
                    </ul>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        <!-- /.content -->

    </div>

    <jsp:include page="../public/footer.jsp" flush="true" />
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
</body>
</html>


