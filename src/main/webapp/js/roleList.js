$(document).ready(function(){
	var oTable = new TableInit();
	oTable.Init();
	$("#contentTablediv").height(window.innerHeight-$("#head").height()-$("#searchdiv").height()-40);
});
var TableInit = function () {
	var oTableInit = new Object();
	//初始化Table
	oTableInit.Init = function () {
		$('#t_datagrid').bootstrapTable({
			url: $("#fule").val()+"role/roleGetData.json",       //请求后台的URL（*）
			method: 'post',                      //请求方式（*）
			toolbar: false,                //工具按钮用哪个容器
			striped: true,                      //是否显示行间隔色
			cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
			pagination: true,                   //是否显示分页（*）
			sortable: false,                     //是否启用排序
			sortOrder: "asc",                   //排序方式
			queryParams: oTableInit.queryParams,//传递参数（*）
			sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
			pageNumber: 1,                       //初始化加载第一页，默认第一页
			pageSize: 10,                       //每页的记录行数（*）
			pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
			search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			strictSearch: false,
			showColumns: false,                  //是否显示所有的列
			showRefresh: false,                  //是否显示刷新按钮
			minimumCountColumns: 2,             //最少允许的列数
			clickToSelect: true,                //是否启用点击选中行
			//height: 700,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
			uniqueId: "no",                     //每一行的唯一标识，一般为主键列
			showToggle: false,                    //是否显示详细视图和列表视图的切换按钮
			cardView: false,                    //是否显示详细视图
			detailView: false,                   //是否显示父子表
			height: window.innerHeight-$("#head").height()-$("#searchdiv").height()-50,
			columns: [
				[
				  {                    
                    checkbox: true
	              }
				  ,{
						field: 'rolename',
						title: '角色名称'
				  }
				 ,{
						field: 'createdateStr',
						title: '创建时间'
				  },
				  {field: '',align: 'center',title: '操作' ,width : 250,
						formatter:function (value, row, index, field) {
					        return [
					        	  '<button type="button" onclick="roleEdit('+row["id"]+')" class="RoleOfedit btn btn-primary  btn-sm" style="margin-right:15px;">修改</button>',
							      '<button type="button" onclick="menuAssign('+row["id"]+')" class="RoleOfedit btn btn-primary  btn-sm" style="margin-right:15px;">权限分配</button>'
							      ].join('');
					    }
				  }
				]
			],
			rowStyle: function (row, index) {
				var classesArr = ['oddn', 'evenn'];
				var strclass = "";
				if (index % 2 === 0) {//偶数行
					strclass = classesArr[0];
				} else {//奇数行
					strclass = classesArr[1];
				}
				return { classes: strclass };
			},//隔行变色
		});
	};
	
	//得到查询的参数
	oTableInit.queryParams = function (params) {
		var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
			rolename :$("#rolename").val(),
			currPage: params.offset/params.limit+1,  //offset为数据开始索引,转换为显示当前页
            pageSize: params.limit  //页面大小
		};
		return temp;
	};
	return oTableInit;
};
function reloadtable(){
	$.ajax({
		url: $("#fule").val()+'role/roleGetData.json',
		data: $("#formSearch").serializeObj(),
		type: "post",
		dataType:"json",
		success : function(json) {
			$("#t_datagrid").bootstrapTable('load', json);
		}
	});
}
//修改用户
function roleEdit(_id){
	window.location.href = $("#fule").val()+'role/roleEdit.web?roleid='+_id;
}
//角色分配
function menuAssign(_id){
	window.location.href = $("#fule").val()+'role/roleMenuAssign.web?roleid='+_id;
}
//角色删除
function delRole(){
	var checkRow= $("#t_datagrid").bootstrapTable('getSelections');
    if(checkRow.length<=0){
    	modalTitle("请选中一条数据",1);
	}else{
		var checkIds = "";
		$.each(checkRow,function(key,value){
			checkIds+=value.id+",";
		});
		if(checkIds.length>0){
			checkIds=checkIds.substring(0,checkIds.length-1);
		}
		showloding();
		$.ajax({
			url: $("#fule").val()+'role/roleDel.json?checkIds='+checkIds,
			type: 'post',
			dataType: "json",
			success: function (data) {
				if(data.msgType == 1){
					modalTitle("操作成功",1);
					window.location.reload();
				}else{
					modalTitle(data.message,1);
				}
			},error:function(data){
				closeloding();
				modalTitle("操作失败，请重试",1);
			}
		});
	}
}