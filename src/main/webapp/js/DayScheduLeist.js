$(document).ready(function(){
	$('#belongTime').datetimepicker({
		minView : 3,
		startView : 2,
		language : 'zh-CN',
		autoclose : true,
		Boolean : true,
		//format : 'yyyy-mm-dd'
	}).on('changeDate', reloadtable);
	
	var oTable = new TableInit();
	oTable.Init();
	$("#contentTablediv").height(window.innerHeight-$("#head").height()-$("#searchdiv").height()-40);
});
var TableInit = function () {
	var oTableInit = new Object();
	//初始化Table
	oTableInit.Init = function () {
		$('#t_datagrid').bootstrapTable({
			url: $("#fule").val()+"/project/getdaystatementListData.json",       //请求后台的URL（*）
			method: 'post',                     //请求方式（*）
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
			contentType: "json",
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
					  checkbox: true,
	                    valign : "middle",
	                    width : 40,
	                    formatter:function (value, row, index, field) {
	                    	var dayScheduid = row["dayScheduid"];
	                    	var mid = row["mid"];
							if(dayScheduid==undefined){
								dayScheduid="0";
							}
//							if(mid==undefined){
//								mid="";
//							}
							return '<input type="hidden" id="dayScheduid'+index+'" name="list['+index+'].dayScheduid" value="'+dayScheduid+'" />'+
								'<input type="hidden" id="mid'+index+'" name="list['+index+'].mid" value="'+mid+'" />'
							; 
					    },
//					    footerFormatter: function (value) {
//					    	return '-';
//					    },
//	                    rowspan: 2
	              }
				  ,{
						field: 'priority',
						title: '序号',
						width : 140,
				  }
				 ,{
						field: 'entnyname',
						title: '项目名称',
						width : 400,
				  },
				  {
						field: 'unit',
						title: '单位',
						width : 200,
						formatter : function(value,row,index,field){
							if (value == undefined) {
								value = '';
							}
							return (value || "");
						}
				  },
				  {
						field: 'todayaccomplish',
						title: '本日完成量',
						width : 200,
						formatter : function(value,row,index,field){
							if(value == undefined){
								value = '0';
							}
							//return "<div contenteditable='true' id='todayaccomplish'>"+(value || "")+"</div>";
							 return '<div id="todayaccomplish_'+index+'" contenteditable="true">' + value + '</div>' + 
								'<input type="hidden" value="'+(value || "")+'" id="todayaccomplish'+index+'" name="list['+index+'].todayaccomplish" />';
						}
				  },
				  {
						field: 'finishratio',
						title: '本日完成率',
						width : 200,
						formatter : function(value,row,index,field){
							if(value == undefined){
								value = '0%';
							}
							return (value).toFixed(2)+"%";
						}
				  },
				  {
						field: 'describe',
						title: '施工形象描述',
						formatter : function(value,row,index,field){
							if(value == undefined){
								value = '';
							}
							return '<div id="describe_'+index+'" contenteditable="true">' + value + '</div>' + 
							'<input type="hidden" value="'+(value || "")+'" id="describe'+index+'" name="list['+index+'].describe" />';
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
	oTableInit.queryParams = function(params) {
		console.info($("#belongTimeStr").val());
		var temp = { // 这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
//			limit : params.limit, // 页面大小
//			offset : params.offset,
			belongTimeStr : $("#belongTimeStr").val()
		};
		return temp;
	};
	return oTableInit;
};

/*
 * 保存数据
 */
function saveRow() {
	
	
	modalTitle("是否确定提交", 2);
}

function saveFun(){
	var length = 0;
	if (true) {
		var rows = $("#t_datagrid").bootstrapTable('getData');
		length = rows.length;
	}
	var list = new Array();
	for (var i = 0; i < length; i++) {
		var obj = new Object();
		
		obj.dayScheduid = $("#dayScheduid"+i).val();
		obj.monthscheduleid = $("#mid"+i).val();
		obj.todayaccomplish = $("#todayaccomplish_"+i).html();
		obj.day = $("#belongTimeStr").val().substring(8,10);
		obj.describe = $("#describe_"+i).html();
		console.info("d_===");
		console.info($("#todayaccomplish_"+i).html());
		console.info("do===");
		console.info( $("#todayaccomplish"+i).val());
		obj.monthmodifiedvalue = $("#todayaccomplish_"+i).html() - $("#todayaccomplish"+i).val();	
		var d = "daySchedu"+i;
		list.push(d = obj);
//		console.info(obj);	
	}
	console.info(list);
	//保存
	$.ajax({
		url: $("#fule").val()+'/project/savedaystatementList.json',
		data : {
			daystatementliststr : JSON.stringify(list)
		},
		type : "post",
		dataType : "json",
		success : function(data) {
			closeloding();
			modalTitle("操作成功", 1);
			window.location.reload();
		},
		error : function(data) {
			closeloding();
			modalTitle("操作失败，请重试", 1);
		}
	});
}


function reloadtable(){
	$.ajax({
		url: $("#fule").val()+'/project/getdaystatementListData.json',
		data : {
			belongTimeStr : $("#belongTimeStr").val()
		},
		type : "post",
		dataType : "json",
		success : function(json) {
			$("#t_datagrid").bootstrapTable('load', json);
		}
	});
}
