$(document).ready(function(){
	var now = new Date();
	var year = now.getFullYear();
	var month = now.getMonth();

	$("#year").val(year);
	$("#month").val(month);
	$('#filename').val(year+'年度工程建设管理月度统计表  —开工工程进度、投资完成情况汇总表');
	$("#yearmonth").val('（'+year+'年＿'+month+'月）');
	$("#reportDaten").val(year+'年'+month+'月25日');
	$("#monthn").val(month+'月完成投资(万元)');
	$("#ytmn").val(year+'年至'+month+'月实际完成投资(万元)');
	//validatef();
	
	var oTable = new TableInit();
	oTable.Init();

	$("#pieEchartdiv1").height(window.innerHeight-$("#head").height()-$("#searchdiv").height()-40);
	$("#pieEchartdiv2").height(window.innerHeight-$("#head").height()-$("#searchdiv").height()-40);
	$("#contentTablediv").height(window.innerHeight-$("#head").height()-$("#searchdiv").height()-40);
	
	$("#formSearch").submit(function(e){
	    e.preventDefault();//必须添加，不然就重复提交
	});
	
	$("#btn_query").click(reloadtable);
});
var LODOP; //声明为全局变量 
function dolengprint(){
	//纵向打印
	LODOP=getLodop();  
	LODOP.PRINT_INIT("");
	LODOP.SET_PRINT_STYLE("FontSize",14);
	LODOP.SET_PRINT_STYLE("Bold",1);
	LODOP.ADD_PRINT_TEXT(30,231,260,39,$("#filename").val());
	LODOP.ADD_PRINT_TEXT(76,261,260,39,$("#yearmonth").val());
	LODOP.ADD_PRINT_TEXT(96,20,460,39,"填报单位(盖章)：建设管理处");
	LODOP.ADD_PRINT_TEXT(116,20,260,39,"填报时间："+$("#reportDaten").val());
	LODOP.ADD_PRINT_TEXT(136,20,260,39,"填报人："+$("#reportUser").val());
	LODOP.ADD_PRINT_HTM(100,20,1100,800,'<table id="t_datagrid" border="1px solid #ddd;"style="border-collapse:collapse;table-layout:fixed;border:solid 1px black;">'+document.getElementById("t_datagrid").innerHTML+'</table>');
	LODOP.PREVIEW();
}
function doacrossprint(){
	//横向打印
	LODOP=getLodop();  
	LODOP.PRINT_INIT("");
	LODOP.SET_PRINT_PAGESIZE(2,900,500,'');
	LODOP.SET_PRINT_STYLE("FontSize",14);
	LODOP.SET_PRINT_STYLE("Bold",1);
	LODOP.ADD_PRINT_TEXT(30,431,260,39,$("#filename").val());
	LODOP.ADD_PRINT_TEXT(76,461,260,39,$("#yearmonth").val());
	LODOP.ADD_PRINT_TEXT(96,20,460,39,"填报单位(盖章)：建设管理处");
	LODOP.ADD_PRINT_TEXT(116,20,260,39,"填报时间："+$("#reportDaten").val());
	LODOP.ADD_PRINT_TEXT(136,20,260,39,"填报人："+$("#reportUser").val());
	LODOP.ADD_PRINT_HTM(160,20,1100,800,'<table id="t_datagrid" border="1px solid #ddd;"style="border-collapse:collapse;table-layout:fixed;border:solid 1px black;">'+document.getElementById("t_datagrid").innerHTML+'</table>');
	LODOP.PREVIEW();
}
function setParam(){
	if($("#year").val() == '' || $("#month").val() == '' || $("#month").val() >12|| $("#month").val()<=0){
		$('#filename').val('');
		$("#yearmonth").val('');
		$("#reportDaten").val('');
		$("#monthn").val('');
		$("#ytmn").val('');
	}else{
		var year = $("#year").val();
		var month = parseInt($("#month").val());
		$('#filename').val('合同执行月统计('+year+'_'+month+')');
		$("#yearmonth").val('（'+year+'年＿'+month+'月）');
		$("#reportDaten").val(year+'年'+month+'月25日');
		$("#monthn").val(month+'月完成投资(万元)');
		$("#ytmn").val(year+'年至'+month+'月实际完成投资(万元)');
	}
}
function reloadtable(){
	if($("#year").val() == '' || $("#month").val() == ''){
		modalTitle("请选择年月",1);
		return;
	}
	$("#spanmonth").html($("#monthn").val());
	$("#spanytm").html($("#ytmn").val());
	
	$.ajax({
		url: $("#fule").val()+'contract/contractExecuteMonthTotalListGetDat.json',
		data: $("#formSearch").serializeObj(),
		type: "post",
		dataType:"json",
		success : function(json) {
			$("#t_datagrid").bootstrapTable('load', json);
		}
	});
}
function setFileName(){
	$("#excelbtn").attr("lang",$("#year").val()+"年"+$("#month").val()+"月"+"合同执行月统计表");
}
function changeView(){
	if($("#btnLabber").html() == '图表视图'){
		$("#btnLabber").html('列表视图');
		$("#printbtn").hide();
		$("#excelbtn").hide();
		$("#contentTablediv").hide();
		$("#pieEchartdiv1").show();
		$("#btn_changeCahart").show();
		echartinitpie();
	}else{
		$("#btnLabber").html('图表视图');
		$("#printbtn").show();
		$("#excelbtn").show();
		$("#contentTablediv").show();
		$("#contentEchartdiv").hide();
		$("#btn_changeCahart").hiden();
	}
}
function validatef(){
	$('#formSearch').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			year: {
				validators: {
					notEmpty: {
						message: '年份不能为空'
					},
					stringLength: {
                        min: 4,
                        max: 4,
                        message: '年份长度为4位'
                    },
					regexp: {
						regexp: /^[0-9]+$/,
						message: '年份必须为数字'
					}
				}
			},
			month: {
				validators: {
					notEmpty: {
						message: '月份不能为空'
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
function echartinitpie(){
	var rows = $('#t_datagrid').bootstrapTable('getData');
	for(var i = 0; i < rows.length-1; i++){
		echartonepie('onepiediv'+(i+1),rows[i]);
	}
}
function echartonepie(_divid,datas){
	echarts.init(document.getElementById(_divid)).setOption({
		 title:{//标题
            text:datas["departStr"],
            top:'bottom',
            left:'center',
            textStyle:{
                fontSize: 14,
                fontWeight: '',
                color: '#333'
            },
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {
                    show: true,
                    type: ['pie', 'funnel']
                },
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        series: {
        	name: '分局合同月统计',
            type: 'pie',
            data: [
                {name: '合同总金额', value: datas["contractTotal"]},
                {name: '本年度计划完成投资', value: datas["thisYearPlan"]},
                {name: '本月完成投资', value: datas["thisMonthInvest"]},
                {name: '本年至当月完成投资', value: datas["thisYtmTotal"]},
                {name: '自开关以来累计完成投资', value: datas["investTotal"]},
                {name: '累计结算工程款额', value: datas["balanceTotal"]},
                {name: '工程累计支付情况', value: datas["payforTotal"]}
            ]
        }
    });
}
function echartinitpie2(){
	var rows = $('#t_datagrid').bootstrapTable('getData');
	for(var i = 0; i < rows.length-1; i++){
		echartonepie('onepiediv'+(i+1),rows[i]);
	}
}
function echartonepie2(_divid,datas){
	echarts.init(document.getElementById(_divid)).setOption({
		 title:{//标题
            text:datas["departStr"],
            top:'bottom',
            left:'center',
            textStyle:{
                fontSize: 14,
                fontWeight: '',
                color: '#333'
            },
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {
                    show: true,
                    type: ['pie', 'funnel']
                },
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        
        series: {
        	name: '分局合同月统计',
            type: 'pie',
            data: [
                {name: '合同总金额', value: 1},
                {name: '本年度计划完成投资', value: datas["thisYearPlan"]},
                {name: '本月完成投资', value: datas["thisMonthInvestStr"]},
                {name: '本年至当月完成投资', value: datas["thisYtmTotal"]},
                {name: '自开关以来累计完成投资', value: datas["investTotalStr"]},
                {name: '累计结算工程款额', value: datas["balanceTotalStr"]},
                {name: '工程累计支付情况', value: datas["payforTotalStr"]}
            ]
        }
    });
}
var TableInit = function () {
	var oTableInit = new Object();
	//初始化Table
	oTableInit.Init = function () {
		$('#t_datagrid').bootstrapTable({
			url: $("#fule").val()+'contract/contractExecuteMonthTotalListGetDat.json',         //请求后台的URL（*）
			method: 'post',                      //请求方式（*）
			contentType :'application/x-www-form-urlencoded; charset=UTF-8',
			toolbar: false,                //工具按钮用哪个容器
			striped: true,                      //是否显示行间隔色
			cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
			pagination: false,                   //是否显示分页（*）
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
			columns: [
				[
				  {field: 'departStr',title: '直属分局' ,align:'center',width : 100}
				 //,{field: 'contractTotal',hiden:'true'}
				 ,{field: 'contractTotalStr',title: '合同总金额（万元）',align:'right',
						formatter:function (value, row, index, field) {
							return fmoney(value,4);
						}
				 }
				 //,{field: 'thisYearPlan',hiden:'right'}
				 ,{field: 'thisYearPlanStr',title: '本年度计划完成投资（万元）',align:'right',
						formatter:function (value, row, index, field) {
							return fmoney(value,4);
						}
				 }
				 //,{field: 'thisMonthInvest',hiden:'right'}
				 ,{field: 'thisMonthInvestStr',align:'right',
					 title: '<span id="spanmonth">'+$("#monthn").val()+'</span>',
						formatter:function (value, row, index, field) {
							return fmoney(value,4);
						}
				 }
				 //,{field: 'thisYtmTotal',hiden:'right'}
				 ,{field: 'thisYtmTotalStr',align:'right',
					 title: '<span id="spanytm">'+$("#ytmn").val()+'</span>',
						formatter:function (value, row, index, field) {
							return fmoney(value,4);
						}
				 }
				 //,{field: 'investTotal',hiden:'right'}
				 ,{field: 'investTotalStr',title: '自开工以来累计完成投资（万元）',align:'right',
						formatter:function (value, row, index, field) {
							return fmoney(value,4);
						}
				 }
				 //,{field: 'balanceTotal',hiden:'right'}
				 ,{field: 'balanceTotalStr',title: '累计结算工程款额（万元）',align:'right',
						formatter:function (value, row, index, field) {
							return fmoney(value,4);
						}
				 }
				 //,{field: 'payforTotal',hiden:'right'}
				 ,{field: 'payforTotalStr',title: '工程款累计支付情况（万元）',align:'right',
						formatter:function (value, row, index, field) {
							return fmoney(value,4);
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
	
	return oTableInit;
};