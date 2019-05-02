$(document).ready(function(){
	$("#content").height(window.innerHeight+60);
	loadMenuData();
});
function loadMenuData(){
	var menuList = $("#menuList").val();
	var menuListArr = menuList.split(',');
	
	var userList = $("#userList").val();
	var userListArr = userList.split(',');
	
	$.ajax({
		url:$("#fule").val()+"menu/menuGetData.json",
		type:"POST",
		dataType:"json",
		success:function(data){
			console.info(data);
			var strHtml= "";
			$.each(data.rows, function(key,value){
				strHtml+='<label class="checkbox-inline">';
				if(IsInArray(menuListArr,value.id)){
					strHtml+='<input type="checkbox" id="'+value.id+'" value="'+value.id+'" name="menuid" checked="checked">'+value.menuname;
				}else{
					strHtml+='<input type="checkbox" id="'+value.id+'" value="'+value.id+'" name="menuid">'+value.menuname;
				}
				strHtml+='</label>';
			});
			$("#roleListDiv").html(strHtml);
			
			//展示所有的user
			$.ajax({
				url:$("#fule").val()+"/user/userGetData.json",
				type:"POST",
				dataType:"json",
				success:function(data){
					console.info(data);
					var strHtml= "";
					$.each(data.rows, function(key,value){
						strHtml+='<label class="checkbox-inline">';
						if(IsInArray(userListArr,value.id)){
							strHtml+='<input type="checkbox" id="'+value.id+'" value="'+value.id+'" name="menuid" checked="checked">'+value.username;
						}else{
							strHtml+='<input type="checkbox" id="'+value.id+'" value="'+value.id+'" name="menuid">'+value.username;
						}
						strHtml+='</label>';
					});
					$("#userListDiv").html(strHtml);
				},
				error:function(){
					
				}
			});
		},
		error:function(){
			
		}
	});
	
}
//判断字符串是否存在数组中
function IsInArray(arr,val){ 
　　var testStr=','+arr.join(",")+","; 
　　return testStr.indexOf(","+val+",")!=-1; 
}
function save(){
	var roleid = $("#editroleid").val();
	var menuidArr =[]; 
    $('input[name="menuid"]:checked').each(function(){ 
    	menuidArr.push($(this).val()); 
    }); 
    if(menuidArr.length==0){
    	alert("你没有选中任何菜单！");
    	return;
    }
    var menuidArrStr = menuidArr.join(",");
	$.ajax({
		url: $("#fule").val()+"role/roleMenuSave.json",
		type:"POST",
		dataType:"json",
		data: {
			roleid : roleid,
			menuidArrStr : menuidArrStr
        },
		success:function(data){
			 alert("操作成功");
			 window.location.href=$("#fule").val()+"role/roleList.web";
		},
		error:function(){
			console.log("失败");
		}
	});
}