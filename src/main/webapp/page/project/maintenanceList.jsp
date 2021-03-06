<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String base = "http://" + request.getLocalAddr()+":"+request.getLocalPort();
String contextPath = this.getServletContext().getContextPath();
String fule = base + "" + contextPath + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>滇中引水工程建设管理局</title>
<link rel="stylesheet" href="<%=contextPath%>/css/base.css?ts=<%=request.getAttribute("ts") %>" type="text/css" />
<link rel="stylesheet" href="<%=contextPath%>/css/main.css?ts=<%=request.getAttribute("ts") %>" type="text/css" />
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap-table.min.css">
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="<%=contextPath%>/css/jquery.treegrid.min.css">
<link rel="stylesheet" href="<%=contextPath%>/css/the-modal.css">
<script type="text/javascript" src="<%=contextPath%>/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-table.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.the-modal.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.min.js" charset="UTF-8" ></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8" ></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-table-treegrid.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.treegrid.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/base.js?ts=<%=request.getAttribute("ts") %>"></script>
<script type="text/javascript" src="<%=contextPath%>/js/maintenanceList.js?ts=<%=request.getAttribute("ts") %>"></script>

</head>
<body class="bgdiv" style="height:100%;background-image:url('/echart/image/loginbk1.jpg');" >
	<div id="head" >
		<%@include file="../menu.jsp" %>
	</div>
	<div id="content" class="content" >
		<div class="panel-body" style="padding-bottom:0px;">
        <div id="searchdiv" class="panel panel-default">
            <div class="panel-heading">
            	<!-- 进度管理 / 进度反馈及对比分析 -->
            	<a href="http://127.0.0.1:8080/echart/login.json"
						style="color: #000; text-decoration: none;">进度反馈</a> / <a
						href="http://127.0.0.1:8080/echart/project/maintenanceList.web"
						style="color: #000; text-decoration: none;">工程总进度</a>
            
            	<div id="toolbar" class="btn-group btn-group-right" >
		            <button id="prembtn" type="button" class="btn btn-default" >
		                <span class="glyphicon" aria-hidden="true" >权限分配</span>
		            </button>
		        </div>         	
            </div>
        </div>       

        <div id="contentTablediv" style="overflow-y: auto;">
        	<table id="t_datagrid"></table>
        </div>
	</div>
</div>
</body>

</html>