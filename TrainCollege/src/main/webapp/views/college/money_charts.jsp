<%--
  Created by IntelliJ IDEA.
  User: jqwu
  Date: 2018/3/10
  Time: 下午10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Train COLLEGE | Charts</title>
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
        <jsp:param name="money_charts" value="active"/>
    </jsp:include>

    <div class="content-wrapper">

        <!-- 大标题 -->
        <section class="content-header">
            <h1>
                财务图表
                <small>查看收支情况</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/college/homepage"><i class="fa fa-home"></i> 主页</a></li>
                <li class="active">财务图表</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">

            <div class="row">
                <div class="col-xs-12">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">${year}年收支柱状图</h3>
                            <div class="form-group pull-right">
                                <label>年份</label>
                                <select class="form-control" id="years" onchange="change_year()">
                                </select>
                            </div>
                        </div>
                        <div class="box-body">
                            <canvas id="payment-bar" style="height:250px"></canvas>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->


                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->

        </section>

    </div>

    <jsp:include page="../public/footer.jsp" flush="true" />
</div>


<!-- ChartJS -->
<script src="/static/chart.js/Chart.js"></script>



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

<script>
    var MONTHS = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];

    $(function () {
        $.post("/college/get_inout_data",
            {
                year: ${year}
            },
            function (data) {
                var indata = data.slice(0,12);
                var outdata = data.slice(12,24);

                var barChartData = {
                    labels: MONTHS,
                    datasets: [{
                        label: '收入',
                        backgroundColor: "rgba(54, 162, 235, 0.8)",
                        borderColor: "rgba(54, 162, 235, 1)",
                        borderWidth: 1,
                        data: indata
                    }, {
                        label: '支出（退款）',
                        backgroundColor: "rgba(255, 99, 132, 0.8)",
                        borderColor: "rgba(255, 99, 132, 1)",
                        borderWidth: 1,
                        data: outdata
                    }]

                };

                var ctx = document.getElementById('payment-bar').getContext('2d');
                window.myBar = new Chart(ctx, {
                    type: 'bar',
                    data: barChartData,
                    options: {
                        responsive: true,
                        legend: {
                            position: 'bottom'
                        }
                    }
                });
            });


        for(var i = 2017;i<=new Date().getFullYear();i++){
            if(parseInt(${year})==i){
                $('#years').append('<option selected>'+i+'</option>');
            }else{
                $('#years').append('<option>'+i+'</option>');
            }
        }

    });

    function change_year() {
        var checkValue=$("#years").val();
        window.location.href="/college/payment_chart?year="+checkValue;
    }

</script>
</body>
</html>

