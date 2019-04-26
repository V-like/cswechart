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
	src="<%=contextPath%>/js/menuAdd.js?ts=<%=request.getAttribute("ts")%>"></script>

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
					<!--系统管理 / 菜单管理 / 菜单添加-->
					系统管理 / <a
						href="<%=fule %>menu/menuList.web"
						style="color: #000; text-decoration: none;">菜单管理</a> / <a
						href="<%=fule %>menu/menuAdd.web"
						style="color: #000; text-decoration: none;">菜单添加</a>

					<div id="toolbar" class="btn-group btn-group-right"  style="margin-top: -28px;">
						<button onclick="save()" class="btn btn-primary" >提交</button>
						
			            <button id="btn_back" type="button" class="btn btn-default" 
			            	onclick="window.location.href='<%=fule %>menu/menuList.web';">
			                <span class="glyphicon" aria-hidden="true"></span>返回
			            </button>
					</div>
				</div>

				<div class="container">
					<h3></h3>
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="menuname" class="col-sm-3 control-label">菜单名称</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="menuname"
									placeholder="请输入菜单名称">
							</div>
						</div>
						<div class="form-group">
							<label for="url" class="col-sm-3 control-label">URL</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="url"
									placeholder="请输入url">
							</div>
						</div>
						<div class="form-group">
							<label for="ismenu" class="col-sm-3 control-label">是否父菜单</label>
							<div class="col-sm-6">
								<select class="form-control" id="ismenu" name="ismenu"
									onchange="changeIsMenu(this.value)">
									<option value="1">是</option>
									<option value="0">否</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="pid" class="col-sm-3 control-label">上级菜单</label>
							<div class="col-sm-6">
								<select class="form-control" id="pid" name="pid">
									<option value=""></option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="priority" class="col-sm-3 control-label">排序序号</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="priority"
									name="priority" placeholder="请输入排序序号">
							</div>
						</div>

					</form>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>

</html>