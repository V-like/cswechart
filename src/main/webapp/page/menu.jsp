<%@page import="com.lion.echart.system.entity.UserEntity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<input type="hidden" name="userid" id="userid"
	value="${USER_SESSION.id}">
<script>
	//通过用户加载动态菜单加载菜单
	var userid = $("#userid").val();
	$.ajax({
		url:"<%=fule %>menu/menuGetDataByUserId.json",
		type:"POST",
		dataType:"json",
		data:{"userid":userid},
		success:function(data){
			var strHtml= '<li id="mainpli" ><a href="#">首页</a></li>';
			var sondate = data;
			$.each(data, function(key,value){
				if(value.ismenu==1){
					//是父级菜单
					strHtml+='<li>';
					if(value.url!=undefined&&value.url!=''){
						strHtml+='<a href="<%=fule %>'+value.url+'">'+value.menuname+'</a>';
					}else{
						strHtml+='<a href="#" class="dropdown-toggle" data-toggle="dropdown">';
						strHtml+=value.menuname+'<b class="caret"></b>';
						strHtml+='</a>';
						strHtml+='<ul class="dropdown-menu">';
						var pid=value.id;
						//遍历子菜单
						$.each(sondate, function(sonkey,sonvalue){
							if(sonvalue.pid==pid){
								strHtml+='<li><a href="<%=fule %>'+sonvalue.url+'">'+sonvalue.menuname+'</a></li>';
							}
							
						});
						strHtml+='</ul>';
					}
					strHtml+='</li>';
				}
			});
			$("#menuUl").html(strHtml);
		},
		error:function(){			
		}
	});
</script>
<iframe style="display: none" id="myajaxfor" name="myajaxfor"></iframe>
<input type="hidden" id="who" value="<%=request.getAttribute("who") %>" />
<input type="hidden" id="fule" value="<%=fule %>" />
<div class="title">
	滇中引水工程建设管理局
	<div class="userinfo">
		您好：
		<% 
			//获取到服务器中的用户对象 
			UserEntity userSession=(UserEntity)request.getSession().getAttribute("USER_SESSION");
			//初始值为空
			String subofficename="";
			String username="";
			//判断是否有值 如果有则赋值
		 	if(userSession.getSubofficename()!=null){
		 		subofficename=userSession.getSubofficename();
		 	}
		 	if(userSession.getUsername()!=null){
		 		username=userSession.getUsername();
		 	}
		%>
		<%=subofficename%>
		<%=username %>
		<a href="<%=fule%>logout">退出登录</a>
	</div>
</div>
<nav class="navbar navbar-default navbar-static-top" role="navigation">
	<div class="container-fluid">
		<ul class="nav navbar-nav" id="menuUl"></ul>
		
	</div>
</nav>

<div class="modal-dialog" id="show-modal" tabindex="-1"
	style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button onclick="closeloding()" type="button" class="close"
					data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">提示消息</h4>
			</div>
			<div class="modal-body" id="infobody"
				style="text-align: center; font-size: large;">提示消息</div>
			<div class="modal-footer">
				<button id="leftBtn" type="button" class="btn btn-default"
					onclick="closeloding()" data-dismiss="modal">关闭</button>
				<button id="rightBtn2" type="button"
					class="rightBtn btn btn-primary" onclick="saveFun()">确定</button>
				<button id="rightBtn3" sytle="display:none;" type="button"
					class="rightBtn btn btn-primary" onclick="deleteFun()">确定</button>
				<button id="rightBtn4" sytle="display:none;" type="button"
					class="rightBtn btn btn-primary" onclick="submitFun()">确定</button>
			</div>
		</div>
	</div>
</div>