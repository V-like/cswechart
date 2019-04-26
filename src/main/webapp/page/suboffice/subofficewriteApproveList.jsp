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
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap-editable.css">
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="<%=contextPath%>/css/the-modal.css">
<link rel="stylesheet" href="<%=contextPath%>/css/financingListDetail.css">
<script type="text/javascript" src="<%=contextPath%>/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-table.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-editable.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.the-modal.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/base.js?ts=<%=request.getAttribute("ts") %>"></script>
<script type="text/javascript" src="<%=contextPath%>/js/subofficewriteApproveList.js?ts=<%=request.getAttribute("ts") %>"></script>
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
            	审批管理 / 分局填报审批
            	<div id="toolbar" class="btn-group btn-group-right" >
		            <button id="btn_add" type="button" class="btn btn-default" onclick="submitFun(3)"
		            	data-toggle="modal" data-target="#myModal" >
		                <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>通过
		            </button>
		            <button id="btn_delete" type="button" class="btn btn-default" onclick="submitFun(4)">
		                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>驳回
		            </button>
		        </div>
            </div>
            <div class="panel-body" style="display:none;" >
                <form id="formSearch" class="form-horizontal">
                    <input type="hidden" id="subofficeid">
                    <!-- 
                    <div class="form-group" style="margin-top:15px">
                        <label class="control-label col-sm-1" for="txt_search_statu">合同名称</label>
                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="txt_search_type">
                        </div>
                        <div class="col-sm-2" style="text-align:left;">
                            <button type="button" style="margin-left:50px" id="btn_query" class="btn btn-primary">查询</button>
                        </div>
                    </div>
                     -->
                </form>
            </div>
        </div>       

        <div id="contentTablediv" style="overflow-y: auto;">
        	<form style="border:none;margin:0px;padding:0px;" id="editForm" target="myajaxfor"
				action="<%=fule %>subofficewrite/insertSubofficewrite.json" method="post" >
        		<table id="t_datagrid"></table>
			</form>
        </div>
        <select id="subofficedata" style="display:none;" >
        </select>
	</div>
</div>
</body>

</html>