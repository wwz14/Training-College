<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018/2/9
  Time: 19:09
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
        <jsp:param name="not_pay" value="active"/>
    </jsp:include>

    <div class="content-wrapper">

        <!-- 大标题 -->
        <section class="content-header">
            <h1>
                待支付订单
                <small>请15分钟内支付完毕</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/student/homepage"><i class="fa fa-home"></i> 主页</a></li>
                <li><a href="/student/not_pay_orders"> 未支付订单</a></li>
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
                        <small class="pull-right" id="timer"></small>
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
                    <b>订单状态：</b> 未支付<br>
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

                    <button class="btn btn-success pull-right" onclick="$('#rule-modal').modal('show')"><i class="fa fa-check-square-o"></i> 支付</button>
                </div>
            </div>

            <div class="modal fade" id="rule-modal">
                <div class="modal-dialog">
                    <form action="/student/pay_order" method="post">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">支付界面</h4>
                        </div>
                        <div class="modal-body">
                            <div class="box-body">
                                <input type="hidden" name="oid" value="${order.id}">
                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-credit-card"></i>
                                    </div>
                                    <input name="cardNo" type="number" class="form-control pull-right" placeholder="银行卡号" required>
                                </div>

                                <br>
                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-lock"></i>
                                    </div>
                                    <input name="password" type="password" class="form-control pull-right" required>
                                </div>
                            </div>
                        </div>
                        <!-- /.modal-content -->

                        <div class="modal-footer">
                            <button class="btn btn-default pull-left" data-dismiss="modal">取消</button>
                            <button class="btn btn-success" type="submit">确认</button>
                        </div>
                    </div>
                    <!-- /.modal-dialog -->
                    </form>
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
    var _ordertimer = null;
    $(document).ready(function () {
        _ordertimer = setInterval(function(){leftTimer('<fmt:formatDate value="${order.orderTime}" pattern="yyyy-MM-dd HH:mm:ss"/>')}, 1000);
    });
    function leftTimer(enddate) {
        var leftTime = (new Date(enddate)) - new Date(); //计算剩余的毫秒数
        leftTime+=2*60*1000;
        var minutes = parseInt(leftTime / 1000 / 60 % 60);//计算剩余的分钟
        var seconds = parseInt(leftTime / 1000 % 60);//计算剩余的秒数

        if (minutes >= 0 || seconds >= 0){
            minutes = checkTime(minutes);
            seconds = checkTime(seconds);
            document.getElementById("timer").innerHTML = "剩余支付时间："+minutes + "分" + seconds + "秒";
        }else{
            window.location.reload();
        }
    }
    function checkTime(i) { //将0-9的数字前面加上0，例1变为01
        if (i < 10) {
            i = "0" + i;
        }
        return i;
    }
</script>
</body>
</html>
