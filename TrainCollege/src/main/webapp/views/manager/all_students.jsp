<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018/2/3
  Time: 18:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Train COLLEGE | All Students</title>
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
        <jsp:param name="students" value="active menu-open"/>
        <jsp:param name="all_students" value="active"/>
    </jsp:include>

    <div class="content-wrapper">
        <!-- 大标题 -->
        <section class="content-header">
            <h1>
                学员信息
                <small>所有学员</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/college_manager/homepage"><i class="fa fa-home"></i> 主页</a></li>
                <li class="active">所有学员</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">

                        <div class="box-body">
                            <table id="student-table" class="table table-bordered table-hover">

                            </table>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->

            <div class="modal fade" id="student-more">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">学员信息</h4>
                        </div>
                        <div class="modal-body">

                            <div class="box-body box-profile">
                                <img class="profile-user-img img-responsive img-circle" src="/image/user.jpg" alt="User profile picture">
                                <h3 id="stu_name" class="profile-name text-center"></h3>
                                <p id="stu_id" class="text-muted text-center"></p>

                                <ul class="list-group list-group-unbordered">
                                    <li class="list-group-item">
                                        <i class="fa fa-envelope margin-r-5"></i><b> 电子邮箱</b> <a class="pull-right" id="stu_email"></a>
                                    </li>
                                    <li class="list-group-item">
                                        <i class="fa fa-phone margin-r-5"></i><b> 联系方式</b> <a class="pull-right" id="stu_phone"></a>
                                    </li>
                                    <li class="list-group-item">
                                        <i class="fa fa-user margin-r-5"></i><b> 用户状态</b> <a class="pull-right" id="stu_state"></a>
                                    </li>
                                    <li class="list-group-item">
                                        <i class="fa fa-star-half-o margin-r-5"></i><b> 经验值</b> <a class="pull-right" id="stu_expr"></a>
                                    </li>
                                </ul>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->

        </section>
        <!-- /.content -->

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
        $('#student-table').DataTable({
            "ajax": {
                "url": "/college_manager/all_students",
                "type": "POST"
            },
            "columns"     : [
                { "title": "ID",
                    "data":"id"},
                { "title": "名称",
                    "data":"username"},
                { "title": "电子邮箱",
                    "data":"email"},
                { "title": "联系电话",
                    "data":"phone"},
                { "title": "状态",
                    "data":"state"},
                { "title": "操作" }
            ],
            "aoColumnDefs":[//设置列的属性，此处设置最后一列
                {
                    "targets": -1,
                    "class": "but_xq",
                    "data": null,
                    "bSortable": false,
                    "defaultContent": "<a id=‘more’ onclick='more(this)' href='#'>查看详情</a>"
                }
            ],
            //每行回调函数
            "fnRowCallback": function( nRow, aData ) {
                //每行中的状态列  该状态进行判断 并设置相关的列值
                var state = aData.state;
                switch (state){
                    case 0:
                        $('td:eq(4)', nRow).html("未验证");
                        break;
                    case 1:
                        $('td:eq(4)', nRow).html("已验证");
                        break;
                    case 2:
                        $('td:eq(4)', nRow).html("已注销");
                        break;
                }

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
    })

    /**
     * 查看详情
     */
    function more(node) {
        var id = node.parentNode.parentNode.firstChild.textContent;
        $.post("/college_manager/get_student",
            {
                id:id
            },
            function(data,status){
                if(!data)
                    alert("查询失败,数据库未连接");
                else{
                    $('#stu_id').text(data.id);
                    $('#stu_username').text(data.name);
                    $('#stu_email').text(data.email);
                    $('#stu_expr').text(data.expr);
                    $('#stu_phone').text(data.phone);
                    switch (data.state){
                        case 0:
                            $('#stu_state').text("未验证");
                            break;
                        case 1:
                            $('#stu_state').text("已验证");
                            break;
                        case 2:
                            $('#stu_state').text("已注销");
                            break;
                    }

                    $('#student-more').modal('show');
                }
            });

    }
</script>
</body>
</html>
