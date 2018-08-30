<%--
  Created by IntelliJ IDEA.
  User: jqwu
  Date: 2018/2/25
  Time: 下午9:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Train COLLEGE | Profile</title>
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
</style>
<body class="skin-green-light sidebar-mini">
<div class="wrapper">
    <jsp:include page="../public/college_header.jsp" flush="true" />

    <jsp:include page="../public/college_nav.jsp" flush="true" >
        <jsp:param name="self" value="active menu-open"/>
        <jsp:param name="profile" value="active"/>
    </jsp:include>

    <div class="content-wrapper">

        <!-- 大标题 -->
        <section class="content-header">
            <h1>
                机构信息
                <small>查看/修改信息，绑定银行卡</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/college/homepage"><i class="fa fa-home"></i> 主页</a></li>
                <li class="active">机构信息</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-md-4">

                    <!-- Profile Image -->
                    <div class="box box-primary">
                        <div class="box-body box-profile">

                            <h3 class="profile-username text-center">${college.name}</h3>

                            <ul class="list-group list-group-unbordered">
                                <li class="list-group-item">
                                    <b>机构编号</b> <a class="pull-right" id="college-id"></a>
                                </li>
                                <li class="list-group-item">
                                    <b>联系方式</b> <a class="pull-right">${college.phone}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>绑定银行卡号</b> <a class="pull-right">${college.cardNo}</a>
                                </li>
                            </ul>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
                <!--.col-->

                <div class="col-md-8">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">其他信息</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <strong><i class="fa fa-map-marker margin-r-5"></i> 地理位置</strong>

                            <p class="text-muted">${college.location}</p>

                            <hr>

                            <strong><i class="fa fa-users margin-r-5"></i> 师资力量</strong>

                            <p class="text-muted">${college.teacher}</p>

                            <hr>

                            <strong><i class="fa fa-info margin-r-5"></i> 其它介绍</strong>

                            <p class="text-muted">${college.other}</p>
                        </div>
                        <!-- /.box-body -->

                        <div class="box-footer">
                            <button class="btn btn-success" data-toggle="modal" data-target="#change-modal">
                                <i class="fa fa-edit"></i> 修改信息</button>

                            <button class="btn btn-primary pull-right" data-toggle="modal" data-target="#pwd-modal" style="margin-right: 10px">
                                <i class="fa fa-lock"></i> 修改密码</button>
                            <button class="btn btn-primary pull-right" data-toggle="modal" data-target="#card-modal" style="margin-right: 10px">
                                <i class="fa fa-credit-card"></i> 修改银行卡</button>
                        </div>
                    </div>
                    <!-- /.box -->
                </div>
            </div>
            <!--.row-->

            <div class="modal fade" id="card-modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">银行卡绑定</h4>
                        </div>
                        <div class="modal-body">
                            <div class="box-body">
                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-credit-card"></i>
                                    </div>
                                    <input id="cardNo" type="text" class="form-control pull-right" placeholder="银行卡号" required>
                                </div>

                                <br>
                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-lock"></i>
                                    </div>
                                    <input id="card-pwd" type="password" class="form-control pull-right" required>
                                    <span id="error1" class="help-block" style="color: red"></span>
                                </div>
                            </div>
                        </div>
                        <!-- /.modal-content -->

                        <div class="modal-footer">
                            <button class="btn btn-default pull-left" data-dismiss="modal">取消</button>
                            <button class="btn btn-success" onclick="bank_card_on()">确认</button>
                        </div>
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal lesson -->
            </div>

            <div class="modal fade" id="change-modal">
                <div class="modal-dialog">
                    <form method="post" action="/college/profile_save">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">修改信息</h4>
                            </div>
                            <div class="modal-body">
                                <div class="callout callout-info" style="margin-bottom: 0!important;">
                                    <h4><i class="fa fa-info"></i> 提示：</h4>
                                    一旦进行修改，必须由网站管理员审核后登陆。
                                </div>

                                <div class="form-group">
                                    <label>机构名称：</label>
                                    <input value="${college.name}" name="name" class="form-control" required>
                                    <!-- /.input group -->
                                </div>

                                <div class="form-group">
                                    <label>联系电话：</label>
                                    <input value="${college.phone}" name="phone" type="tel" class="form-control" required>
                                    <!-- /.input group -->
                                </div>
                                <!-- /.form group -->

                                <div class="form-group">
                                    <label>地理位置：</label>
                                    <input value="${college.location}" name="location" class="form-control" required>
                                    <!-- /.input group -->
                                </div>
                                <!-- /.form group -->
                                <div class="form-group">
                                    <label>师资力量：</label>
                                    <textarea required name="teacher" rows="5" class="form-control" content="${college.teacher}"></textarea>
                                </div>
                                <div class="form-group">
                                    <label>其他介绍：</label>
                                    <textarea name="other" rows="5" class="form-control" content="${college.other}"></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn pull-left" data-dismiss="modal">取消</button>
                                <button type="submit" class="btn btn-primary">保存修改</button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </form>
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->

            <div class="modal fade" id="pwd-modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">修改密码</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>旧密码：</label>
                                <input id="old-pwd" type="password" class="form-control">
                                <!-- /.input group -->
                            </div>
                            <!-- /.form group -->

                            <div class="form-group">
                                <label>新密码：</label>
                                <input id="new-pwd1" type="password" class="form-control">
                                <!-- /.input group -->
                            </div>
                            <!-- /.form group -->

                            <div class="form-group">
                                <label>重复新密码：</label>
                                <input id="new-pwd2" type="password" class="form-control">
                                <!-- /.input group -->
                                <span id="error" class="help-block" style="color: red"></span>
                            </div>
                            <!-- /.form group -->
                        </div>
                        <div class="modal-footer">
                            <button class="btn pull-left" data-dismiss="modal">取消</button>
                            <button onclick="modify_pwd()" class="btn btn-primary">保存修改</button>
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
        $('#college-id').html(( "0000000" + "${college.id}" ).substr( -7 ));
    });

    function modify_pwd() {
        if($('#new-pwd1').val()==$('#new-pwd2').val()){
            $.post("/college/pwd_save",
                {
                    old:$('#old-pwd').val(),
                    password:$('#new-pwd1').val()
                },
                function (data) {
                    if(data==true)
                        window.location.href="/college/profile";
                    else
                        $('#error').html("* 旧密码不正确");
                });
        }else{
            $('#error').html("* 新密码不一致");
        }
    }

    function bank_card_on() {
        $.post("/college/check_bank_card",
            {
                cardNo:$('#cardNo').val(),
                password:$('#card-pwd').val()
            },
            function (data) {
                if(data==true){
                    $.post("/college/bank_card_on",
                        {
                            cardNo:$('#cardNo').val()
                        },
                        function (data) {
                            window.location.href="/college/profile";
                        });
                }
                else
                    $('#error1').html("* 密码不正确");
            });
    }
</script>
</body>
</html>
