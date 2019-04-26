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
<link rel="stylesheet" href="<%=contextPath%>/css/the-modal.css">
<script type="text/javascript" src="<%=contextPath%>/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-table.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-table-zh-CN.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.the-modal.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/base.js?ts=<%=request.getAttribute("ts") %>"></script>
<script type="text/javascript" src="<%=contextPath%>/js/userList.js?ts=<%=request.getAttribute("ts") %>"></script>
<style type="text/css">
	.table {table-layout:fixed;}
</style>
</head>
<body class="bgdiv" style="height:100%;background-image:url('/echart/image/loginbk1.jpg');" >
	<div id="head" >
		<%@include file="../menu.jsp" %>
	</div>
	<div id="content" class="content" >
		<div class="panel-body" style="padding-bottom:0px;">
        <div id="searchdiv" class="panel panel-default">
            <div class="panel-heading">
            	 <!--系统管理 / 用户管理 -->
            	 <a href="http://127.0.0.1:8080/echart/login.json"
						style="color: #000; text-decoration: none;">系统管理</a> /
						<a href="http://127.0.0.1:8080/echart/user/userList.web"
						style="color: #000; text-decoration: none;">用户管理</a> 
            	 
            	<div id="toolbar" class="btn-group btn-group-right" >
		            <button id="btn_add" type="button" class="btn btn-default" onclick="window.location.href='<%=fule %>user/userAdd.web'">
		                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
		            </button>
		            <button id="btn_delete" type="button" class="btn btn-default" onclick="delUser()">
		                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
		            </button>
		        </div>
            </div>
            <div class="panel-body">
                <form id="formSearch" class="form-horizontal">
                    <div class="form-group" style="margin-top:15px">
                        <label class="control-label col-sm-1" for="txt_search_departmentname">用户名</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="username" name="username">
                        </div>
                        <div class="col-sm-2" style="text-align:left;">
                            <button type="button" style="margin-left:50px" id="btn_query" onclick="reloadtable()" class="btn btn-primary">查询</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>       

        <div id="contentTablediv" style="overflow-y: auto;">
        	<table id="t_datagrid"></table>
        </div>
	</div>
</div>
</body>

</html>