<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018/1/27
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Left side column. contains the sidebar -->
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel">

            <div class="pull-left info">
                <p>${manager.name}</p>
                <a href="#"><i class="fa fa-circle text-success"></i> 在线</a>
            </div>
        </div>
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu" data-widget="tree">
            <li class="${param.homepage}">
                <a href="/college_manager/homepage">
                    <i class="fa fa-home"></i> <span>主 页</span>
                    <span class="pull-right-container">
            </span>
                </a>
            </li>

            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>

            <li class="treeview ${param.colleges}">
                <a href="#">
                    <i class="fa fa-calendar"></i>
                    <span>机构浏览</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li class="${param.all_college}"><a href="/college_manager/all_colleges"><i class="fa fa-circle-o"></i> 所有机构</a></li>
                    <li class="${param.unchecked_college}"><a href="/college_manager/unchecked_colleges"><i class="fa fa-circle-o"></i> 待审核机构</a></li>
                </ul>
            </li>

            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>

            <li class="treeview ${param.students}">
                <a href="#">
                    <i class="fa fa-user"></i>
                    <span>学员浏览</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li class="${param.all_students}"><a href="/college_manager/all_students"><i class="fa fa-circle-o"></i> 所有学员</a></li>
                    <li class="${param.student_stats}"><a href="/college_manager/student_stats"><i class="fa fa-circle-o"></i> 学员统计</a></li>
                </ul>
            </li>

            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>

            <li class="treeview ${param.money}">
                <a href="#">
                    <i class="fa fa-area-chart"></i>
                    <span>交易结算</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li class="${param.website_payment}"><a href="/college_manager/website_payment"><i class="fa fa-circle-o"></i> 网站收支</a></li>
                    <li class="${param.college_payment}"><a href="/college_manager/college_payment"><i class="fa fa-circle-o"></i> 机构结算</a></li>
                </ul>
            </li>

            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>
