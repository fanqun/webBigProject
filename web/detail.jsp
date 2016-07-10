<%@ page import="com.cyan.entity.Course" %><%--
  Created by IntelliJ IDEA.
  User: cyan
  Date: 16/7/6
  Time: 13:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <!-- Bootstrap core CSS -->
    <link href="static/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <title>课程详情</title>
</head>

<%
    String name = null;
    String msg = null;
    if (session != null) {
        name = (String) session.getAttribute("user");
        msg = (String) session.getAttribute("msg");
    }
%>

<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">学生社团管理系统</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li><a href="/index">主页</a></li>
                <li><a href="/showAllClasses">所有课程</a></li>
                <li><a href="/showMyClasses">我的课程</a></li>
                <li><a href="/adminLogin.jsp">社团登陆</a></li>
            </ul>
            <%
                if (name != null) {
            %>

            <ul class="nav navbar-nav navbar-right">
                <li><a><%=name%> 欢迎您!
                </a></li>
                <li><a id="change">修改密码</a></li>
                <li><a href="/logout">退出登陆</a></li>
            </ul>
            <%
            } else {
            %>
            <form class="navbar-form navbar-right" action="/login" method="post">
                <div class="form-group">
                    <input type="text" placeholder="学号" class="form-control" name="id">
                </div>
                <div class="form-group">
                    <input type="password" placeholder="密码" class="form-control" name="pwd">
                </div>
                <button type="submit" class="btn btn-success">登陆</button>
            </form>
            <%
                }
            %>

        </div><!--/.nav-collapse -->

    </div>
</nav>

<%
    Course c = (Course) session.getAttribute("course");
%>


<div class="container theme-showcase" role="main">

    <ol class="breadcrumb" style="margin-top: 100px">
        <li><a href="/index">首页</a></li>
        <li class="active">课程详情</li>
    </ol>
    <%
        if (msg != null) {
            if (msg.equals("选课成功!")) {
    %>
    <div class="alert alert-success" role="alert">
        <strong><%=msg%>
        </strong>
    </div>
    <%
    } else {
    %>
    <div class="alert alert-danger" role="alert">
        <strong><%=msg%>
        </strong>
    </div>

    <%
            }
            session.setAttribute("msg", null);
        }
    %>
    <div class="container">

        <div class="page-header">
            <h1><%=c.getName()%>
            </h1>
        </div>
        <div class="col-md-8">
            <div class="well">
                <%=c.getDetail()%>
            </div>


            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">课程所属社团</h3>
                </div>
                <div class="panel-body">
                    <%=c.getBelong()%>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">课程学分</h3>
                </div>
                <div class="panel-body">
                    <%=c.getCredit()%>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">课程已选人数/容量</h3>
                </div>
                <div class="panel-body">
                    <%=c.getSelected()%>&nbsp;/&nbsp;<%=c.getAmount()%>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">上课地点</h3>
                </div>
                <div class="panel-body">
                    <%=c.getPlace()%>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">课程操作</h3>
                </div>
                <div class="panel-body">
                    <%
                        if (session.getAttribute("user") == null) {
                    %>
                    请先登陆!
                    <%
                    } else {
                    %>
                    <div class="row" style="text-align: center">
                        <div class="col-sm-2">
                            <form action="/selectClz" method="post">
                                <button class="btn btn-primary" type="submit">选课</button>
                            </form>
                        </div>

                        <div class="col-sm-2">
                            <a class="btn btn-default" href="/showStudent?id=<%=c.getId()%>">查看已选名单</a>
                        </div>
                    </div>
                    <%
                        }
                    %>

                </div>
            </div>
        </div>
    </div>
</div>
<script src="static/js/jquery-3.0.0.min.js"></script>
<script src="static/js/layer.js"></script>
<script>
    $('#change').on('click', function () {
        layer.open({
            type: 1,
            area: ['300px', '280px'],
            shadeClose: false, //点击遮罩关闭
            content: '<div class="container col-md-8">' +
            '<form class="form-signin" action="/changePwd" method="post">' +
            '<h2 class="form-signin-heading">修改密码</h2>' +
            '<input type="password" name="old" class="form-control" placeholder="旧密码" required autofocus>' +
            '<input type="password" name="newpwd" class="form-control" placeholder="新密码" required>' +
            '<input type="password" name="newagain" class="form-control" placeholder="确认新密码" required>' +
            '<button class="btn btn-lg btn-primary btn-block" type="submit">确认</button>' +
            '</form>' +
            '</div>'
        });
    });
</script>
</body>
</html>