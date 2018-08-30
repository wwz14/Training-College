<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018/2/7
  Time: 19:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Train COLLEGE | Enroll</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->

    <!-- Select2 -->
    <link href="https://cdn.bootcss.com/select2/4.0.6-rc.1/css/select2.min.css" rel="stylesheet">
    <!-- Font Awesome -->
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
        <jsp:param name="browse" value="active"/>
    </jsp:include>

    <div class="content-wrapper">

        <!-- 大标题 -->
        <section class="content-header">
            <h1>
                所有课程计划
                <small>查看详情，进一步了解</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/student/homepage"><i class="fa fa-home"></i> 主页</a></li>
                <li><a href="/student/show_lesson?lid=${lesson.id}"> ${lesson.name}</a></li>
                <li class="active">报名页面</li>
            </ol>
        </section>


                <h4><i class="fa fa-info"></i> 提示：已选择手动选班，一个订单最多报名3人</h4>



        <form action="/student/enroll_lesson_with_class" method="post">
        <!-- Main content -->
        <section class="content" id="students">

            <%--基础成员--%>
            <div class="col-md-4">

                <div class="box box-info">
                    <div class="box-header">
                        <h3 class="box-title"><i class="fa fa-angle-right"></i> 填写学员信息</h3>
                    </div>
                    <div class="box-body">
                        <input type="hidden" value="with" name="with_class">
                        <input id="student-num" type="hidden" value="1" name="studentNum">
                        <input type="hidden" name="type1" value="1">
                        <input type="hidden" name="lid" value="${lesson.id}">

                        <div class="form-group">
                            <label>会员邮箱：</label>
                            <input readonly value="${student.email}" name="id1" type="email" class="form-control">
                            <span class="help-block">默认本人邮箱，无需填写</span>
                            <!-- /.input group -->
                        </div>
                        <!-- /.form group -->

                        <div class="form-group">
                            <label>班级类型（单选）：</label>
                            <select name="classId1" class="form-control select2" style="width: 100%;" required>
                                <c:forEach items="${classList}" var="item" >
                                    <option value="${item.id}">${item.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <button class="btn btn-default" type="submit">保存</button>
                        <button class="btn btn-info pull-right" type="button" onclick="add()">新增学员</button>
                    </div>
                    <!-- /.box-footer -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (1) -->

                <div class="modal fade" id="type-modal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">新增学员是否为本站会员？</h4>
                            </div>

                            <div class="modal-footer">
                                <button class="btn btn-default pull-left" data-dismiss="modal">我再想想</button>
                                <button class="btn btn-success" onclick="add_student(false)" type="button">不是会员</button>
                                <button class="btn btn-primary" onclick="add_student(true)" type="button">是会员</button>
                            </div>
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                    <!-- /.modal lesson -->
                </div>

        </section>
        </form>

    </div>

    <jsp:include page="../public/footer.jsp" flush="true" />
</div>



<%--<!-- SlimScroll -->--%>
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
<script>
    function add() {
        var id = parseInt(document.getElementById("student-num").value);
        if(id>=3){
            alert("新增失败，该订单最多可包含3名学员。");
        }else{
            $('#type-modal').modal('show');
        }
    }
    function add_student(isVIP) {
        var id = parseInt(document.getElementById("student-num").value)+1;
        if(isVIP){
            $('#students').append('<div class="col-md-4">\n' +
                '\n' +
                '                <div class="box box-info">\n' +
                '                    <div class="box-header">\n' +
                '                        <h3 class="box-title"><i class="fa fa-angle-right"></i> 填写学员信息(会员)</h3>\n' +
                '                    </div>\n' +
                '                    <div class="box-body">\n' +
                '                        <input type="hidden" name="type'+id+'" value="1">\n' +
                '\n' +
                '                        <div class="form-group">\n' +
                '                            <label>会员邮箱：</label>\n' +
                '                            <input name="id'+id+'" type="email" class="form-control" onchange="checkEmail(this)" required>\n' +
                '                            <span class="help-block">填写该会员注册用邮箱</span>\n' +
                '                        </div>\n' +
                '\n' +
                '                        <div class="form-group">\n' +
                '                            <label>班级类型（单选）：</label>\n' +
                '                            <select name="classId'+id+'" class="form-control select2" style="width: 100%;" required>\n' +
                '                                <c:forEach items="${classList}" var="item" >\n' +
                '                                    <option value="${item.id}">${item.name}</option>\n' +
                '                                </c:forEach>\n' +
                '                            </select>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '\n' +
                '                    <div class="box-footer">\n' +
                '                        <button class="btn btn-danger pull-right" type="button" onclick="delete_student(this.parentNode.parentNode.parentNode)">删除</button>\n' +
                '                    </div>\n' +
                '                </div>\n' +
                '            </div>');
        }else{
            $('#students').append('<div class="col-md-4">\n' +
                '\n' +
                '                <div class="box box-info">\n' +
                '                    <div class="box-header">\n' +
                '                        <h3 class="box-title"><i class="fa fa-angle-right"></i> 填写学员信息(非会员)</h3>\n' +
                '                    </div>\n' +
                '                    <div class="box-body">\n' +
                '                        <input type="hidden" name="type'+id+'" value="0">\n' +
                '\n' +
                '                        <div class="form-group">\n' +
                '                            <label>学员姓名：</label>\n' +
                '                            <input name="id'+id+'" type="text" class="form-control" required>\n' +
                '                        </div>\n' +
                '\n' +
                '                        <div class="form-group">\n' +
                '                            <label>联系电话：</label>\n' +
                '                            <input name="phone'+id+'" type="tel" class="form-control" required>\n' +
                '                        </div>\n' +
                '\n' +
                '                        <div class="form-group">\n' +
                '                            <label>班级类型（单选）：</label>\n' +
                '                            <select name="classId'+id+'" class="form-control select2" style="width: 100%;" required>\n' +
                '                                <c:forEach items="${classList}" var="item" >\n' +
                '                                    <option value="${item.id}">${item.name}</option>\n' +
                '                                </c:forEach>\n' +
                '                            </select>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '\n' +
                '                    <div class="box-footer">\n' +
                '                        <button class="btn btn-danger pull-right" type="button" onclick="delete_student(this.parentNode.parentNode.parentNode)">删除</button>\n' +
                '                    </div>\n' +
                '                </div>\n' +
                '            </div>');
        }
        $('#student-num').val(id);
        $('#type-modal').modal('hide');

    }
    function delete_student(node) {
        node.parentNode.removeChild(node);
        $('#student-num').val(parseInt(document.getElementById("student-num").value)-1);
    }

    function checkEmail(node) {
        var email = node.value;
        var parent = node.parentNode;
        $.post("/student/get_student_by_email",
            {
                email: email
            },
            function (data) {
                if (data==true) {
                    $(parent).attr("class","form-group has-success")
                    parent.getElementsByClassName("help-block").item(0).innerHTML = '<i class="fa fa-check"></i> 该邮箱会员存在';
                }
                else {
                    $(parent).attr("class","form-group has-error")
                    parent.getElementsByClassName("help-block").item(0).innerHTML = '<i class="fa fa-times-circle-o"></i> 该邮箱会员不存在';
                    $(node).val("");
                }
            });


    }
</script>
</body>
</html>
