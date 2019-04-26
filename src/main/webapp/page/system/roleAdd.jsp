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
	src="<%=contextPath%>/js/base.js?ts=<%=request.getAttribute("ts")%>"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/roleAdd.js?ts=<%=request.getAttribute("ts")%>"></script>

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
					<!--  系统管理 / 角色管理 / 角色添加 -->
					<a href="http://127.0.0.1:8080/echart/login.json"
						style="color: #000; text-decoration: none;">系统管理</a> / <a
						href="http://127.0.0.1:8080/echart/role/roleList.web"
						style="color: #000; text-decoration: none;">角色管理</a> / <a
						href="#"
						style="color: #000; text-decoration: none;">角色添加</a>

					<button onclick="save()" class="btn btn-primary"
						style="float: right; border: 1px">提交</button>
				</div>
				<div class="container">
					<h3></h3>
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="rolename" class="col-sm-3 control-label">角色名称</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="rolename"
									placeholder="请输入角色名称">
							</div>

						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>

</html>