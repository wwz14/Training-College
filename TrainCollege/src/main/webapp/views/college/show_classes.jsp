<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018/2/19
  Time: 12:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Train COLLEGE | Class List</title>
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
    .box.box-success {
        border-top-color: #7E3D76;
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
                班级信息
                <small>查看学员信息，增加考勤记录</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/college/homepage"><i class="fa fa-home"></i> 主页</a></li>
                <li><a href="/college/begin_lessons"> 已截止课程</a></li>
                <li class="active">班级信息</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">

                        <div class="box-body">
                            <table id="class-table" class="table table-bordered table-hover">

                            </table>
                        </div>
                        <!-- /.box-body -->

                        <div class="box-footer">
                            <p>剩余${left_num}人未分班</p>
                            <button class="btn btn-danger pull-right" style="margin-right: 10px" onclick="arrange()">强制分班</button>
                        </div>
                    </div>
                    <!-- /.box -->
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
        $('#class-table').DataTable({
            "ajax": {
                "url": "/datadb/mydata/classes_by_lid",
                "type": "POST",
                "data": {
                    "lid": ${lesson.id}
                }
            },
            "columns"     : [
                { "title": "班级名称",
                    "data":"name"},
                { "title": "班级大小",
                    "data":"size"},
                { "title": "班级数量",
                    "data":"num"},
                { "title": "已报名人数",
                    "data":"size"},
                { "title": "教师",
                    "data":"teacher"},
                { "title": "操作" }
            ],
            "aoColumnDefs":[//设置列的属性，此处设置最后一列
                {
                    "targets": -1,
                    "class": "but_xq",
                    "data": null,
                    "bSortable": false,
                    "defaultContent": ""
                }
            ],
            //每行回调函数
            "fnRowCallback": function( nRow, aData ) {
                //每行中的状态列  该状态进行判断 并设置相关的列值
                $.post("/datadb/progresses_by_classId_no",
                    {
                        classId: aData.id,
                        classNo:-1
                    },
                    function (data) {
                        $('td:eq(3)', nRow).html(data.length);
                    });
                $('td:eq(5)', nRow).html('<a href="/college/show_students?classId='+aData.id+'&classNo=all">查看名单</a>');
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

    function arrange() {
        $.post("/college/arrange_class",
            {
                lid: ${lesson.id}
            },
            function (data) {
                if(data==true){
                    alert("分班成功");
                    window.location.reload();
                }else{
                    alert("分班失败");
                }
            });
    }
</script>
</body>
</html>
