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
	var priority = $("#unit").val();
	var maintenanceid = $("#maintenanceid").val();
	if(entnyname == ''){
    	alert('请输入项目名称');
        return false;
    }
	if(entnyname == ''){
    	alert('请输入单位');
        return false;
    }
	$.ajax({
		url: "maintenanceSave.json",
		type:"POST",
		dataType:"json",
		data: {
			entnyname : entnyname,
			priority : priority,
			maintenanceid : maintenanceid
        },
		success:function(data){
			 alert("操作成功");
		},
		error:function(){
			console.log("失败");
		}
	});
}