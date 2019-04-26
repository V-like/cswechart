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
<link rel="stylesheet" href="<%=contextPath%>/css/the-modal.css">
<link rel="stylesheet" href="<%=contextPath%>/css/base.css?ts=<%=request.getAttribute("ts") %>" type="text/css" />
<link rel="stylesheet" href="<%=contextPath%>/css/main.css?ts=<%=request.getAttribute("ts") %>" type="text/css" />
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap-table.min.css">
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap-select.min.css">
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap-editable.css">
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap-datetimepicker.min.css">
<script type="text/javascript" src="<%=contextPath%>/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-table.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-editable.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.the-modal.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/base.js?ts=<%=request.getAttribute("ts") %>"></script>
<script type="text/javascript" src="<%=contextPath%>/js/financingRepair.js?ts=<%=request.getAttribute("ts") %>"></script>

</head>
<body class="bgdiv" style="height:100%;background-image:url('/echart/image/loginbk1.jpg');" >

	<div id="head" >
		<%@include file="../menu.jsp" %>
	</div>
	<div id="content" class="content" >
		<div class="panel-body" style="padding-bottom:0px;">
		
		
        <div id="searchdiv" class="panel panel-default">
            <div class="panel-heading" style="height: 41px;">
            	财务填报 / 工程投资完成汇总数据补录
            	 <form id="formSearch" class="form-horizontal" style="margin-left: 130px;margin-top: -40px;">
                	<input type="hidden" id="yeardefault" value="<%=request.getAttribute("year") %>" >
                	<input type="hidden" id="costtypedefault" value="<%=request.getAttribute("costtype") %>" >
                    <div class='input-group date' id='belongTime' style="width: 120px;margin-left:150px;margin-top: 13px;">
		                <input type='text' class="form-control" name="belongTimeStr" id="belongTimeStr" />
		                <span class="input-group-addon">
		                    <span class="glyphicon glyphicon-calendar"></span>
		                </span>
	           		</div>
                </form>
            	<div id="operinfo" style="float:center;margin-top: -27px;">编辑数据后，请执行保存操作，以免数据丢失造成不便！</div >
            	<div id="toolbar" class="btn-group btn-group-right"  style="margin-top: -28px;">
		            <button id="btn_add" type="button" class="btn btn-default" onclick="saveRow()"
		            	data-toggle="modal" data-target="#myModal" >
		                <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>保存
		            </button>
		        </div>
            </div>
        </div>       

        <div id="bodydiv" >
			<form style="border:none;margin:0px;padding:0px;" id="editForm" 
				action="<%=fule %>financing/insertRepair.json" method="post" >
        		<table id="t_datagrid"></table>
			</form>
			<input type="hidden" name="sourceMoneyId" id="sourceMoneyId">
			资金来源：
				截止2月25日，2019年累计到位 <input type="text" style="width: 100px;" id="totalmoney" name="totalmoney" value="0"/> 万元（2018年结余转结资金），
				其中①中央补助 <input type="text" style="width: 100px;" id="centralmoney" name="centralmoney" value="0"/>      万元
				②省级配套 <input type="text" style="width: 100px;" id="provincemoney" name="provincemoney" value="0"/>  万元
				③地方水利建设基金 <input type="text" style="width: 100px;" id="localmoney" name="localmoney" value="0"/>  万元
				④银行贷款 <input type="text" style="width: 100px;" id="bankmoney" name="bankmoney" value="0"/>  万元。
        </div>
	</div>
</div>

</body>

</html>