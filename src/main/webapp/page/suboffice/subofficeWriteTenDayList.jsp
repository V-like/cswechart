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
<title>滇中引水管理局</title>
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
<script type="text/javascript" src="<%=contextPath%>/js/subofficeWriteTenDayList.js?ts=<%=request.getAttribute("ts") %>"></script>
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
            	分局管理 / 旬填报
            	<div class='input-group date' id='belongTime' style="width: 120px;margin-left:150px;margin-top: -25px;">
	                <input type='text' class="form-control" name="belongTimeStr" id="belongTimeStr" readonly="readonly"/>
	                <span class="input-group-addon">
	                    <span class="glyphicon glyphicon-calendar"></span>
	                </span>
	            </div>
	            <div class="form-group" style="margin-top:-34px;margin-left: 260px;">
                    <div class="col-sm-2">
                    	<select class="form-control" data-width="80px" id="tendaytypeid" name="tendaytypeid" onchange="reloadtable()">
                    		<option value="1" selected = "selected">上旬</option><option value="2">中旬</option><option value="3">下旬</option>
                    	</select>
                    </div>
                </div>
	            <div id="operinfo" style="float:center;margin-top: -42px;">编辑数据后，请执行保存操作，以免数据丢失造成不便！</div >
            	<div id="toolbar" class="btn-group btn-group-right" style="margin-top: -28px;">
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