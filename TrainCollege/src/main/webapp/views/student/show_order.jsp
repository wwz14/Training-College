<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018/2/17
  Time: 20:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Train COLLEGE | Order Detail Page</title>
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
    .box.box-success {
        border-top-color: #7E3D76;
    }
</style>
<body class="skin-green-light sidebar-mini">
<div class="wrapper">
    <jsp:include page="../public/student_header.jsp" flush="true" />

    <jsp:include page="../public/student_nav.jsp" flush="true" >
        <jsp:param name="my_orders" value="active menu-open"/>
    </jsp:include>

    <div class="content-wrapper">

        <!-- 大标题 -->
        <section class="content-header">
            <h1>
                订单详情
            </h1>
            <ol class="breadcrumb">
                <li><a href="/student/homepage"><i class="fa fa-home"></i> 主页</a></li>
                <li><a href="/student/all_orders"> 所有订单</a></li>
                <li class="active">${lesson.name}</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="invoice">
            <!-- 课程标题 -->
            <div class="row">
                <div class="col-xs-12">
                    <h2 class="page-header">
                        <i class="fa fa-calendar"></i> 订单 #${order.id}
                        <small class="pull-right"><c:choose>
                            <c:when test="${order.state==1}">已支付</c:when>
                            <c:when test="${order.state==2}">已退订</c:when>
                            <c:otherwise>超时未支付，已取消</c:otherwise>
                        </c:choose></small>
                    </h2>
                </div>
                <!-- /.col -->
            </div>
            <!-- 基础信息 -->
            <div class="row invoice-info">

                <div class="col-sm-4 invoice-col">
                    <b>会员信息</b><br>
                    <br>
                    <b>会员名称：</b> ${student.username}<br>
                    <b>电子邮箱：</b> ${student.email}<br>
                    <b>联系电话：</b> ${student.phone}<br>
                    <b>等级折扣：</b> ${discount} 折
                </div>
                <!-- /.col -->

                <div class="col-sm-4 invoice-col">
                    <b>课程信息</b><br>
                    <br>
                    <b>课程名称：</b> ${lesson.name}<br>
                    <b>课程类型：</b> ${lesson.type}<br>
                    <b>课程周期：</b> <fmt:formatDate value="${lesson.startDay}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${lesson.endDay}" pattern="yyyy-MM-dd"/><br>
                    <b>课时周次：</b> ${lesson.timePerWeek}（课时/周）* ${lesson.weekNum} 周
                </div>
                <!-- /.col -->

                <div class="col-sm-4 invoice-col">
                    <b>订单信息</b><br>
                    <br>
                    <b>订单号：</b> ${order.id}<br>
                    <b>订单状态：</b> <c:choose>
                    <c:when test="${order.state==1}">已支付</c:when>
                    <c:when test="${order.state==2}">已退订</c:when>
                    <c:otherwise>超时未支付，已取消</c:otherwise>
                </c:choose><br>
                    <b>订单总额：</b>￥ ${order.totalPay}<br>
                    <b>下单时间：</b> <fmt:formatDate value="${order.orderTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
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
                            <th>序号</th>
                            <th>学员名</th>
                            <th>联系电话</th>
                            <th>班级类型</th>
                            <th>班号</th>
                            <th>单价</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="i" begin="0" end="${progresses.size()-1}" step="1">
                            <c:set var="lp0" scope="page" value="${progresses.get(i)}"/>
                            <c:set var="normal0" scope="page" value="${NMstudents.get(i)}"/>
                            <tr>
                                <td><c:out value="${i+1}"/></td>
                                <td><c:out value="${normal0.username}"/></td>
                                <td><c:out value="${normal0.phone}"/></td>
                                <td><c:out value="${types.get(i)}"/></td>
                                <td>${lp0.classNo}</td>
                                <td>￥<c:out value="${lp0.payment}"/></td>
                            </tr></c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
            <!-- 不被打印的按钮们 -->
            <div class="row">
                <div class="col-xs-12">
                    <button id="retrieve-button" class="btn btn-success pull-right" onclick="$('#rule-modal').modal('show')"><i class="fa fa-close"></i> 退订</button>
                </div>
            </div>

            <div class="modal fade" id="rule-modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">退订须知</h4>
                        </div>
                        <div class="modal-body">
                            <div class="box-body">
                                <ul>
                                    <li>若退订时间距离开课时间为90天以上</li>
                                    <ul>
                                        <li>返回实付金额的100%，不收违约金,扣除相应经验值</li>
                                    </ul>
                                    <br>

                                    <li>若退订时间距离开课时间为30天~90天个月</li>
                                    <ul>
                                        <li>返回实付金额的80%，余下20%为违约金,扣除相应经验值</li>
                                    </ul>
                                    <br>

                                    <li>若退订时间距离开课时间为30天内</li>
                                    <ul>
                                        <li>返回实付金额的50%，余下50%为违约金,扣除相应经验值</li>
                                    </ul>
                                    <br>

                                    <li>若已开课</li>
                                    <ul>
                                        <li>不退回任何钱款,扣除相应经验值</li>
                                    </ul>
                                </ul>
                            </div>
                        </div>
                        <!-- /.modal-content -->

                        <div class="modal-footer">
                            <button class="btn btn-default pull-left" data-dismiss="modal">取消</button>
                            <button class="btn btn-success" onclick="retrieve()">仍要退订</button>
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
<script type="text/javascript">

    $(document).ready(function () {
        if(${order.state!=1})
            $('#retrieve-button').hide();
    });

    function retrieve() {
        $.post("/student/retrieve_order",
            {
                oid: ${order.id}
            },
            function (data) {
                alert("退回金额："+data+"元");
                window.location.reload();
            });
    }
</script>
</body>
</html>

