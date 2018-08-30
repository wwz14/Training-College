<%--
  Created by IntelliJ IDEA.
  User: jqwu
  Date: 2018/2/27
  Time: 下午1:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    .box.box-success {
        border-top-color: #7E3D76;
    }
</style>
<body class="skin-green-light sidebar-mini">
<div class="wrapper">
    <jsp:include page="../public/manager_header.jsp" flush="true" />

    <jsp:include page="../public/manager_nav.jsp" flush="true" >
        <jsp:param name="money" value="active menu-open"/>
        <jsp:param name="college_payment" value="active"/>
    </jsp:include>

    <div class="content-wrapper">
        <!-- 大标题 -->
        <section class="content-header">
            <h1>
                机构结算
            </h1>
            <ol class="breadcrumb">
                <li><a href="/college_manager/homepage"><i class="fa fa-home"></i> 主页</a></li>
                <li class="active">机构结算</li>
            </ol>
        </section>



        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">

                        <div class="box-body">
                            <table id="payment-table" class="table table-bordered table-hover">

                            </table>
                        </div>
                        <!-- /.box-body -->

                        <div class="box-footer">
                            <button class="btn btn-success pull-right" data-toggle="modal" data-target="#setting">结算</button>
                        </div>
                    </div>
                    <!-- /.box -->
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->

            <div class="modal fade" id="setting">
                <div class="modal-dialog">
                    <form action="/college_manager/college_pay" method="post">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">分成设置</h4>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label>分成比例：（分给各个机构的钱所占比例，两位小数）</label>
                                    <input name="proportion" class="form-control" required placeholder="0.80">
                                    <!-- /.input group -->
                                </div>
                                <!-- /.form group -->

                            </div>
                            <div class="modal-footer">
                                <button class="btn pull-left" type="button" data-dismiss="modal">取消</button>
                                <button type="button" class="btn btn-primary">确认</button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </form>
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
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
<script>

    $(function () {
        $('#payment-table').DataTable({

            "ajax": {
                "url": "/college_manager/all_pay_college",
                "type": "POST"
            },
            "columns"     : [
                { "title": "机构编号",
                    "data":"cid"},
                { "title": "总收入",
                    "data":"in"},
                { "title": "总退款",
                    "data":"out"},
                { "title": "交易数",
                    "data":"number"}
            ],
            //每行回调函数
            "fnRowCallback": function( nRow, aData ) {
                //为id前面补0
                var id = aData.cid;
                $('td:eq(0)', nRow).html(( "0000000" + id ).substr( -7 ));

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
                "sUrl": "",
                "sEmptyTable": "表中数据为空",
                "sLoadingRecords": "表中数据为空",
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

