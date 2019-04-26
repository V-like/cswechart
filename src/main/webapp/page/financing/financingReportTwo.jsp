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
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-editable.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.min.js" charset="UTF-8" ></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8" ></script>
<script type="text/javascript" src="<%=contextPath%>/js/base.js?ts=<%=request.getAttribute("ts") %>"></script>
<script type="text/javascript" src="<%=contextPath%>/js/financingReportTwo.js?ts=<%=request.getAttribute("ts") %>"></script>
<script type="text/javascript" src="<%=contextPath%>/js/lodop/js/LodopFuncs.js"></script>
<style type="text/css">
	.table {table-layout:fixed;}
	#tailer span{
		text-decoration:underline;
	}
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
            	统计报表 / 工程投资完成汇总月统计
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
                	<input type="hidden" name="dcdytype" value="gctzwchzytj" />
                	<input type="hidden" name="filename" id="filename" />
                	<input type="hidden" name="yearmonth" id="yearmonth" />
                	<input type="hidden" name="year" id="year" />
                	<input type="hidden" name="month" id="month" />
                	<input type="hidden" name="yearn" id="yearn" />
                	<input type="hidden" name="monthn" id="monthn" />
                	<input type="hidden" name="tailyyi" id="tailyyi" />
                	<input type="hidden" name="tailyer" id="tailyer" />
                	<input type="hidden" name="tailysan" id="tailysan" />
                	<input type="hidden" name="tailysi" id="tailysi" />
                	<input type="hidden" name="tailestr" id="tailestr" />
                	<input type="hidden" name="reportDaten" id="reportDaten" />
                    <div class="form-group" style="margin-top:15px">
                        <label class="control-label col-sm-1" for="reportDate">汇报截至日</label>
                        <div class="col-sm-2">
                        	<div style="position:absolute;left:180px;top:7px;cursor:pointer;" class="input_clear">
                        		<button type="button" class="close" data-dismiss="modal" 
                        			onclick="$('#reportDate').val('')" aria-hidden="true">×</button>
                        	</div>
							<input type="text" id="reportDate" name="reportDate" class="datetimepicker" onchange="setFormVal(this)"
                        		readonly="true" data-date-format="yyyy-mm" data-pure-clear-button />
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
        	<div style="font-size: 18px;padding:5px 10px;" id="spantailestr" >资金来源：
				截止2月25日，2019年累计到位 ___ 万元（2018年结余转结资金），
				其中①中央补助 ___ 万元
				②省级配套 ___ 万元
				③地方水利建设基金 ___ 万元
				④银行贷款 ___ 万元。
        	</div>
        </div>
	</div>
</div>
</body>

</html>