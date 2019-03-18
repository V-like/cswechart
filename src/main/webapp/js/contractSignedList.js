$(document).ready(function(){
	var oTable = new TableInit();
	oTable.Init();
	$("#contentTablediv").height(window.innerHeight-$("#head").height()-$("#searchdiv").height()-40);
	loadSubofficeData();
});
function loadSubofficeData(){
	$.ajax({
		url:$("#fule").val()+"/suboffice/subofficeGetData.json",
		type:"POST",
		dataType:"json",
		success:function(data){
			var strHtml= '<option value="0">-请选择-</option>';
			$.each(data, function(key,value){
				strHtml+='<option value="'+value.subofficeid+'">'+value.subofficename+'</option>';
			});
			$("#suboffice").html(strHtml);
		},
		error:function(){
			
		}
	});
}
var TableInit = function () {
	var oTableInit = new Object();
	//初始化Table
	oTableInit.Init = function () {
		$('#t_datagrid').bootstrapTable({
			url: $("#fule").val()+'contract/contractSignedListGetData.json',         //请求后台的URL（*）
			method: 'post',                      //请求方式（*）
			contentType :'application/x-www-form-urlencoded; charset=UTF-8',
			toolbar: false,                //工具按钮用哪个容器
			striped: true,                      //是否显示行间隔色
			cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
			pagination: true,                   //是否显示分页（*）
			sortable: false,                     //是否启用排序
			sortOrder: "asc",                   //排序方式
			queryParamsType: "limit", 			//参数格式,发送标准的RESTFul类型的参数请求  
			queryParams:$("#formSearch").serialize(),//传递参数（*）
			sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
			pageNumber: 1,                       //初始化加载第一页，默认第一页
			pageSize: 10,                       //每页的记录行数（*）
			pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
			search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
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
						field: 'subofficename',
						title: '所属分局'
				  }
				 ,{
						field: 'contractname',
						title: '合同名称',
						width: 300
				  }
				 ,{
						field: 'contractnum',
						title: '合同编号'
				  }
				 ,{
						field: 'amount',
						align: 'right',
						title: '合同金额(万元)',
						formatter:function (value, row, index, field) {
							return fmoney(value,4);
						}
				  }
				 ,{
						field: 'durationtime',
						title: '合同工期(年/月/天)'
				  }
				 ,{
						field: 'signtimestr',
						align: 'center',
						title: '合同签订日期'
				  }
				 ,{
						field: 'contractpartyb',
						title: '合同乙方'
				  }
				 ,{
						field: 'remark',
						title: '备注'
				  }
				 ,{
						field: 'statusstr',
						align: 'center',
						title: '状态'
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
				contractname:$("#contractname").val(),
				suboffice:$("#suboffice").val(),
				limit: params.limit,   //页面大小
			offset:params.offset
		};
		return temp;
	};
	return oTableInit;
};
function reloadtable(){
	$.ajax({
		url: $("#fule").val()+'contract/contractSignedListGetData.json',
		data: $("#formSearch").serializeObj(),
		type: "post",
		dataType:"json",
		success : function(json) {
			$("#t_datagrid").bootstrapTable('load', json);
		}
	});
}