<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String base = "http://" + request.getLocalAddr() + ":" + request.getLocalPort();
	String contextPath = this.getServletContext().getContextPath();
	String fule = base + "" + contextPath + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>滇中引水工程建设管理局</title>
<link rel="stylesheet"
	href="<%=contextPath%>/css/base.css?ts=<%=request.getAttribute("ts")%>"
	type="text/css" />
<link rel="stylesheet"
	href="<%=contextPath%>/css/main.css?ts=<%=request.getAttribute("ts")%>"
	type="text/css" />
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=contextPath%>/css/bootstrap-table.min.css">
<link rel="stylesheet"
	href="<%=contextPath%>/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet"
	href="<%=contextPath%>/css/bootstrap-select.min.css">
<script type="text/javascript"
	src="<%=contextPath%>/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/bootstrap-table.min.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/moment-with-locales.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/bootstrap-select.min.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/base.js?ts=<%=request.getAttribute("ts")%>"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/userAdd.js?ts=<%=request.getAttribute("ts")%>"></script>

</head>
<body class="bgdiv"
	style="height: 100%; background-image: url('/echart/image/loginbk1.jpg');">
	<div id="head">
		<%@include file="../menu.jsp"%>
	</div>
	<div id="content" class="content">
		<div class="panel-body" style="padding-bottom: 0px;">
			<div class="panel panel-default">
				<div class="panel-heading">
				<!-- 系统管理 / 用户管理 / 用户添加 -->
				<a href="http://127.0.0.1:8080/echart/login.json"
						style="color: #000; text-decoration: none;">系统管理</a> /
						<a href="http://127.0.0.1:8080/echart/user/userList.web"
						style="color: #000; text-decoration: none;">用户管理</a> /
						<a href="#"
						style="color: #000; text-decoration: none;">用户添加</a>
				
				
				 	<input type="button" onclick="save()" class="btn btn-primary" style="float:right;border:1px" value="提交">
				</div>
				<div class="panel-body">
					<h3></h3>
					
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="userName" class="col-sm-3 control-label">用户名:</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="username"
									placeholder="请输入用户名">
							</div>
						</div>
						<div class="form-group">
							<label for="realname" class="col-sm-3 control-label">真实姓名:</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="realname"
									placeholder="请输入真实姓名">
							</div>
						</div>
						<div class="form-group">
							<label for="subofficeid" class="col-sm-3 control-label">所属分局:</label>
							<div class="col-sm-6">
								<select id="subofficeid" class="form-control"></select>
							</div>
						</div>
						<div class="form-group">
							<label for="sex" class="col-sm-3 control-label">性别</label>
							<div class="col-sm-6">
							 <select class="form-control" id="sex"
								name="sex">
								<option value="M">男</option>
								<option value="F">女</option>
							</select>
							</div>
						</div>
						<div class="form-group">
							<label for="password" class="col-sm-3 control-label">密码:</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="password" placeholder="请输入密码">
							</div>
						</div>
						<div class="form-group">
							<label for="email" class="col-sm-3 control-label">邮箱:</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="email" placeholder="请输入邮箱">
							</div>
						</div>
					</form>
					</div>
			</div>
		</div>
	</div>
</body>

</html>