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
<link rel="stylesheet" href="<%=contextPath%>/css/the-modal.css">
<script type="text/javascript" src="<%=contextPath%>/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-table.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.the-modal.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/base.js?ts=<%=request.getAttribute("ts") %>"></script>
<script type="text/javascript" src="<%=contextPath%>/js/workingfaceList.js?ts=<%=request.getAttribute("ts") %>"></script>

</head>
<body class="bgdiv" style="height:100%;background-image:url('/echart/image/loginbk1.jpg');" >
	<div id="head" >
		<%@include file="../menu.jsp" %>
	</div>
	<div id="content" class="content" >
		<div class="panel-body" style="padding-bottom:0px;">
        <div id="searchdiv" class="panel panel-default">
            <div class="panel-heading">
            	<!-- 进度反馈 / 工作面查看 -->
            	<a href="http://127.0.0.1:8080/echart/login.json"
						style="color: #000; text-decoration: none;">进度反馈</a> / <a
						href="http://127.0.0.1:8080/echart/project/workingfaveList.web"
						style="color: #000; text-decoration: none;">工作面查看</a> 
            	
            	<div id="toolbar" class="btn-group btn-group-right" >
		        </div>
            </div>
            <div class="panel-body">
                <form id="formSearch" class="form-horizontal">
                    <div class="form-group" style="margin-top:15px">
                        <label class="control-label col-sm-1" for="txt_search_statu">所属分局</label>
                        <div class="col-sm-2">
                            <select class="form-control" id="suboffice" name="suboffice" style="width: 200px;" onchange="updatexpulldown(1)">
								<option></option>
							</select>
                        </div>
                        <label class="control-label col-sm-1" for="txt_search_statu">所属分段</label>
                        <div class="col-sm-2">
                            <select class="form-control" id="minutemark" name="minutemark" style="width: 200px;"  onchange="updatexpulldown(2)">
								<option></option>
							</select>
                        </div>
                        <label class="control-label col-sm-1" for="txt_search_statu">所属分标</label>
                        <div class="col-sm-2">
                            <select class="form-control" id="subsection" name="subsection" style="width: 200px;"  onchange="updatexpulldown(3)">
								<option></option>
							</select>
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