$(document).ready(function(){
	$("#content").height(window.innerHeight+60);
	loadSubofficeData();
	var subofficeid = $("#subofficeid").val();
	var subofficename = $("#subofficename").val();
	console.info(subofficeid);
	console.info(subofficename);
	//sessionStorage.removeItem("suboffice");
	
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

//获得所有部门
function loadSubofficeData(){
	$.ajax({
		url:$("#fule").val()+"/suboffice/subofficeGetDataAll.json",
		type:"POST",
		dataType:"json",
		success:function(data){
			console.info('成功!'+data);
			var strHtml= '<option value="0">-请选择-</option>';
			$.each(data, function(key,value){
				if(value.subofficeid+"" == $("#pid").val()+""){
					strHtml+='<option selected="selected" value="'+value.subofficeid+'">'+value.subofficename+'</option>';		
				}else{
					strHtml+='<option value="'+value.subofficeid+'">'+value.subofficename+'</option>';
				}
				
			});
			$("#suboffice").html(strHtml);
		},
		error:function(){
			console.info('失败！');
		}
	});
}

function save(){
	
	var subofficename = $("#subofficename").val();
	var pid = $("#suboffice").val();
	if(subofficename == ''){
    	alert('请输入部门名称');
        return false;
    }
	$.ajax({
		url: $("#fule").val()+"suboffice/subofficeSave.json",
		type:"POST",
		dataType:"json",
		data: {
			subofficeid : $("#subofficeid").val(),
			subofficename : subofficename,
			pid : pid
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