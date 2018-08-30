<%--
  Created by IntelliJ IDEA.
  User: jqwu
  Date: 2018/2/25
  Time: 下午3:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Train COLLEGE | Progress </title>
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
        <jsp:param name="my_progress" value="active menu-open"/>
        <jsp:param name="has_pay_progress" value="active"/>
    </jsp:include>

    <div class="content-wrapper">

        <!-- 大标题 -->
        <section class="content-header">
            <h1>
                课程记录
                <small>考勤 & 成绩</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/student/homepage"><i class="fa fa-home"></i> 主页</a></li>
                <li><a href="/student/has_pay_progress"><i class="fa fa-home"></i> 已付课程</a></li>
                <li class="active">课程记录</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="nav-tabs-custom">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#attd-data" data-toggle="tab">签到记录</a></li>
                            <li><a href="#grade-data" data-toggle="tab">成绩记录</a></li>
                            <li><a href="#charts" data-toggle="tab">图表展示</a></li>
                        </ul>

                        <div class="tab-content">
                            <div class="active tab-pane" id="attd-data">
                                <div class="box">

                                    <div class="box-body">
                                        <table id="attendance-table" class="table table-bordered table-hover">

                                        </table>
                                    </div>
                                    <!-- /.box-body -->
                                </div>
                                <!-- /.box -->
                            </div>
                            <!-- /.tab-pane-->

                            <div class="tab-pane" id="grade-data">
                                <div class="box">

                                    <div class="box-body">
                                        <table id="grade-table" class="table table-bordered table-hover">

                                        </table>
                                    </div>
                                    <!-- /.box-body -->
                                </div>
                                <!-- /.box -->
                            </div>
                            <!-- /.tab-pane-->

                            <div class="tab-pane" id="charts">
                                <!-- DONUT CHART -->
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="box">
                                            <div class="box-header with-border">
                                                <h3 class="box-title">出勤率统计环形图</h3>
                                            </div>
                                            <div class="box-body">
                                                <canvas id="attdChart" style="height:250px"></canvas>
                                            </div>
                                            <!-- /.box-body -->
                                        </div>
                                        <!-- /.box -->
                                    </div>

                                    <!-- DONUT CHART -->
                                    <div class="col-sm-6">
                                        <div class="box">
                                            <div class="box-header with-border">
                                                <h3 class="box-title">分数区间柱状图</h3>
                                            </div>
                                            <div class="box-body">
                                                <canvas id="gradeChart" style="height:250px"></canvas>
                                            </div>
                                            <!-- /.box-body -->
                                        </div>
                                        <!-- /.box -->
                                    </div>
                                </div>
                            </div>
                            <!-- /.tab-pane-->
                        </div>
                        <!-- /.tab-content -->
                    </div>
                    <!-- /.tabs -->


                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->

        </section>
        <!-- /.content -->

    </div>

    <jsp:include page="../public/footer.jsp" flush="true" />
</div>

<!-- jQuery 3 -->
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- ChartJS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.js"></script>
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
<script>
    $(function () {
        //-------------
        //- 出勤统计 CHART -
        //-------------
        // Get context with jQuery - using jQuery's .get() method.
        var ctx = document.getElementById("attdChart");
        var pieChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ["缺勤", "迟到", "早退", "出勤"],
                datasets: [{
                    data: [${state[0]},${state[1]},${state[2]},${state[3]}],
                    backgroundColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)'
                    ]
                }]
            }
        });

        var ctx2 = document.getElementById("gradeChart");
        var barChart = new Chart(ctx2, {
            type: 'bar',
            data: {
                labels: ["<60分", "60~79分", "80~89分", "90~100分"],
                datasets: [{
                    data: [${grade[0]}, ${grade[1]}, ${grade[2]}, ${grade[3]}],
                    backgroundColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)'
                    ]
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero:true
                        }
                    }]
                },
                legend: {
                    display: false
                }
            }
        });



        $('#attendance-table').DataTable({
            "ajax": {
                "url": "/datadb/mydata/attendance_by_lpid_type",
                "type": "POST",
                "data": {
                    "lpid": ${lpid},
                    "type": 0
                }
            },
            "columns"     : [
                { "title": "日期",
                    "data":"lessonDate"},
                { "title": "签到",
                    "data":"grade"}
            ],
            //每行回调函数
            "fnRowCallback": function( nRow, aData ) {
                //每行中的状态列  该状态进行判断 并设置相关的列值
                var grade= aData.grade;
                switch (grade){
                    case 0:
                        $('td:eq(1)', nRow).html("<i class='fa fa-close' style='color:red;'></i>");
                        break;
                    case 1:
                        $('td:eq(1)', nRow).html("迟到");
                        break;
                    case 2:
                        $('td:eq(1)', nRow).html("早退");
                        break;
                    case 3:
                        $('td:eq(1)', nRow).html("<i class='fa fa-check' style='color:green;'></i>");
                        break;
                }
                var date = new Date(aData.lessonDate);
                $('td:eq(0)', nRow).html(date.toLocaleDateString());

            },

            'paging'      : true,
            'lengthChange': false,
            'searching'   : true,
            'ordering'    : true,
            'autoWidth'   : false,
            language: {
                "sProcessing": "处理中...",
                "sLengthMenu": "显示 _MENU_ 项结果",
                "sZeroRecords": "没有匹配结果",
                "sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
                "sInfoEmpty": "显示第 0 至 0 项结果，共 0 项",
                "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
                "sInfoPostFix": "",
                "sSearch": "搜索:",
                "sUrl": "",
                "sEmptyTable": "表中数据为空",
                "sLoadingRecords": "载入中...",
                "sInfoThousands": ",",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "上页",
                    "sNext": "下页",
                    "sLast": "末页"
                },
                "oAria": {
                    "sSortAscending": ": 以升序排列此列",
                    "sSortDescending": ": 以降序排列此列"
                }
            }
        });

        $('#grade-table').DataTable({
            "ajax": {
                "url": "/datadb/mydata/attendance_by_lpid_type",
                "type": "POST",
                "data": {
                    "lpid": ${lpid},
                    "type": 1
                }
            },
            "columns"     : [
                { "title": "日期",
                    "data":"lessonDate"},
                { "title": "成绩",
                    "data":"grade"}
            ],
            //每行回调函数
            "fnRowCallback": function( nRow, aData ) {
                //每行中的状态列  该状态进行判断 并设置相关的列值
                var date = new Date(aData.lessonDate);
                $('td:eq(0)', nRow).html(date.toLocaleDateString());

            },

            'paging'      : true,
            'lengthChange': false,
            'searching'   : true,
            'ordering'    : true,
            'autoWidth'   : false,
            language: {
                "sProcessing": "处理中...",
                "sLengthMenu": "显示 _MENU_ 项结果",
                "sZeroRecords": "没有匹配结果",
                "sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
                "sInfoEmpty": "显示第 0 至 0 项结果，共 0 项",
                "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
                "sInfoPostFix": "",
                "sSearch": "搜索:",
                "sUrl": "",
                "sEmptyTable": "表中数据为空",
                "sLoadingRecords": "载入中...",
                "sInfoThousands": ",",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "上页",
                    "sNext": "下页",
                    "sLast": "末页"
                },
                "oAria": {
                    "sSortAscending": ": 以升序排列此列",
                    "sSortDescending": ": 以降序排列此列"
                }
            }
        })
    });
</script>
</body>
</html>
