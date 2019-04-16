$(document).ready(function(){
	$("#content").height(window.innerHeight+60);
});
function validatef(){
	$('#formInsert').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			amount: {
				validators: {
					notEmpty: {
						message: '项目名称不能为空'
					}
				}
			}
		}
	});
}
function save(){
	
	var entnyname = $("#entnyname").val();
	var priority = $("#priority").val();
	if(entnyname == ''){
    	alert('请输入项目名称');
        return false;
    }
	$.ajax({
		url: $("#fule").val()+"maintenance/maintenanceSave.json",
		type:"POST",
		dataType:"json",
		data: {
			entnyname : entnyname,
			priority : priority
        },
		success:function(data){
			 alert("操作成功");
			 window.location.href=$("#fule").val()+"maintenance/maintenanceList.web";
		},
		error:function(){
			console.log("失败");
		}
	});
}