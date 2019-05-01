<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String base = "http://" + request.getLocalAddr()+":"+request.getLocalPort();
String contextPath = this.getServletContext().getContextPath();
String fule = base + "" + contextPath + "/";
%>
<%@ page isELIgnored="false"%>
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
<link rel="stylesheet" href="<%=contextPath%>/css/maintenancelPrem.css">
<script type="text/javascript" src="<%=contextPath%>/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-table.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.the-modal.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.min.js" charset="UTF-8" ></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8" ></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-table-treegrid.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.treegrid.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-treeview.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/base.js?ts=<%=request.getAttribute("ts") %>"></script>
<script type="text/javascript" src="<%=contextPath%>/js/maintenancelPrem.js"></script>

</head>
<body class="bgdiv" style="height:100%;background-image:url('/echart/image/loginbk1.jpg');" >
	<div id="head" >
		<%@include file="../menu.jsp" %>
	</div>
	<div id="content" class="content" >
		<div class="panel panel-default " >
			<div class="panel-heading" id="searchdiv" >
			
				<a style="color: #000; text-decoration: none;"
					href="javascript:void(0)">进度反馈</a>
				/ 
				<a href="<%=contextPath%>project/maintenanceList.web"
					style="color: #000; text-decoration: none;">工程总进度</a> 
	          	/
	          	<a style="color: #000; text-decoration: none;"
					href="javascript:void(0)">权限分配</a>
				
	           	<div id="toolbar" class="btn-group btn-group-right" >
		            <button id="btn_add" type="button" class="btn btn-default" onclick="saveRow()"
		            	data-toggle="modal" data-target="#myModal" >
		                <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>保存
		            </button>
		        </div>
	        </div>
        
	        <div id="bodydiv" >
	        
				<div id="left" ></div>
				<div class="contentDiv" >
					<div class="panel panel-info">
					    <div class="panel-heading">
					        <h3 class="panel-title">操作权限</h3>
					    </div>
					    <div class="panel-body">
					    	<div id="caozqx" ></div>
					    </div>
					</div>
				</div>
				<div class="contentDiv" >
					<div class="panel panel-info">
					    <div class="panel-heading">
					        <h3 class="panel-title">查看权限</h3>
					    </div>
					    <div class="panel-body">
					    	<div id="chakqx" ></div>
					    </div>
					</div>
				</div>
			
			</div>
        </div>
	</div>
</body>
</html>