$(document).ready(function(){
	loadSubofficeData(1,0,"suboffice");
	$("#content").height(window.innerHeight+60);
	
	var oTable = new TableInit();
	oTable.Init();
	$("#contentTablediv").height(window.innerHeight-$("#head").height()-$("#searchdiv").height()-40);
});

var TableInit = function () {
	var oTableInit = new Object();
	//初始化Table
	oTableInit.Init = function () {
		$('#t_datagrid').bootstrapTable({
			url: $("#fule").val()+'/project/findByperentidon3on4.json',         //请求后台的URL（*）
			method: 'post',                      //请求方式（*）
			contentType :'application/x-www-form-urlencoded; charset=UTF-8',
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
						field: 'entnyname',
						title: '工作面',
						valign:"middle",
                        align:"center",
                        colspan: 1,
                        rowspan: 2,
                        formatter:function (value, row, index, field) {
                        	var grade = row["grade"];
                        	console.info("grade=="+grade);
                        	if(grade == 4){
                        		return "<div style='font-size:20px'><b>"+value+"</b></div>";
                        	}else{
                        		return value;
                        	}
                        }
					},
					{
						title: "累计进尺（m）",
                        valign:"middle",
                        align:"center",
                        colspan: 2,
                        rowspan: 1
					},
					{
						title: "进度",
                        valign:"middle",
                        align:"center",
                        colspan: 1,
                        rowspan: 2,
                        formatter:function (value, row, index, field) {
                        	var begindate = row['begindate'];
                        	var planfinishdate = row['planfinishdate'];
                        	var workload = row['workload'];
                        	if(begindate != null && planfinishdate != null){
                        		
	                        	//工期天数
	                        	var Conperiod = dateDiff(begindate,planfinishdate)+1;
	                        	//当前是第几天工期
	                        	var date = new Date();
	                        	console.info(date.toLocaleDateString());
	                        	var presentdConperiod = dateDiff(begindate,date.toLocaleDateString())+2;
	                        	console.info("ts====="+Conperiod);
	                        	console.info("dqts==="+presentdConperiod);
	                        	//累计完成率
	                        	var acrate = row["accumulationcompletionrate"];
	                        	console.info("acrate=="+acrate);
	                        	//计划完成百分比
	                        	var planfinishingrate = presentdConperiod / Conperiod;		//当前施工天数/工期
	                        	console.info(planfinishingrate);
	                        	if(acrate < planfinishingrate){
	                        		return '<div style="font-size:16px; color:#F00">滞后</div>';
	                        	}else{
	                        		return "";
	                        	}
                        	}else{
                        		return "";
                        	}
                        	
                        	
//                        	console.info("begindate====="+begindate);
//                        	if(begindate != null){
//                        		console.info((new Date(parseInt(begindate))).toLocaleString());
//                        	}
//                        	console.info("begindate====="+begindate);
//							if(planfinishdate != null){
//								console.info((new Date(parseInt(planfinishdate))).toLocaleString());              		
//							}
//							console.info("workload====="+workload);
                        	
                        	
						}
                        
					}
				],
				[
					{
						field: 'accumulationcumulant',
						title: '本月累计完成量',
						valign:"middle",
                        align:"center",
                        formatter:function (value, row, index, field) {
                        	var grade = row["grade"];
                        	console.info("grade=="+grade);
                        	if(grade == 4){
                        		return "";
                        	}else{
                        		return value;
                        	}
                        }
					},
					{
						field: 'completionrate',
						title: '本月累计完成率',
						valign:"middle",
                        align:"center",
                        formatter:function (value, row, index, field) {
                        	var grade = row["grade"];
                        	console.info("grade=="+grade);
                        	if(grade == 4){
                        		return "";
                        	}else{
                        		return (value*100)+"%";
                        	}
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
			limit: params.limit,   //页面大小
			offset:params.offset,
//			contractname:$("#contractname").val(),
//			suboffice:$("#suboffice").val(),
//			belongTimeStr:$("#belongTimeStr").val()
			subsection:$("#subsection").val()
		};
		return temp;
	};
	return oTableInit;
};

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

//查找一级分局
function loadSubofficeData(grade,perentid,pulldown){
	$.ajax({
		url:$("#fule").val()+"project/stairsubofficeGet.json",
		type:"POST",
		data : {
			"grade" : grade,
			"perentid" : perentid
		},
		dataType:"json",
		success:function(data){
			var strHtml= '<option value="0">-请选择-</option>';
			$.each(data, function(key,value){
				strHtml+='<option value="'+value.maintenanceid+'">'+value.entnyname+'</option>';
			});
			$("#"+pulldown).html(strHtml);
		},
		error:function(){
			
		}
	});
}

/*function loadSubofficeData(){
	$.ajax({
		url:$("#fule").val()+"project/stairsubofficeGet.json",
		type:"POST",
		data : 1,
		dataType:"json",
		success:function(data){
			var strHtml= '<option value="0">-请选择-</option>';
			$.each(data, function(key,value){
				strHtml+='<option value="'+value.maintenanceid+'">'+value.entnyname+'</option>';
			});
			$("#suboffice").html(strHtml);
		},
		error:function(){
			
		}
	});
}*/

//修改事件
function updatexpulldown(cs){
	if(cs == 1){
		loadSubofficeData(2,$("#suboffice").val(),"minutemark");
	}else
	if(cs == 2){
		loadSubofficeData(3,$("#minutemark").val(),"subsection");
	}else
	if(cs == 3){
		//loadSubofficeData(3,$("#subsection").val(),"subsection");
	}
}

function reloadtable(){
	var perentid = $("#subsection").val();
	if(perentid != null){
		$.ajax({
			url: $("#fule").val()+'project/findByperentidon3on4.json',
			data : {
				"perentid" : perentid,
			},
			type : "post",
			dataType : "json",
			success : function(json) {
				$("#t_datagrid").bootstrapTable('load', json);
			}
		});
	}else{
		alert("请选择所属分标！");
	}
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

//计算两个日期的天数差
function dateDiff(firstDate,secondDate){
	var firstDate = new Date(firstDate);
	var secondDate = new Date(secondDate);
	var diff = Math.abs(firstDate.getTime() - secondDate.getTime())
	var result = parseInt(diff / (1000 * 60 * 60 * 24));
	return result
}

//重写日期转换方法
Date.prototype.toLocaleString = function() {
    return this.getFullYear() + "年" + (this.getMonth() + 1) + "月" + this.getDate() + "日 ";
};
