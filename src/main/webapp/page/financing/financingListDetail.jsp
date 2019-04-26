<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String base = "http://" + request.getLocalAddr()+":"+request.getLocalPort();
String contextPath = this.getServletContext().getContextPath();
String fule = base + contextPath + "/";
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
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap-select.min.css">
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap-editable.css">
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="<%=contextPath%>/css/the-modal.css">
<link rel="stylesheet" href="<%=contextPath%>/css/financingListDetail.css">
<script type="text/javascript" src="<%=contextPath%>/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-table.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-select.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-editable.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.the-modal.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/base.js?ts=<%=request.getAttribute("ts") %>"></script>
<script type="text/javascript" src="<%=contextPath%>/js/financingListDetail.js?ts=<%=request.getAttribute("ts") %>"></script>
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
            <div class="panel-heading" style="height: 41px;">
            	财务填报 / 查看明细
            	 <form id="formSearch" class="form-horizontal" style="margin-left: 130px;margin-top: -40px;">
                	<input type="hidden" id="yeardefault" value="<%=request.getAttribute("year") %>" >
                	 <input type="hidden" id="costtypedefault" value="<%=request.getAttribute("costtype") %>" >
                    <div class="form-group" style="margin-top:15px">
<!--                         <label class="control-label col-sm-1" for="year">所属年份</label> -->
                        <div class="col-sm-1">
                        	<select id="year" onchange="reloadtable()" name="year" class="selectpicker" data-width="100px" >
                        	</select>
                        </div>
<!--                         <label class="control-label col-sm-1" for="costtype">费用类型</label> -->
                        <div class="col-sm-1" style="margin-left: 5px;">
                        	<select id="costtype" onchange="reloadtable()" name="costtype" class="selectpicker" data-width="150px" >
                        	</select>
                        </div>
                    </div>
                </form>
            	<div id="operinfo" style="float:center;margin-top: -43px;">编辑数据后，请执行保存操作，以免数据丢失造成不便！</div >
            	<div id="toolbar" class="btn-group btn-group-right"  style="margin-top: -28px;">
		            <button id="btn_add" type="button" class="btn btn-default" onclick="addRow()">
		                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
		            </button>
		            <button id="btn_add" type="button" class="btn btn-default" onclick="saveRow()"
		            	data-toggle="modal" data-target="#myModal" >
		                <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>保存
		            </button>
		            <button id="btn_delete" type="button" class="btn btn-default" onclick="delRow()">
		                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
		            </button>
		            <button id="btn_back" type="button" class="btn btn-default" 
		            	onclick="window.location.href='<%=fule %>financing/financingList.web';">
		                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>返回
		            </button>
		        </div>
            </div>
        </div>       

        <div id="bodydiv" >
			<form style="border:none;margin:0px;padding:0px;" id="editForm" target="myajaxfor"
				action="<%=fule %>financing/insertFinancing.json" method="post" >
        		<table id="t_datagrid"></table>
			</form>
        </div>
        
        <select id="subofficedata" style="display:none;" >
        </select>
        <select id="contractdata" style="display:none;" >
        </select>

	</div>
</div>

</body>

</html>