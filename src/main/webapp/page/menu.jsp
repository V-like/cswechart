<%@page import="com.lion.echart.system.entity.UserEntity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	滇中引水管理局
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
		<!-- 
	    <div class="navbar-header">
	        <a class="navbar-brand" href="#">系统菜单</a>
	    </div>
	     -->
		<div>
			<ul class="nav navbar-nav" id="menuUl">
				<li id="mainpli"><a
					href="http://127.0.0.1:8080/echart/login.json">首页</a></li>
				<li id="writeli"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> 填报管理 <b class="caret"></b>
				</a>
					<ul class="dropdown-menu">
						<li><a href="<%=fule %>subofficewrite/subofficewriteList.web">分局填报</a></li>
						<li><a href="<%=fule %>financing/financingList.web">财务填报</a></li>
					</ul></li>
				<li id="projectli"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> 合同管理 <b class="caret"></b>
				</a>
					<ul class="dropdown-menu">
						<li><a href="<%=fule %>contract/contractSignedList.web">合同签订</a></li>
						<li><a href="<%=fule %>contract/contractExecuteList.web">合同执行</a></li>
					</ul></li>
				<!-- 
	            <li id="projectli" > 
	                <a href="#" class="dropdown-toggle" data-toggle="dropdown" >
	                	项目管理 <b class="caret"></b>
	                </a>
	                <ul class="dropdown-menu">
	                    <li><a href="#">进度管理</a></li>
	                    <li><a href="<%=fule %>project/payforList.web" >支付申请</a></li>
	                </ul>
	            </li>
	            <li><a href="#">费用管理</a></li>
	            <li><a href="#">采购管理</a></li>
	            <li><a href="#">物资管理</a></li>
	            <li><a href="#">绩效管理</a></li>
	            <li><a href="#">账户管理</a></li>
	            <li>
	            	<a href="#" class="dropdown-toggle" data-toggle="dropdown">
	                	财务管理<b class="caret"></b>
	                </a>
	                <ul class="dropdown-menu">
	                    <li><a href="#">头寸管理</a></li>
	                    <li><a href="#">付费管理</a></li>
	                </ul>
	            </li>
	            <li><a href="#">流程管理</a></li>
	             -->
				<li id="reportli"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> 统计报表<b class="caret"></b>
				</a>
					<ul class="dropdown-menu">
						<li><a
							href="<%=fule%>contract/contractExecuteMonthTotalList.web">合同执行月统计</a></li>
						<li><a href="<%=fule%>financing/financingReport.web"">财务数据统计</a></li>
						<!-- 
	                    <li><a href="#">建设资金支付统计表</a></li>
	               	 	<li><a href="#">分局数据统计</a></li>
	               	 	<li><a href="#">工程建设开工进度、投资完成情况月统计</a></li>
	               	 	<li><a href="#">工程投资完成汇总月统计</a></li>
	               	 	<li><a href="#">工程建设资金支付情况月统计</a></li>
	               	 	<li><a href="#">招投标情况统计</a></li>
	                    <li><a href="#">合同签订情况统计</a></li>
	                    <li><a href="#">已签合同执行情况统计</a></li>
	             		-->
					</ul></li>
				<li id="feedbackli"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> 维护管理 <b class="caret"></b>
				</a>
					<ul class="dropdown-menu">
						<li><a href="<%=fule%>maintenance/maintenanceList.web">进度反馈对比分析</a></li>
						<li><a href="<%=fule%>maintenance/monthScheduList.web">工程月进度</a></li>
						<li><a href="<%=fule%>maintenance/daySchedueList.web">工程日进度</a></li>
					</ul>
			  </li>
			</ul>
		</div>
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