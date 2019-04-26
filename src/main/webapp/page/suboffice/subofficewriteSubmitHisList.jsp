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
	href="<%=contextPath%>/css/bootstrap-editable.css">
<link rel="stylesheet"
	href="<%=contextPath%>/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="<%=contextPath%>/css/the-modal.css">
<link rel="stylesheet"
	href="<%=contextPath%>/css/financingListDetail.css">
<script type="text/javascript"
	src="<%=contextPath%>/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/bootstrap-table.min.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/bootstrap-editable.min.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jquery.the-modal.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/base.js?ts=<%=request.getAttribute("ts")%>"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/subofficewriteSubmitHisList.js?ts=<%=request.getAttribute("ts")%>"></script>
<style type="text/css">
.table {
	table-layout: fixed;
}
</style>
</head>
<body class="bgdiv"
	style="height: 100%; background-image: url('/echart/image/loginbk1.jpg');">
	<div id="head">
		<%@include file="../menu.jsp"%>
	</div>
	<div id="content" class="content">
		<div class="panel-body" style="padding-bottom: 0px;">
			<div id="searchdiv" class="panel panel-default">
				<div class="panel-heading" style="height: 41px;">
					<!-- 分局管理 / 月填报  / 提交历史 -->
					<a href="http://127.0.0.1:8080/echart/login.json"
						style="color: #000; text-decoration: none;"> 分局管理 </a> / <a
						href="http://127.0.0.1:8080/echart/subofficewrite/subofficewriteMonthList.web"
						style="color: #000; text-decoration: none;"> 月填报 </a> / <a
						href="#" style="color: #000; text-decoration: none;">提交历史 </a>
				</div>

				<!-- 表单 -->
				<div class="panel-body" style="display: none;">
					<form id="formSearch" class="form-horizontal">
						<input type="hidden" id="subofficeid">
					</form>
				</div>
			</div>

			<div id="contentTablediv" style="overflow-y: auto;">
				<form style="border: none; margin: 0px; padding: 0px;" id="editForm"
					target="myajaxfor"
					action="<%=fule%>subofficewrite/insertSubofficewrite.json"
					method="post">
					<table id="t_datagrid"></table>
				</form>
			</div>
			<select id="subofficedata" style="display: none;">
			</select>
			
		</div>
	</div>
</body>

</html>