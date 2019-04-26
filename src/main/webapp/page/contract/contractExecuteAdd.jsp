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
<script type="text/javascript" src="<%=contextPath%>/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-table.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/moment-with-locales.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/base.js?ts=<%=request.getAttribute("ts") %>"></script>
<script type="text/javascript" src="<%=contextPath%>/js/contractExecuteAdd.js?ts=<%=request.getAttribute("ts") %>"></script>

</head>
<body class="bgdiv" style="height:100%;background-image:url('/echart/image/loginbk1.jpg');" >
	<div id="head" >
		<%@include file="../menu.jsp" %>
	</div>
	<div id="content" class="content" >
		<div class="panel-body" style="padding-bottom:0px;">
        <div class="panel panel-default">
            <div class="panel-heading">
            	合同管理 / 合同执行 / 合同执行添加
            	<div id="toolbar" class="btn-group btn-group-right" >
           			<button onclick="save()" class="btn btn-primary" >提交</button>
        			<button onclick="window.location.href='<%=fule %>contract/contractExecuteList.web';" class="btn" >返回</button>
           		</div>
            </div>
            
            <div class="container">
					<h3></h3>
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="suboffice" class="col-sm-3 control-label">所属分局</label>
							<div class="col-sm-6">
								<select class="form-control" id="suboffice" name="suboffice" onchange="loadContractData(this.value)">
							<option></option>
						</select>
							</div>
						</div>
						<div class="form-group">
							<label for="contract" class="col-sm-3 control-label">合同名称</label>
							<div class="col-sm-6">
								<select class="form-control" id="contract" name="contract">
							<option></option>
						</select>
						
							</div>
						</div>
						<div class="form-group">
							<label for="monthamount" class="col-sm-3 control-label">当月结算额(万元)</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="monthamount" placeholder="请输入合同金额">
							</div>
						</div>
						<div class="form-group">
							<label for="signTime" class="col-sm-3 control-label">所属年月</label>
							<div class="col-sm-6">
								<div class='input-group date' id='belongTime'>
			                <input type='text' readonly="readonly" class="form-control" name="belongTimeStr" id="belongTimeStr"/>
			                <span class="input-group-addon">
			                    <span class="glyphicon glyphicon-calendar"></span>
			                </span>
			                </div>
							</div>
						</div>
						<div class="form-group">
							<label for="remark" class="col-sm-3 control-label">备注</label>
							<div class="col-sm-6">
							 <input type="text" class="form-control" id="remark" placeholder="请输入备注">
							</div>
						</div>
					</form>
				</div>
        </div>       
		</div>
	</div>
</body>

</html>