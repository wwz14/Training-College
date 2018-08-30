<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018/1/25
  Time: 10:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Left side column. contains the sidebar -->
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel" onclick="javascript:window.location.href='/student/profile'">
            <div class="pull-left info">
                <p>${student.username}</p>
                <a><i class="fa fa-circle text-success"></i> 在线</a>
            </div>
        </div>
        <!-- search form -->

        <!-- /.search form -->
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu" data-widget="tree">
            <li class="${param.homepage}">
                <a href="/student/homepage">
                    <i class="fa fa-home"></i> <span> 主页</span>
                    <span class="pull-right-container">
            </span>
                </a>
            </li>

<%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>

            <li class="${param.browse}">
                <a href="/student/all_lessons">
                    <i class="fa fa-send"></i> <span> 课程浏览</span>
                    <span class="pull-right-container">
            </span>
                </a>
            </li>

<%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>

            <li class="treeview ${param.my_orders}">
                <a href="#">
                    <i class="fa fa-list-ul"></i>
                    <span>我的订单</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li class="${param.all_orders}"><a href="/student/all_orders"><i class="fa fa-circle-o"></i> 所有订单</a></li>
                    <li class="${param.not_pay}"><a href="/student/not_pay_orders"><i class="fa fa-circle-o"></i> 未支付订单</a></li>
                    <li class="${param.has_pay}"><a href="/student/has_pay_orders"><i class="fa fa-circle-o"></i> 已支付订单</a></li>
                    <li class="${param.cancel_order}"><a href="/student/retrieve_orders"><i class="fa fa-circle-o"></i> 退订订单</a></li>
                </ul>
            </li>

<%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>

            <li class="treeview ${param.my_progress}">
                <a href="#">
                    <i class="fa fa-calendar"></i>
                    <span>我的课程</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li class="${param.all_progress}"><a href="/student/all_progress"><i class="fa fa-circle-o"></i> 所有课程</a></li>
                    <li class="${param.has_pay_progress}"><a href="/student/has_pay_progress"><i class="fa fa-circle-o"></i> 已付课程</a></li>
                    <li class="${param.retrieve_progress}"><a href="/student/retrieve_progress"><i class="fa fa-circle-o"></i> 已退课程</a></li>
                </ul>
            </li>

<%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>

            <li class="treeview ${param.personal}">
                <a href="#">
                    <i class="fa fa-pie-chart"></i>
                    <span>个人中心</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li class="${param.profile}"><a href="/student/profile"><i class="fa fa-circle-o"></i> 用户信息</a></li>
                    <li class="${param.payment}"><a href="/student/payment"><i class="fa fa-circle-o"></i> 交易记录</a></li>
                </ul>
            </li>

<%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>
