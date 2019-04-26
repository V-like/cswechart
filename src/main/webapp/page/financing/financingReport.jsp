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
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap-table.min.css">
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="<%=contextPath%>/css/the-modal.css">
<link rel="stylesheet" href="<%=contextPath%>/css/base.css?ts=<%=request.getAttribute("ts") %>" type="text/css" />
<link rel="stylesheet" href="<%=contextPath%>/css/main.css?ts=<%=request.getAttribute("ts") %>" type="text/css" />
<script type="text/javascript" src="<%=contextPath%>/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-table.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.the-modal.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.min.js" charset="UTF-8" ></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8" ></script>
<script type="text/javascript" src="<%=contextPath%>/js/base.js?ts=<%=request.getAttribute("ts") %>"></script>
<script type="text/javascript" src="<%=contextPath%>/js/financingReport.js?ts=<%=request.getAttribute("ts") %>"></script>
<script type="text/javascript" src="<%=contextPath%>/js/lodop/js/LodopFuncs.js"></script>
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
            	统计报表 / 财务数据统计
            	<div id="toolbar" class="btn-group btn-group-right" >
		            <button id="printbtn" type="button" class="btn btn-default" onclick="dolengprint()" >
		                <span class="glyphicon" aria-hidden="true" >打印</span>
		            </button>
		            <button id="excelbtn" type="button" class="btn btn-default" onclick="doexcel()" >
		                <span class="glyphicon" aria-hidden="true"  >导出</span>
		            </button>
		        </div>
            </div>
            <div class="panel-body">
                <form id="formSearch" class="form-horizontal" autosubmit="return false;" method="post" >
                	<input type="hidden" name="dcdytype" value="cwsjtj" />
                	<input type="hidden" name="filename" id="filename" />
                	<input type="hidden" name="year1" id="year1" />
                	<input type="hidden" name="year2" id="year2" />
                	<input type="hidden" name="year3" id="year3" />
                	<input type="hidden" name="month" id="month" />
                	<input type="hidden" name="year1n" id="year1n" />
                	<input type="hidden" name="year2n" id="year2n" />
                	<input type="hidden" name="year3n" id="year3n" />
                	<input type="hidden" name="monthn" id="monthn" />
                	<input type="hidden" name="reportDaten" id="reportDaten" />
                    <div class="form-group" style="margin-top:15px">
                        <label class="control-label col-sm-1" for="reportDate">填报截至日期</label>
                        <div class="col-sm-2">
                        	<div style="position:absolute;left:180px;top:7px;cursor:pointer;" class="input_clear">
                        		<button type="button" class="close" data-dismiss="modal" 
                        			onclick="$('#reportDate').val('')" aria-hidden="true">×</button>
                        	</div>
							<input type="text" id="reportDate" name="reportDate" class="datetimepicker" onchange="setFormVal(this)"
                        		readonly="true" data-date-format="yyyy-mm-dd" data-pure-clear-button />
                        </div>
                        <div class="col-sm-2" style="text-align:left;">
                            <button type="button" style="margin-left:50px" id="btn_query" class="btn btn-primary">查询</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>       

        <div id="bodydiv" >
        	<table id="t_datagrid"></table>
        </div>
	</div>
</div>
</body>

</html>