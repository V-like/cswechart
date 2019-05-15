$(document).ready(function(){
	$("#content").height(window.innerHeight+60);
	subofficeDataInit();
});

function subofficeDataInit(){
	$.ajax({
		url: $("#fule").val()+'/getCashListData.json',
		type: 'post',
		data: {"cashtype": "subofficeList"},
		dataType: "json",
		success: function (data) {
			for(var i=0;i<data.length;i++){
				$("#subofficeid").append('<option value="'
						+data[i].subofficeid+'">'+data[i].subofficename+'</option>');
			}
			$("#subofficeid").selectpicker("refresh");
		}
	});
	
}
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
	var username = $("#username").val();
	var realname = $("#realname").val();
	var sex = $("#sex").val();
	var password = $("#password").val();
	var email = $("#email").val();
	var subofficeid = $("#subofficeid").val();
	if(username == ''){
    	alert('请输入用户名');
        return false;
    }
	if(realname == ''){
    	alert('请输入真实姓名');
        return false;
    }
	if(password == ''){
    	alert('请输入密码');
        return false;
    }
	$.ajax({
		url: $("#fule").val()+"user/userSave.json",
		type:"POST",
		dataType:"json",
		data: {
			username : username,
			realname : realname,
			sex : sex,
			password : password,
        	email : email,
        	subofficeid : subofficeid
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