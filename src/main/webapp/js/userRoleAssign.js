$(document).ready(function(){
	$("#content").height(window.innerHeight+60);
	loadRoleData();
});
function loadRoleData(){
	var roleList = $("#roleList").val();
	var roleListArr = roleList.split(',');
	$.ajax({
		url:$("#fule").val()+"role/roleGetData.json",
		type:"POST",
		dataType:"json",
		success:function(data){
			console.info(data);
			var strHtml= "";
			$.each(data.rows, function(key,value){
				console.info(key);
				console.info(value);
				strHtml+='<label class="checkbox-inline">';
				if(IsInArray(roleListArr,value.id)){
					strHtml+='<input type="checkbox" id="'+value.id+'" value="'+value.id+'" name="roleid" checked="checked">'+value.rolename;
				}else{
					strHtml+='<input type="checkbox" id="'+value.id+'" value="'+value.id+'" name="roleid">'+value.rolename;
				}
				strHtml+='</label>';
			});
			$("#roleListDiv").html(strHtml);
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
	var userid = $("#edituserid").val();
	var roleidArr =[]; 
    $('input[name="roleid"]:checked').each(function(){ 
    	roleidArr.push($(this).val()); 
    }); 
    if(roleidArr.length==0){
    	alert("你没有选中任何角色！");
    	return;
    }
    var roleidArrStr = roleidArr.join(",");
	$.ajax({
		url: $("#fule").val()+"user/userRoleSave.json",
		type:"POST",
		dataType:"json",
		data: {
			userid : userid,
			roleidArrStr : roleidArrStr
        },
		success:function(data){
			 alert("操作成功");
			 window.location.href=$("#fule").val()+"user/userList.web";
		},
		error:function(){
			console.log("失败");
		}
	});
}