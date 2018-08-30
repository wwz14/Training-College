<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018/2/20
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>Train COLLEGE | Attendance</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->
    <!-- Select2 -->
    <link href="https://cdn.bootcss.com/select2/4.0.6-rc.1/css/select2.min.css" rel="stylesheet">
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
                学员信息
                <small>查看考勤记录</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/college/homepage"><i class="fa fa-home"></i> 主页</a></li>
                <li><a href="/college/show_classes?lid=${lesson.id}"> ${lesson.name}</a></li>
                <li class="active"> ${classes.name}</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">

                        <div class="box-body">
                            <table id="attd-table" class="table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>姓名</th>
                                    <c:forEach items="${attdList}" var="item">
                                        <th><fmt:formatDate value="${item.lessonDate}" pattern="yyyy-MM-dd hh:mm"/></th>
                                    </c:forEach>
                                </tr>
                                </thead>
                            </table>
                        </div>
                        <!-- /.box-body -->

                        <div class="box-footer">
                            <button type="button" class="btn btn-success pull-right" onclick="javascript:history.go(-1);"
                                    style="margin-right: 10px">返回</button>
                        </div>
                        <!-- /.box-footer -->
                    </div>
                    <!-- /.box -->
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->

            <div class="modal fade" id="class-choose-modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">选择班级</h4>
                        </div>
                        <div class="modal-body">
                            <form action="/college/show_students" method="get">
                                <div class="box-body">
                                    <input type="hidden" name="classId" value="${classes.id}">

                                    <div class="form-group">
                                        <select name="classNo" class="form-control select2" style="width: 100%;" required>
                                            <option value="0"> 待分配</option>
                                            <c:forEach var="i" begin="1" end="${classes.num}" step="1">
                                                <option value="${i}"> ${i} 班</option>
                                            </c:forEach>
                                            <option value="-1"> 全部</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <button id="delete-button" class="btn btn-danger pull-left" data-dismiss="modal">取消</button>
                                    <button type="submit" class="btn btn-primary">确认</button>
                                </div>
                            </form>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal class -->
            </div>

        </section>
        <!-- /.content -->

    </div>

    <jsp:include page="../public/footer.jsp" flush="true" />
</div>

<!-- Select2 -->
<script src="https://cdn.bootcss.com/select2/4.0.6-rc.1/js/select2.full.min.js"></script>
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
        $('#attd-table').DataTable({
            "ajax": {
                "url": "/datadb/mydata/progresses_by_classId_no",
                "type": "POST",
                "data": {
                    "classId": ${classes.id},
                    "classNo":${classNo}
                }
            },
            "aoColumnDefs": [
                {
                    "mData": null,//这是关键
                    "aTargets": ["_all"]
                }],
            //每行回调函数
            "fnRowCallback": function( nRow, aData ) {
                //每行中的状态列  该状态进行判断 并设置相关的列值
                $.post("/datadb/normal_student_by_id",
                    {
                        id: aData.uid
                    },
                    function (data) {
                        $('td:eq(0)', nRow).html(data.username);
                    });
                $.post("/datadb/attendance_by_lpid_type",
                    {
                        lpid: aData.id,
                        type: 0
                    },
                    function (data) {
                    console.log(data.length);
                        for(var i = 1;i<=data.length;i++){
                            switch (data[i-1].grade){
                                // 考勤，0为缺勤，1为迟到，2为早退，3为出勤；
                                case 0:
                                    $('td:eq('+i+')', nRow).html("<i class='fa fa-close' style='color:red;'></i>");
                                    break;
                                case 1:
                                    $('td:eq('+i+')', nRow).html("迟到");
                                    break;
                                case 2:
                                    $('td:eq('+i+')', nRow).html("早退");
                                    break;
                                case 3:
                                    $('td:eq('+i+')', nRow).html("<i class='fa fa-check' style='color:green;'></i>");
                                    break;
                            }

                        }
                    });

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

