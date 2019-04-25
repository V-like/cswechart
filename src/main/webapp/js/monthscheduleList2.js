$(document).ready(function(){
	$('#belongTime').datetimepicker({
		minView : 3,
		startView : 3,
		language : 'zh-CN',
		autoclose : true,
		format : 'yyyy-mm'
	}).on('changeDate', reloadtable);
	var date=new Date;
	var year=date.getFullYear(); 
	var month=date.getMonth()+1;
	if(month<10){
		month="0"+month;
	}
	$("#belongTimeStr").val(year+"-"+month);
	
	var oTable = new TableInit();
	oTable.Init();
	$("#contentTablediv").height(window.innerHeight-$("#head").height()-$("#searchdiv").height()-40);
});
//function dateChange(){
//	TableInit();
//};

var TableInit = function () {
	var oTableInit = new Object();
	//初始化Table
	oTableInit.Init = function () {
		$('#t_datagrid').bootstrapTable({
			url: $("#fule").val()+"project/monthscheduleData.json?date="+ $("#belongTimeStr").val(),  //请求后台的URL（*）
			method: 'post',                      //请求方式（*）
			toolbar: false,                		//工具按钮用哪个容器
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
						checkbox : true,
						valign : "middle",
						width : 40,
						formatter : function(value,row, index, field) {
							var mid = row["mid"];
							var fid = row["fid"];
							if (mid == undefined) {
								mid = "";
							}
//							if (fid == undefined) {
//								fid = "";
//							}
							return '<input type="hidden" id="mid_'+index+'" name="list['
									+ index
									+ '].mid" value="'
									+ mid
									+ '" />'+
									'<input type="hidden" id="fid_'+index+'" name="list['
									+ index
									+ '].fid" value="'
									+ fid
									+ '" />';
						},
						footerFormatter : function(
								value) {
							return '-';
						},
					},
				  {
					  field: 'number',
					  title: '序号',
					  width : 100
				  },
				  {
						field: 'entnyname',
						title: '项目名称',
						width : 200
				  },
				  {
						field: 'date',
						title: '所属年月',
						width : 70,
						formatter:function (value, row, index, field) {
							return '<div id="date_'+index+'">' + $("#belongTimeStr").val() + '</div>' ;
					    }
						
				  },
				  {
						field: 'unit',
						title: '单位',
						width : 60
				  },
				  {
						field: 'designquantity',
						title: '设计工程量',
						width : 90,
						formatter:function (value, row, index, field) {
							
							return '<div id="designquantity_'+index+'" contenteditable="false" >' + (value || "") + '</div>' +
							'<input type="hidden" value="'+(value || "")+'" id="designquantity'+index+'" name="list['+index+'].designquantity" />';
					    }
				  },
				  {
						field: 'changequantity',
						title: '变更工程量',
						width : 90,
						formatter:function (value, row, index, field) {
							
							return '<div id="changequantity_'+index+'" contenteditable="false" >' + (value || "")+ '</div>' +
							'<input type="hidden" value="'+(value || "")+'" id="changequantity'+index+'" name="list['+index+'].changequantity" />';
					    }
				  },
				  {
						field: 'plannedvolume',
						title: '本月计划完成量',
						width : 90,
						formatter:function (value, row, index, field) {
							
							return '<div id="plannedvolume_'+index+'" contenteditable="false" >' +  (value || "")+ '</div>' +
							'<input type="hidden" value="'+(value || "")+'" id="plannedvolume'+index+'" name="list['+index+'].plannedvolume" />';
					    }
				  },
				  {
						field: 'accumulationcumulant',
						title: '本月累计完成量',
						width : 90,
						formatter:function (value, row, index, field) {
							
							return '<div id="accumulationcumulant_'+index+'" contenteditable="false" >' +  (value ||"")  + '</div>' +
							'<input type="hidden" value="'+(value || "")+'" id="accumulationcumulant'+index+'" name="list['+index+'].accumulationcumulant" />';
					    }
				  },
				  {
						field: 'completionrate',
						title: '本月完成率 ',
						width : 90,
						formatter:function (value, row, index, field) {
							var v = "";
							if(value != undefined && value != ''){
								v = fmoney(value,2)+"%";
							}
							return '<div id="completionrate_'+index+'" contenteditable="false" >' +  ( v || "")  + '</div>' +
							'<input type="hidden" value="'+(value || "")+'" id="completionrate'+index+'" name="list['+index+'].completionrate" />';
					    }
				  },
				  {
						field: 'accumulatedcompletion',
						title: '积累完成总量',
						width : 90,
						formatter:function (value, row, index, field) {
							return '<div id="accumulatedcompletion_'+index+'" contenteditable="false" >' + (value || "")   + '</div>' +
							'<input type="hidden" value="'+(value || "")+'" id="accumulatedcompletion'+index+'" name="list['+index+'].accumulatedcompletion" />';
					    }
				  },
				{
						field: 'accumulationcompletionrate',
						title: '积累完成率',
						width : 90,
						formatter:function (value, row, index, field) {
							
							var v = "";
							if(value != undefined && value != ''){
								v = fmoney(value,2)+"%";
							}
							return '<div id="accumulationcompletionrate_'+index+'" contenteditable="false" >' + (v || "")   + '</div>' +
							'<input type="hidden" value="'+(value || "")+'" id="accumulationcompletionrate'+index+'" name="list['+index+'].accumulationcompletionrate" />';
					    }
				  },
				  {
						field: 'backups',
						title: '备注',
						width : 300,
						formatter:function (value, row, index, field) {
							
							
					        return '<div id="backups_'+index+'" contenteditable="false">' + (value || "") + '</div>' + 
							'<input type="hidden" value="'+(value || "")+'" id="backups'+index+'" name="list['+index+'].backups" />';
					    },
					    footerFormatter: function (value) {
					    	return '-';
					    },
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



function reloadtable(){
	$.ajax({
		url: $("#fule").val()+'project/monthscheduleData.json?date='+$("#belongTimeStr").val(),
		data: $("#belongTimeStr").val(),
		type: "get",
		dataType:"json",
		success : function(json) {
			$("#t_datagrid").bootstrapTable('load', json);
		}
	});
}