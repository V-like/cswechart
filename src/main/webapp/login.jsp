<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String base = "http://" + request.getLocalAddr()+":"+request.getLocalPort();
String contextPath = this.getServletContext().getContextPath();
String fule = base + "" + contextPath + "/";
%>
<!DOCTYPE html>
<html style="height:100%;">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<%=fule%>/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=fule%>/css/base.css?ts=<%=request.getAttribute("ts") %>" />
<link rel="stylesheet" type="text/css" href="<%=fule%>/css/login.css?ts=<%=request.getAttribute("ts") %>" />
<script type="text/javascript" src="<%=fule%>/js/jquery-2.1.3.min.js"></script>

<style type="text/css">
	.control-label{
		font-size: 22px;
	}
</style>
</head>
<body style="height:100%;">
	<div class="bgdiv" style="background-image:url('/echart/image/changshuiwei2.jpg');" >
		<div class="title" >滇中引水工程建设管理局</div>
		<div class="row">
			<form class="form-horizontal"  method="post" action="<%=fule%>login.json"  id="form">
				<div class="form-group">
					<label class="col-lg-3 control-label" >用户名</label>
					<div class="col-lg-9">
						<input type="text" class="form-control" name="username" id="username" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-lg-3 control-label" >密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
					<div class="col-lg-9">
						<input type="text" class="form-control" name="password" id="password" />
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-lg-3 control-label" >验证码</label>
					<div class="col-lg-4">
						<input type="text" class="form-control" name="code" id="code" />
					</div>
					<div class="col-lg-5" style="padding-top:6px;" >
						<span id="ckcode" ></span>
						<a style="color:red;" href="javascript:void(0);" onclick="changeImg()" >换一张</a>
					</div>
				</div>
				
				<div class="col-lg-9 col-lg-offset-4">
					<input type="button"  class="btn btn-primary" style="width:35%;" onclick="dologin()" value="登录" />
				</div>
				<div style="color:red">
					<% 
						String msg=(String)request.getAttribute("msg");
						if(msg==null){
							msg="";
						}
					%>
					<%=msg %>
				</div>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	//按Enter键可以登陆
	$("input").keyup(function(event){
		if(event.keyCode == 13){
			dologin();
		}
	});	
	
});

function changeImg(){
	$.ajax({
        url:"drawcheckcode.json",
        type:"post",
        dataType:"text",
        success:function(data){
			$("#ckcode").html(data);
        },error:function(jqXHR){
        	console.log("Error: "+jqXHR.status);
        }
	});
}
function dologin(){
	if(check()){
		$("#form ").submit()
	}else{
		return;
	}
}

function check(){
	//把验证码转成小写
	var code=$("#code").val();
	//把输入的验证码转成小写
	var ckcode=$("#ckcode").html();
	
	if($("#username").val() == ''){
		alert('请输入用户名');
		return false;
	}
	if($("#password").val() == ''){
		alert('请输入密码');
		return false;
	}
	//判断如果验证码为空就提示输入验证码
	if($("#code").val() == ''){
		alert('请输入验证码');
		return false;
	}
	//判断输入的验证码和验证码会否一致
	if(code.toLowerCase()!=ckcode.toLowerCase()){
		alert('验证码不正确');
		changeImg();
		return false;
	}
	
	return true;
}
$(document).ready(function(){
	changeImg();
	$("#username").focus();
});
</script>
</html>