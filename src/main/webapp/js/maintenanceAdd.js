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
						message: '合同金额不能为空'
					},
					stringLength: {
                        min: 1,
                        max: 2,
                        message: '月份长度为1到2位'
                    },
					regexp: {
						regexp: /^[0-9]+$/,
						message: '月份必须为位数字'
					}
				}
			}
		}
	});
}
function save(){
	
	var subofficename = $("#subofficename").val();
	var isonlysubo = $("#isonlysubo").val();
	if(subofficename == ''){
    	alert('请输入部门名称');
        return false;
    }
	$.ajax({
		url: $("#fule").val()+"suboffice/subofficeSave.json",
		type:"POST",
		dataType:"json",
		data: {
			subofficename : subofficename,
			isonlysubo : isonlysubo
        },
		success:function(data){
			 alert("操作成功");
			 window.location.href=$("#fule").val()+"suboffice/subofficeList.web";
		},
		error:function(){
			console.log("失败");
		}
	});
}