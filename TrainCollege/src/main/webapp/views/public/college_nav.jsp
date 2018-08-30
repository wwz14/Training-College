<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018/1/26
  Time: 17:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Left side column. contains the sidebar -->
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel" onclick="javascript:window.location.href='/college/profile'">

            <div class="pull-left info">
                <p>${college.name}</p>
                <a href="#"><i class="fa fa-circle text-success"></i> 在线</a>
            </div>
        </div>
        <!-- search form -->

        <!-- /.search form -->
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu" data-widget="tree">
            <li class="${param.homepage}">
                <a href="/college/homepage">
                    <i class="fa fa-home"></i> <span>主 页</span>
                    <span class="pull-right-container">
            </span>
                </a>
            </li>

            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>

            <li class="treeview ${param.browse}">
                <a href="#">
                    <i class="fa fa-list-ul"></i>
                    <span>课程浏览</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li class="${param.all_lessons}"><a href="/college/all_lessons"><i class="fa fa-circle-o"></i> 所有课程</a></li>
                    <li class="${param.release_lessons}"><a href="/college/release_lessons"><i class="fa fa-circle-o"></i> 已发布课程</a></li>
                    <li class="${param.unrelease_lessons}"><a href="/college/unrelease_lessons"><i class="fa fa-circle-o"></i> 未发布课程</a></li>
                </ul>
            </li>

            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>

            <li class="treeview ${param.orders}">
                <a href="#">
                    <i class="fa fa-database"></i>
                    <span>订单浏览</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li class="${param.all_orders}"><a href="/college/all_orders"><i class="fa fa-circle-o"></i> 所有订单</a></li>
                    <li class="${param.pay_orders}"><a href="/college/pay_orders"><i class="fa fa-circle-o"></i> 已支付订单</a></li>
                    <li class="${param.retrieve_orders}"><a href="/college/retrieve_orders"><i class="fa fa-circle-o"></i> 退订订单</a></li>
                </ul>
            </li>

            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>

            <li class="treeview ${param.lesson_more}">
                <a href="#">
                    <i class="fa fa-file-text-o"></i>
                    <span>课程操作</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li class="${param.new_lesson}"><a href="/college/create_lesson"><i class="fa fa-circle-o"></i> 新增课程</a></li>
                    <li class="${param.attendance}"><a href="/college/begin_lessons"><i class="fa fa-circle-o"></i> 考勤/成绩/分班</a></li>
                </ul>
            </li>

            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>

            <li class="treeview ${param.offline}">
                <a href="#">
                    <i class="fa fa-edit"></i>
                    <span>线下登记</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li class="${param.enroll}"><a href="/college/enroll_lesson"><i class="fa fa-circle-o"></i> 报名课程</a></li>
                </ul>
            </li>

            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>


            <li class="treeview ${param.self}">
                <a href="#">
                    <i class="fa fa-info"></i>
                    <span>机构信息</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li class="${param.profile}"><a href="/college/profile"><i class="fa fa-circle-o"></i> 基础信息</a></li>
                    <li class="${param.payment}"><a href="/college/payment"><i class="fa fa-circle-o"></i> 交易记录</a></li>
                    <li class="${param.money_charts}"><a href="/college/payment_chart"><i class="fa fa-circle-o"></i> 财务图表</a></li>
                </ul>
            </li>

            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>
