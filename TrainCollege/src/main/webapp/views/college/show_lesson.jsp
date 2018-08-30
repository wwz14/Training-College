<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018/2/6
  Time: 10:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Train COLLEGE | Show Lesson</title>
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
    .box.box-success {
        border-top-color: #7E3D76;
    }
</style>
<body class="skin-green-light sidebar-mini">
<div class="wrapper">
    <jsp:include page="../public/college_header.jsp" flush="true" />

    <jsp:include page="../public/college_nav.jsp" flush="true" >
        <jsp:param name="browse" value="active menu-open"/>
    </jsp:include>

    <div class="content-wrapper">

        <!-- 大标题 -->
        <section class="content-header">
            <h1>
                课程计划
                <small>包含不同的班级</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/college/homepage"><i class="fa fa-home"></i> 主页</a></li>
                <li><a href="/college/all_lessons"> 所有课程计划</a></li>
                <li class="active">${lesson.name}</li>
            </ol>
        </section>


        <!-- Main content -->
        <section class="invoice">
            <!-- 课程标题 -->
            <div class="row">
                <div class="col-xs-12">
                    <h2 class="page-header">
                        <i class="fa fa-calendar"></i> ${lesson.name}
                        <small class="pull-right">${lesson_state}</small>
                    </h2>
                </div>
                <!-- /.col -->
            </div>
            <!-- 基础信息 -->
            <div class="row invoice-info">

                <div class="col-sm-3 invoice-col">
                    <b>课程名称：</b> ${lesson.name}<br>
                    <br>
                    <b>课程类型：</b> ${lesson.type}<br>
                    <b>课程周期：</b> <fmt:formatDate value="${lesson.startDay}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${lesson.endDay}" pattern="yyyy-MM-dd"/><br>
                    <b>每周课时：</b> ${lesson.timePerWeek} 课时/周<br>
                    <b>周次数量：</b> ${lesson.weekNum} 周
                </div>
                <!-- /.col -->

                <div class="col-sm-3 invoice-col">
                    <b>所属机构：</b> ${college.name}<br>
                    <br>
                    <b>联系电话：</b> ${college.phone}<br>
                    <b>地理位置：</b> ${college.location}<br>
                    <b>师资力量：</b> ${college.teacher}
                </div>
                <!-- /.col -->

                <div class="col-sm-6 invoice-col">
                    <b>课程介绍</b><br>
                    <br>
                    <address>${lesson.intro}</address>
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
                            <th>班级名称</th>
                            <th>每班人数</th>
                            <th>班级个数</th>
                            <th>授课教师</th>
                            <th>价格</th>
                            <c:if test="${lesson.state == '0'}">
                                <th>操作</th>
                            </c:if>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${classList}" var="item" >
                            <tr>
                                <td><c:out value="${item.name}"/></td>
                                <td><c:out value="${item.size}"/></td>
                                <td><c:out value="${item.num}"/></td>
                                <td><c:out value="${item.teacher}"/></td>
                                <td>￥<c:out value="${item.price}"/></td>
                                <c:if test="${lesson.state == 0}">
                                    <td id="<c:out value="${item.id}"/>">
                                        <button class="btn btn-default" title="删除" onclick="delete_class(this.parentNode.id)"><i class="fa fa-trash"></i></button>
                                        <button class="btn btn-default" title="修改" onclick="modify_class(this.parentNode.id)"><i class="fa fa-edit"></i></button>
                                    </td>
                                </c:if>

                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->

            <!-- 不被打印的按钮们 -->
            <div class="row no-print">
                <div class="col-xs-12">


                    <button id="release-button" onclick="release_lesson()" class="btn btn-success pull-right"><i
                            class="fa fa-check-square-o"></i> 发布
                    </button>
                    <button id="modify-lesson-button" onclick="modify_lesson()" class="btn btn-default pull-right"
                            style="margin-right: 5px;"><i class="fa fa-edit"></i> 修改计划
                    </button>
                    <button id="stop-enroll-button" onclick="stop_enroll()" class="btn btn-primary pull-right"
                            style="margin-right: 5px;"><i class="fa fa-hourglass-end"></i> 开课
                    </button>
                    <button id="cancel-button" onclick="cancel_lesson()" class="btn btn-danger pull-right"
                            style="margin-right: 5px;"><i class="fa fa-close"></i> 撤回发布
                    </button>
                    <button onclick="add_class()" class="btn btn-default pull-right" style="margin-right: 5px;"><i
                            class="fa fa-plus-square-o"></i> 新增班级
                    </button>
                </div>
            </div>


            <div class="modal fade" id="lesson-modify-modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">课程计划信息</h4>
                        </div>
                        <div class="modal-body">
                            <form action="/college/modify_lesson" method="post">
                                <div class="box-body">
                                    <input type="hidden" name="lid" value="${lesson.id}">
                                    <!-- lesson name -->
                                    <div class="form-group">
                                        <label>课程计划名称：</label>

                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-send"></i>
                                            </div>
                                            <input name="name" type="text" class="form-control pull-right"
                                                   placeholder="计划名称" value="${lesson.name}" required>
                                        </div>
                                        <!-- /.input group -->
                                    </div>
                                    <!-- /.form group -->

                                    <div class="form-group">
                                        <label>课程类型（可多选）：</label>
                                        <select name="type" class="form-control select2" multiple="multiple"
                                                data-placeholder="选择类型"
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
                                            <input name="date_range" type="text" class="form-control pull-right"
                                                   id="date-range" value='
<fmt:formatDate value="${lesson.startDay}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${lesson.endDay}" pattern="yyyy-MM-dd"/>'
                                                   required>
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
                                            <input name="times" type="number" class="form-control" placeholder="2"
                                                   value="${lesson.timePerWeek}">
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
                                            <input name="weeks" type="number" class="form-control" placeholder="12"
                                                   value="${lesson.weekNum}">
                                        </div>
                                        <!-- /.input group -->
                                    </div>
                                    <!-- /.form group -->

                                    <!-- introduction -->
                                    <div class="form-group">
                                        <label>课程介绍</label>
                                        <textarea name="intro" class="form-control" rows="5"
                                                  placeholder="写点什么吧">${lesson.intro}</textarea>
                                    </div>
                                </div>


                                <div class="modal-footer">
                                    <button class="btn btn-danger pull-left" data-dismiss="modal">取消</button>
                                    <button type="submit" class="btn btn-primary">保存修改</button>
                                </div>
                            </form>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal lesson -->
            </div>

            <div class="modal fade" id="class-modify-modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">班级信息</h4>
                        </div>
                        <div class="modal-body">
                            <form action="/college/modify_class" method="post">
                                <div class="box-body">
                                    <input type="hidden" name="lid" value="${lesson.id}">
                                    <input type="hidden" id="class-id" name="id" value="0">
                                    <!-- 班级名称 -->
                                    <div class="form-group">
                                        <label>班级名称：</label>

                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-tag"></i>
                                            </div>
                                            <input id="classname" name="classname" type="text"
                                                   class="form-control pull-right" placeholder="班级名称" required>
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
                                            <input id="teacher" name="teacher" type="text"
                                                   class="form-control pull-right" placeholder="教师姓名" required>
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
                                            <input id="price" name="price" type="number" class="form-control pull-right"
                                                   placeholder="2000" required>
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
                                            <input id="size" name="size" type="number" class="form-control"
                                                   placeholder="45">
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
                                            <input id="amount" name="amount" type="number" class="form-control"
                                                   placeholder="1">
                                        </div>
                                        <!-- /.input group -->
                                    </div>
                                    <!-- /.form group -->
                                </div>


                                <div class="modal-footer">
                                    <button id="delete-button" class="btn btn-danger pull-left"
                                            onclick="delete_class($('#class-id').id)">删除
                                    </button>
                                    <button type="submit" class="btn btn-primary">保存修改</button>
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
        <div class="clearfix"></div>
    </div>

    <jsp:include page="../public/footer.jsp" flush="true"/>
</div>



<%--<!-- SlimScroll -->--%>
<!-- jQuery 3 -->
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
<script type="text/javascript">
    $(document).ready(function () {
        var state = ${lesson.state};
        switch (state) {
            //未发布
            case 0:
                $('#cancel-button').hide();
                $('#stop-enroll-button').hide();
                break;
            //已发布，报名中
            case 1:
                $('#modify-lesson-button').hide();
                $('#release-button').hide();
                break;
            //已发布，报名截止
            case 2:
            case 3:
                $('#modify-lesson-button').hide();
                $('#release-button').hide();
                $('#stop-enroll-button').hide();
                break;
        }

        var types = "${lesson.type}".split('/');
        $('.select2').select2();
        $('.select2').val(types).trigger('change');
        //Date range picker
        $('#date-range').daterangepicker({
            locale: {
                format: 'YYYY-MM-DD',
                separator: ' ~ ',
                minDate: [moment(), moment()],
                applyLabel: '确定',
                cancelLabel: '取消',
                fromLabel: '起始时间',
                toLabel: '结束时间',
                daysOfWeek: ['日', '一', '二', '三', '四', '五', '六'],
                monthNames: ['一月', '二月', '三月', '四月', '五月', '六月',
                    '七月', '八月', '九月', '十月', '十一月', '十二月'],
                firstDay: 1
            }
        });
    });

    function modify_lesson() {
        $('#lesson-modify-modal').modal('show');
    }

    function modify_class(id) {
        $.post("/college/get_class_by_id",
            {
                id: id
            },
            function (data) {
                if (!data) {
                    alert("数据库故障");
                }
                else {
                    $('#classname').val(data.name);
                    $('#size').val(data.size);
                    $('#teacher').val(data.teacher);
                    $('#amount').val(data.num);
                    $('#price').val(data.price);
                    $('#class-id').val(id);
                    $('#class-modify-modal').modal('show');
                }
            });
    }

    function add_class() {
        $('#classname').val("");
        $('#size').val("");
        $('#teacher').val("");
        $('#amount').val("");
        $('#price').val("");
        $('#class-id').val(0);
        $('#class-modify-modal').modal('show');
    }

    function delete_class(id) {
        if (confirm("你确定要删除该班级吗？")) {
            $.post("/college/delete_class",
                {
                    id: id
                },
                function (data, status) {
                    if (data == true) {
                        alert("删除成功");
                        location.reload();
                    }
                    else {
                        alert("删除失败");
                    }
                });
        }
    }

    function cancel_lesson() {
        if (confirm("你确定要撤回已经发布的课程计划吗？如果撤回，所有已经预订的订单将自动取消。")) {
            $.post("/college/change_lesson_state",
                {
                    lid:${lesson.id},
                    state: 0
                },
                function (data, status) {
                    if (data == true) {
                        alert("撤回计划成功");
                        location.reload();
                    }
                    else {
                        alert("撤回计划失败");
                    }
                });
        }
    }

    function stop_enroll() {
        if (confirm("你确定要开始该课程计划吗？如果开课，将无法继续报名。")) {
            $.post("/college/change_lesson_state",
                {
                    lid:${lesson.id},
                    state: 2
                },
                function (data, status) {
                    if (data == true) {
                        alert("报名截止，开课成功");
                        location.reload();
                    }
                    else {
                        alert("截止报名失败");
                    }
                });
        }
    }

    function release_lesson() {
        if (confirm("你确定要发布该课程计划吗？如果发布，则无法继续修改。")) {
            $.post("/college/change_lesson_state",
                {
                    lid:${lesson.id},
                    state: 1
                },
                function (data, status) {
                    if (data == true) {
                        alert("发布计划成功");
                        location.reload();
                    }
                    else {
                        alert("发布计划失败");
                    }
                });
        }
    }
</script>
</body>
</html>
