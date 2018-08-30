<%--
  Created by IntelliJ IDEA.
  User: jqwu
  Date: 2018/2/26
  Time: 下午10:09
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
        <jsp:param name="self" value="active menu-open"/>
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
                <li><a href="/college/homepage"><i class="fa fa-home"></i> 主页</a></li>
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
                                        <i class="fa fa-arrow-circle-left bg-purple"></i>
                                    </c:when>
                                    <c:when test="${item.type==2}">
                                        <i class="fa fa-star bg-yellow"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa fa-arrow-circle-right bg-light-blue"></i>
                                    </c:otherwise>
                                </c:choose>

                                <div class="timeline-item">
                                    <span class="time"><i class="fa fa-clock-o"></i> <fmt:formatDate value="${item.paytime}" pattern="HH:mm"/></span>

                                    <h3 class="timeline-header"><b>${item.email}</b> 与你进行交易</h3>

                                    <div class="timeline-body">
                                        <c:choose>
                                            <c:when test="${item.type==0}">
                                                <b>${item.email}</b> 向你转账${item.payment}元。
                                            </c:when>
                                            <c:when test="${item.type==2}">
                                                <b>${item.email}</b> 进行结算，转账${item.payment}元。
                                            </c:when>
                                            <c:otherwise>
                                                你向 <b>${item.email}</b> 退款${item.payment}元。
                                            </c:otherwise>
                                        </c:choose>
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
        </section>

    </div>

    <jsp:include page="../public/footer.jsp" flush="true" />
</div>

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
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.js"></script>

</body>
</html>

