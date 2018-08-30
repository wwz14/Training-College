<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018/2/4
  Time: 16:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Train COLLEGE | Create Lesson</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <!-- daterange picker -->
    <link href="https://cdn.bootcss.com/bootstrap-daterangepicker/2.1.27/daterangepicker.css" rel="stylesheet">
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

    .box.box-info {
        border-top-color: #7E3D76;
    }
</style>
<body class="skin-green-light sidebar-mini">
<div class="wrapper">
    <jsp:include page="../public/college_header.jsp" flush="true" />

    <jsp:include page="../public/college_nav.jsp" flush="true" >
        <jsp:param name="lesson_more" value="active menu-open"/>
        <jsp:param name="new_lesson" value="active"/>
    </jsp:include>

    <div class="content-wrapper">

        <!-- 大标题 -->
        <section class="content-header">
            <h1>
                新建课程计划
                <small>添加不同的班级</small>
                <small style="color: red">${error}</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/college/homepage"><i class="fa fa-home"></i> 主页</a></li>
                <li class="active">新建课程计划</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <form action="/college/create_lesson" method="post">
            <div >

                <%--课程计划部分--%>
                <div >

                    <div class="box box-info">
                        <div class="box-header">
                            <h3 class="box-title"><i class="fa fa-angle-right"></i> 填写课程计划信息</h3>
                        </div>
                        <div class="box-body">

                            <!-- lesson name -->
                            <div class="form-group">
                                <label>课程计划名称：</label>

                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-send"></i>
                                    </div>
                                    <input name="name" type="text" class="form-control pull-right" placeholder="计划名称" required>
                                </div>
                                <!-- /.input group -->
                            </div>
                            <!-- /.form group -->

                            <div class="form-group">
                                <label>课程类型（可多选）：</label>
                                <select name="type" class="form-control select2" multiple="multiple" data-placeholder="选择类型"
                                        style="width: 100%;">
                                    <option>语文</option>
                                    <option>数学</option>
                                    <option>外语</option>
                                    <option>物理</option>
                                    <option>化学</option>
                                    <option>生物</option>
                                    <option>地理</option>
                                    <option>政治</option>
                                    <option>历史</option>
                                    <option>艺术</option>
                                    <option>计算机</option>
                                    <option>考研</option>
                                    <option>其它</option>
                                </select>
                            </div>

                            <!-- Date range -->
                            <div class="form-group">
                                <label>课程周期：</label>

                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                    <input name="date_range" type="text" class="form-control pull-right" id="date-range" required>
                                </div>
                                <!-- /.input group -->
                            </div>
                            <!-- /.form group -->

                            <!-- 课时 -->
                            <div class="form-group">
                                <label>课时数量（每周）：</label>

                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-files-o"></i>
                                    </div>
                                    <input name="times" type="number" class="form-control" placeholder="2">
                                </div>
                                <!-- /.input group -->
                            </div>
                            <!-- /.form group -->

                            <!-- 周次 -->
                            <div class="form-group">
                                <label>周次数量：</label>

                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-files-o"></i>
                                    </div>
                                    <input name="weeks" type="number" class="form-control" placeholder="12">
                                </div>
                                <!-- /.input group -->
                            </div>
                            <!-- /.form group -->

                            <!-- introduction -->
                            <div class="form-group">
                                <label>课程介绍</label>
                                <textarea name="intro" class="form-control" rows="5" placeholder="写点什么吧"></textarea>
                            </div>

                        </div>
                        <!-- /.box-body -->

                        <div class="box-footer">
                            <button class="btn btn-info pull-right" type="submit">保存信息</button>
                        </div>
                        <!-- /.box-footer -->
                    </div>
                    <!-- /.box -->

                </div>
                <!-- /.col (left) -->

                <%--班级详情--%>
                <div  id="classes-more">
                    <input name="class_num" type="hidden" id="class-num" value="1">
                    <div class="box box-primary">
                        <div class="box-header">
                            <h3 class="box-title"><i class="fa fa-angle-double-right"></i> 填写班级信息</h3>
                        </div>
                        <div class="box-body">

                            <!-- 班级名称 -->
                            <div class="form-group">
                                <label>班级名称：</label>

                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-tag"></i>
                                    </div>
                                    <input name="classname1" type="text" class="form-control pull-right" placeholder="班级名称" required>
                                </div>
                                <!-- /.input group -->
                            </div>
                            <!-- /.form group -->

                            <!-- 教师名称 -->
                            <div class="form-group">
                                <label>教师名称：</label>

                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-user"></i>
                                    </div>
                                    <input name="teacher1" type="text" class="form-control pull-right" placeholder="教师姓名" required>
                                </div>
                                <!-- /.input group -->
                            </div>
                            <!-- /.form group -->

                            <!-- 班级价格 -->
                            <div class="form-group">
                                <label>收费标准：</label>

                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-rmb"></i>
                                    </div>
                                    <input name="price1" type="number" class="form-control pull-right" placeholder="2000" required>
                                </div>
                                <!-- /.input group -->
                            </div>
                            <!-- /.form group -->

                            <!-- 每班人数 -->
                            <div class="form-group">
                                <label>班级规格：</label>

                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-info"></i>
                                    </div>
                                    <input name="size1" type="number" class="form-control" placeholder="45">
                                </div>
                                <!-- /.input group -->
                            </div>
                            <!-- /.form group -->

                            <!-- 班级个数 -->
                            <div class="form-group">
                                <label>班级个数：</label>

                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-info"></i>
                                    </div>
                                    <input name="amount1" type="number" class="form-control" placeholder="1">
                                </div>
                                <!-- /.input group -->
                            </div>
                            <!-- /.form group -->

                        </div>
                        <!-- /.box-body -->

                        <div class="box-footer">
                            <button type="button" class="btn btn-info pull-right" onclick="addClass()">新增班级</button>
                        </div>
                        <!-- /.box-footer -->
                    </div>
                    <!-- /.box -->


                </div>
                <!-- /.col (right) -->
            </div</form>
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
<!-- date-range-picker -->
<script src="https://cdn.bootcss.com/moment.js/2.22.0/moment.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap-daterangepicker/2.1.27/daterangepicker.js"></script>
<!-- Select2 -->
<script src="https://cdn.bootcss.com/select2/4.0.6-rc.1/js/select2.full.min.js"></script>

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
        //Initialize Select2 Elements
        $('.select2').select2();
        //Date range picker
        $('#date-range').daterangepicker({
            locale : {
                format: 'YYYY-MM-DD',
                separator: ' ~ ',
                minDate:[moment(), moment()],
                applyLabel : '确定',
                cancelLabel : '取消',
                fromLabel : '起始时间',
                toLabel : '结束时间',
                daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
                monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
                    '七月', '八月', '九月', '十月', '十一月', '十二月' ],
                firstDay : 1
            }
        });
    })

    function addClass() {
        var id = parseInt(document.getElementById("class-num").value)+1;
        $('#class-num').val(id);
        $('#classes-more').prepend('<div class="box box-primary">\n' +
            '                        <div class="box-header">\n' +
            '                            <h3 class="box-title"><i class="fa fa-angle-double-right"></i> 填写班级信息</h3>\n' +
            '                        </div>\n' +
            '                        <div class="box-body">\n' +
            '\n' +
            '                            <!-- 班级名称 -->\n' +
            '                            <div class="form-group">\n' +
            '                                <label>班级名称：</label>\n' +
            '\n' +
            '                                <div class="input-group">\n' +
            '                                    <div class="input-group-addon">\n' +
            '                                        <i class="fa fa-tag"></i>\n' +
            '                                    </div>\n' +
            '                                    <input name="classname'+id+'" type="text" class="form-control pull-right" placeholder="班级名称" required>\n' +
            '                                </div>\n' +
            '                                <!-- /.input group -->\n' +
            '                            </div>\n' +
            '                            <!-- /.form group -->\n' +
            '\n' +
            '                            <!-- 教师名称 -->\n' +
            '                            <div class="form-group">\n' +
            '                                <label>教师名称：</label>\n' +
            '\n' +
            '                                <div class="input-group">\n' +
            '                                    <div class="input-group-addon">\n' +
            '                                        <i class="fa fa-user"></i>\n' +
            '                                    </div>\n' +
            '                                    <input name="teacher'+id+'" type="text" class="form-control pull-right" placeholder="教师姓名" required>\n' +
            '                                </div>\n' +
            '                                <!-- /.input group -->\n' +
            '                            </div>\n' +
            '                            <!-- /.form group -->\n' +
            '\n' +
            '                            <!-- 班级价格 -->\n' +
            '                            <div class="form-group">\n' +
            '                                <label>收费标准：</label>\n' +
            '\n' +
            '                                <div class="input-group">\n' +
            '                                    <div class="input-group-addon">\n' +
            '                                        <i class="fa fa-rmb"></i>\n' +
            '                                    </div>\n' +
            '                                    <input name="price'+id+'" type="number" class="form-control pull-right" placeholder="2000" required>\n' +
            '                                </div>\n' +
            '                                <!-- /.input group -->\n' +
            '                            </div>\n' +
            '                            <!-- /.form group -->\n' +
            '\n' +
            '                            <div class="form-group">\n' +
            '                                <label>班级规格：</label>\n' +
            '\n' +
            '                                <div class="input-group">\n' +
            '                                    <div class="input-group-addon">\n' +
            '                                        <i class="fa fa-info"></i>\n' +
            '                                    </div>\n' +
            '                                    <input name="size'+id+'" type="number" class="form-control" placeholder="45">\n' +
            '                                </div>\n' +
            '                                <!-- /.input group -->\n' +
            '                            </div>\n' +
            '                            <!-- /.form group -->\n' +
            '                            <div class="form-group">\n' +
            '                                <label>班级个数：</label>\n' +
            '\n' +
            '                                <div class="input-group">\n' +
            '                                    <div class="input-group-addon">\n' +
            '                                        <i class="fa fa-info"></i>\n' +
            '                                    </div>\n' +
            '                                    <input name="amount'+id+'" type="number" class="form-control" placeholder="1">\n' +
            '                                </div>\n' +
            '                                <!-- /.input group -->\n' +
            '                            </div>\n' +
            '                            <!-- /.form group -->\n' +
            '\n' +
            '                        </div>\n' +
            '                        <!-- /.box-body -->\n' +
            '\n' +
            '                        <div class="box-footer">\n' +
            '                            <button class="btn btn-danger" onclick="deleteClass(this)">删除</button>\n' +
            '                        </div>\n' +
            '                        <!-- /.box-footer -->\n' +
            '                    </div>');
    }

    function deleteClass(node) {
        $('#class-num').value = parseInt(document.getElementById("class-num").value)-1;

        var child = node.parentNode.parentNode;
        child.parentNode.removeChild(child);
    }
</script>
</body>
</html>
