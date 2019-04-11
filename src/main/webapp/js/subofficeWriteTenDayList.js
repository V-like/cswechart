$(document).ready(function(){
	$("#operinfo").css({'color':'red','font-weight':'bold','margin-left':(window.innerWidth/2-200)});
	var date=new Date;
	var year=date.getFullYear(); 
	var month=date.getMonth()+1;
	if(month<10){
		month="0"+month;
	}
	$("#belongTimeStr").val(year+"-"+month);
	initSelectPicker();
	initTableSelect();
	var oTable = new TableInit();
	oTable.Init();
	$(".datetimepicker").datetimepicker({
		autoclose:true,
		minView:2,
		startView:2,
		language:'zh-CN'
	});
	$('#belongTime').datetimepicker({
		minView: 3,
		startView: 3,
		language:'zh-CN',
		autoclose: true,
		format: 'yyyy-mm' 
	}).on('changeDate',reloadtable);
	$("#contentTablediv").height(window.innerHeight-$("#head").height()-$("#searchdiv").height()-40);
});
function initSelectPicker(){
	subofficeDataInit();
}
function setFootWidth(){
    var footths = $(".fixed-table-footer").find("th");
    var bodytds = $($("#t_datagrid").find(".oddn")[0]).find("td");
    
    if(bodytds != undefined){
    	for(var i = 0; i < bodytds.length; i++){
    		$(footths[i]).width($(bodytds[i]).outerWidth()-2);
    	}
    }
}
var TableInit = function () {
	var oTableInit = new Object();
	//初始化Table
	oTableInit.Init = function () {
		$('#t_datagrid').bootstrapTable({
			url: $("#fule").val()+'subofficewrite/subofficewriteTenDayGetData.json',         //请求后台的URL（*）
			method: 'post',                     //请求方式（*）
			editable:true,						//开启编辑模式
			contentType :'application/x-www-form-urlencoded; charset=UTF-8',
			toolbar: false,                		//工具按钮用哪个容器
			striped: true,                      //是否显示行间隔色
			cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
			pagination: false,                   //是否显示分页（*）
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
			showFooter: true,		                  
			showRefresh: false,                  //是否显示刷新按钮
			minimumCountColumns: 2,             //最少允许的列数
			clickToSelect: true,                //是否启用点击选中行
			uniqueId: "no",                     //每一行的唯一标识，一般为主键列
			showToggle: false,                    //是否显示详细视图和列表视图的切换按钮
			cardView: false,                    //是否显示详细视图
			detailView: false,                   //是否显示父子表
			height: window.innerHeight-$("#head").height()-$("#searchdiv").height()-50,
			onLoadSuccess: function(data){
				setFootWidth();
	        },
			columns: [
				[
				  {                    
                    checkbox: true,
                    valign : "middle",
                    width : 40,
                    formatter:function (value, row, index, field) {
                    	var defaultValue = row["subofficewriteid"];
						if(defaultValue==undefined){
							defaultValue="0";
						}
						return '<input type="hidden" name="list['+index+'].subofficewriteid" value="'+defaultValue+'" />'; 
				    },
				    footerFormatter: function (value) {
				    	return '-';
				    },
                    rowspan: 2
	              },
	              {
					field: 'statusstr',
					align: 'center',
					title: '状态' ,
					valign : "middle",
					width : 100,
					rowspan: 2
				  },
				  {
						field: 'tendaytype',
						align: 'center',
						title: '旬' ,
						valign : "middle",
						width : 100,
						rowspan: 2,
						formatter:function (value, row, index, field) {
//							var tendaytypeStr = ''
//							var indexSelect = tendaytypeStr.indexOf('<option value="'+value+'">');
//							tendaytypeStr = tendaytypeStr.replace('<option value="'+value+'">','<option value="'+value+'" selected="selected">');
//							return '<select readonly="true" name="list['+index+'].tendaytype" class="form-control" id="tendaytype'+index+'" data-width="100px" >'+tendaytypeStr+'</select>';
							var ty = $("#tendaytypeid").val();
							if(ty == 1){
								var tendaytypeStr = '<option value="1" selected = "selected">上旬</option><option value="2">中旬</option><option value="3">下旬</option>';
							}
							if(ty == 2){
								var tendaytypeStr = '<option value="1">上旬</option><option value="2" selected = "selected">中旬</option><option value="3">下旬</option>';					
							}
							if(ty == 3){
								var tendaytypeStr = '<option value="1">上旬</option><option value="2">中旬</option><option value="3" selected = "selected">下旬</option>';
							}
							
							return '<select readonly="true" name="list['+index+'].tendaytype" class="form-control" id="tendaytype'+index+'" data-width="100px" >'+tendaytypeStr+'</select>';
						},
					    footerFormatter: function (value) {
					    	return '-';
					    }
					  },
	              {
					field: 'subofficeid',
					align: 'center',
					title: '分局名称' ,
					valign : "middle",
					width : 250,
					rowspan: 2,
					formatter:function (value, row, index, field) {
						var subofficedataStr = $("#subofficedata").html();
						var indexSelect = subofficedataStr.indexOf('<option value="'+value+'">');
						subofficedataStr = subofficedataStr.replace('<option value="'+value+'">','<option value="'+value+'" selected="selected">');
				        return '<select readonly="true" name="list['+index+'].subofficeid" onchange="contracinputsel(\''+index+'\')" class="form-control" id="subofficeid'+index+'" data-width="100px" value="'+value+'" >'+subofficedataStr+'</select>';
					},
				    footerFormatter: function (value) {
				    	return '-';
				    }
				  },
				  {
					field: 'contractid',
					align: 'center',
					title: '合同名称' ,
					valign : "middle",
					width : 250,
					rowspan: 2,
					formatter:function (value, row, index, field) {
						var subofficeid = $("#subofficeid"+index).val();
						var strHtml= '<option value="0">-请选择-</option>';
						if(subofficeid==0){
							
						}else{
							var data = loadContractDataBySubofficeid(row["subofficeid"]);
							$.each(data, function(key,value2){
								if(value2.contractid==value){
									strHtml+='<option value="'+value2.contractid+'" title="'+value2.contractnum+'"  amount="'+value2.amount+'" selected="selected">'+value2.contractname+'</option>';
								}else{
									strHtml+='<option value="'+value2.contractid+'" title="'+value2.contractnum+'" amount="'+value2.amount+'">'+value2.contractname+'</option>';
								}
							});
						}
						return '<select name="list['+index+'].contractid" onchange="setcontractnum(this,'+index+')" subofficeid="'+row["subofficeid"]+'" class="form-control" id="contractid_'+index+'" data-width="200px" value="'+value+'" >'+strHtml+'</select>';
					},
				    footerFormatter: function (value) {
				    	return '-';
				    }
				  },
				  {
					field: 'contractnum',
					align: 'center',
					title: '合同编号' ,
					valign : "middle",
					width : 220,
					rowspan: 2,
					formatter:function (value, row, index, field) {
						return '<span id="contractnum'+index+'">' + (value || "") + '</span>';
				    },
				    footerFormatter: function (value) {
				    	return '-';
				    }
				  },
				  {
					field: 'constructioncontent',
					align: 'center',
					title: '主要建设内容' ,
					valign : "middle",
					width : 250,
					formatter:function (value, row, index, field) {
				        return '<div id="constructioncontent_'+index+'" contenteditable="true">' + (value || "") + '</div>' + 
						'<input type="hidden" value="'+(value || "")+'" id="constructioncontent'+index+'" name="list['+index+'].constructioncontent" />';
				    },
				    footerFormatter: function (value) {
				    	return '-';
				    },
					rowspan: 2
				  },
				  {
					field: 'begindatestr',
					align: 'center',
					title: '开工时间' ,
					valign : "middle",
					width : 150,
					rowspan: 2,
					formatter:function (value, row, index, field) {
						if(value == undefined){
							value = '';
						}
						laterinitbegindate(index);
				        return '<input name="list['+index+'].begindate" readonly="readonly" style="width: 90px;" type="text" value="'+value+'" id="begindate'+index+'" class="datetimepicker" data-date-format="yyyy-mm-dd" >';
				    },
				    footerFormatter: function (value) {
				    	return '-';
				    }
				  },
				  {
					field: 'planfinishdatestr',
					align: 'center',
					title: '计划完工时间' ,
					valign : "middle",
					width : 150,
					rowspan: 2,
					formatter:function (value, row, index, field) {
						if(value == undefined){
							value = '';
						}
						laterinitplanfinishdate(index);
				        return '<input name="list['+index+'].planfinishdate" readonly="readonly" style="width: 90px;" type="text" value="'+value+'" id="planfinishdate'+index+'" class="datetimepicker" data-date-format="yyyy-mm-dd" >';
				    },
				    footerFormatter: function (value) {
				    	return '合计';
				    }
				  },
				  {
					field: 'budgetinvest',
					align: 'right',
					title: '概算投资<br/>(万元)' ,
					width : 120,
					formatter:function (value, row, index, field) {
				        return '<div id="budgetinvest_'+index+'" contenteditable="true" onblur="$(this).html(fmoney($(this).html(),4))">' + fmoney(value,4) + '</div>' + 
						'<input type="hidden" value="'+(value || "")+'" id="budgetinvest'+index+'" name="list['+index+'].budgetinvest" />';
				    },
				    footerFormatter: function (value) {
				        var summ = 0;
				        for (var i in value) {
				        	summ += mparseFloat(value[i].budgetinvest);
				        }
				        return fmoney(summ,4);
				    },
					rowspan: 2
				  },
				  {
						field: 'contractamount',
						align: 'right',
						title: '合同金额<br/>（万元）' ,
						width : 120,
						formatter:function (value, row, index, field) {
							return '<span id="contractamount'+index+'" >' + fmoney(value,4) + '</span>';
						},
					    footerFormatter: function (value) {
					        var summ = 0;
					        for (var i in value) {
					        	summ += mparseFloat(value[i].contractamount);
					        }
					        return fmoney(summ,4);
					    },
						rowspan: 2
				  },
				  {
					field: '',
					align: 'center',
					title: '投资完成情况' ,
					width : 270,
					colspan: 2
				  },
				  {
					field: '',
					align: 'center',
					title: '计划执行情况' ,
					width : 600,
					colspan: 5
				  },
				  {
					field: '',
					align: 'center',
					title: '累计完成实物工程量' ,
					width : 350,
					colspan: 3
				  },
				  {
					field: 'nextmonthplaninvest',
					align: 'right',
					valign : "middle",
					title: '下一月度计划<br/>完成投资（万元）' ,
					width : 150,
					formatter:function (value, row, index, field) {
						return '<div id="nextmonthplaninvest_'+index+'" contenteditable="true" onblur="$(this).html(fmoney($(this).html(),4))">' + fmoney(value,4) + '</div>' + 
						'<input type="hidden" value="'+(value || "")+'" id="nextmonthplaninvest'+index+'" name="list['+index+'].nextmonthplaninvest" />';
				    },
					rowspan: 2
				  },
				  {
					field: 'remark',
					align: 'center',
					valign : "middle",
					title: '备注' ,
					width : 150,
					formatter:function (value, row, index, field) {
						return '<div id="remark_'+index+'" contenteditable="true">' + (value || "") + '</div>' + 
						'<input type="hidden" value="'+(value || "")+'" id="remark'+index+'" name="list['+index+'].remark" />';
				    },
					rowspan: 2
				  },
				  {
					field: 'overallimageprogress',
					align: 'center',
					valign : "middle",
					title: '总体形象进度（已完成的单项工程、正在进行的单项工程，完成工程占总工程的百分比）' ,
					width : 1200,
					formatter:function (value, row, index, field) {
						return '<div id="overallimageprogress_'+index+'" contenteditable="true">' + (value || "") + '</div>' + 
						'<input type="hidden" value="'+(value || "")+'" id="overallimageprogress'+index+'" name="list['+index+'].overallimageprogress" />';
				    },
					rowspan: 2
				  }
				],
				[{
						field: 'finishinvest',
						align: 'right',
						title: '自开工以来累计<br/>完成投资（万元）',
						width : 190,
						formatter:function (value, row, index, field) {
							return '<div id="finishinvest_'+index+'" onblur="$(this).html(fmoney($(this).html(),4))">' + fmoney(value,4) + '</div>' + 
							'<input type="hidden" value="'+(value || "")+'" id="finishinvest'+index+'" name="list['+index+'].finishinvest" />';
					    },
					    footerFormatter: function (value) {
					        var summ = 0;
					        for (var i in value) {
					        	summ += mparseFloat(value[i].finishinvest);
					        }
					        return fmoney(summ,4);
					    }
				  }
				 ,{
						field: 'surplusinvest',
						align: 'right',
						title: '剩余投资<br/>（万元）',
						width : 80,
						formatter:function (value, row, index, field) {
							return '<div id="surplusinvest_'+index+'" contenteditable="true" onblur="$(this).html(fmoney($(this).html(),4))">' + fmoney(value,4) + '</div>' + 
							'<input type="hidden" value="'+(value || "")+'" id="surplusinvest'+index+'" name="list['+index+'].surplusinvest" />';
					    },
					    footerFormatter: function (value) {
					        var summ = 0;
					        for (var i in value) {
					        	summ += mparseFloat(value[i].surplusinvest);
					        }
					        return fmoney(summ,4);
					    }
				  }
				 ,{
						field: 'yearplaninvest',
						align: 'right',
						title: '本年度计划完成<br/>投资（万元）' ,
						width : 120,
						formatter:function (value, row, index, field) {
							return '<div id="yearplaninvest_'+index+'" contenteditable="true" onblur="$(this).html(fmoney($(this).html(),4))">' + fmoney(value,4) + '</div>' + 
							'<input type="hidden" value="'+(value || "")+'" id="yearplaninvest'+index+'" name="list['+index+'].yearplaninvest" />';
					    },
					    footerFormatter: function (value) {
					        var summ = 0;
					        for (var i in value) {
					        	summ += mparseFloat(value[i].yearplaninvest);
					        }
					        return fmoney(summ,4);
					    }
				  }
				 ,{
						field: 'monthplaninvest',
						align: 'right',
						title: '本月计划完成<br/>投资（万元）',
						width : 120,
						formatter:function (value, row, index, field) {
							return '<div id="monthplaninvest_'+index+'" contenteditable="true" onblur="$(this).html(fmoney($(this).html(),4))">' + fmoney(value,4)+ '</div>' + 
							'<input type="hidden" value="'+(value || "")+'" id="monthplaninvest'+index+'" name="list['+index+'].monthplaninvest" />';
					    },
					    footerFormatter: function (value) {
					        var summ = 0;
					        for (var i in value) {
					        	summ += mparseFloat(value[i].monthplaninvest);
					        }
					        return fmoney(summ,4);
					    }
				  }
				 ,{
						field: 'yearrealityinvest',
						align: 'right',
						title: '本年度实际完成<br/>投资（万元）',
						width : 120,
						formatter:function (value, row, index, field) {
							return '<div id="yearrealityinvest_'+index+'" onblur="$(this).html(fmoney($(this).html(),4))">' + fmoney(value,4) + '</div>' + 
							'<input type="hidden" value="'+(value || "")+'" id="yearrealityinvest'+index+'" name="list['+index+'].yearrealityinvest" />';
					    },
					    footerFormatter: function (value) {
					        var summ = 0;
					        for (var i in value) {
					        	summ += mparseFloat(value[i].yearrealityinvest);
					        }
					        return fmoney(summ,4);
					    }
				  }
				 ,{
						field: 'monthrealityinvest',
						align: 'right',
						title: '本月实际完成<br/>投资（万元）',
						width : 120,
						formatter:function (value, row, index, field) {
							return '<div id="monthrealityinvest_'+index+'" onblur="$(this).html(fmoney($(this).html(),4))">' + fmoney(value,4) + '</div>' + 
							'<input type="hidden" value="'+(value || "")+'" id="monthrealityinvest'+index+'" name="list['+index+'].monthrealityinvest" />';
					    },
					    footerFormatter: function (value) {
					        var summ = 0;
					        for (var i in value) {
					        	summ += mparseFloat(value[i].monthrealityinvest);
					        }
					        return fmoney(summ,4);
					    }
				  }
				 ,{
						field: 'tendayrealityinvest',
						align: 'right',
						title: '本旬实际完成<br/>投资（万元）',
						width : 120,
						formatter:function (value, row, index, field) {
							return '<div id="tendayrealityinvest_'+index+'" contenteditable="true" onblur="$(this).html(uptTendayrealityinvest($(this).html(),4,'+index+'))">' + fmoney(value,4) + '</div>' + 
							'<input type="hidden" value="'+(value || "")+'" id="tendayrealityinvest'+index+'" name="list['+index+'].tendayrealityinvest" />';
					    },
					    footerFormatter: function (value) {
					        var summ = 0;
					        for (var i in value) {
					        	summ += mparseFloat(value[i].tendayrealityinvest);
					        }
					        return fmoney(summ,4);
					    }
				  }
				 ,{
						field: 'earthwork',
						align: 'right',
						title: '土方<br/>（万方）',
						width : 100,
						formatter:function (value, row, index, field) {
							return '<div id="earthwork_'+index+'" contenteditable="true" onblur="$(this).html(fmoney($(this).html(),2))">' + fmoney(value,2) + '</div>' + 
							'<input type="hidden" value="'+(value || "")+'" id="earthwork'+index+'" name="list['+index+'].earthwork" />';
					    },
					    footerFormatter: function (value) {
					        var summ = 0;
					        for (var i in value) {
					        	summ += mparseFloat(value[i].earthwork);
					        }
					        return fmoney(summ,2);
					    }
				  }
				 ,{
						field: 'stonework',
						align: 'right',
						title: '石方<br/>（万方）',
						width : 100,
						formatter:function (value, row, index, field) {
							return '<div id="stonework_'+index+'" contenteditable="true" onblur="$(this).html(fmoney($(this).html(),2))">' + fmoney(value,2) + '</div>' + 
							'<input type="hidden" value="'+(value || "")+'" id="stonework'+index+'" name="list['+index+'].stonework" />';
					    },
					    footerFormatter: function (value) {
					        var summ = 0;
					        for (var i in value) {
					        	summ += mparseFloat(value[i].stonework);
					        }
					        return fmoney(summ,2);
					    }
				  }
				 ,{
						field: 'beton',
						align: 'right',
						title: '混凝土<br/>（万立方米）',
						width : 150,
						formatter:function (value, row, index, field) {
							return '<div id="beton_'+index+'" contenteditable="true" onblur="$(this).html(fmoney($(this).html(),2))">' + fmoney(value,2) + '</div>' + 
							'<input type="hidden" value="'+(value || "")+'" id="beton'+index+'" name="list['+index+'].beton" />';
					    },
					    footerFormatter: function (value) {
					        var summ = 0;
					        for (var i in value) {
					        	summ += mparseFloat(value[i].beton);
					        }
					        return fmoney(summ,2);
					    }
				  }
				]
			],
			//隔行变色
			rowStyle: function (row, index) {
				var classesArr = ['oddn', 'evenn'];
				var strclass = "";
				if (index % 2 === 0) {//偶数行
					strclass = classesArr[0];
				} else {//奇数行
					strclass = classesArr[1];
				}
				return { classes: strclass };
			}
		});
	};
	
	//得到查询的参数
	oTableInit.queryParams = function (params) {
		var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
			limit: params.limit,   //页面大小
			offset:params.offset,
			belongTimeStr:$("#belongTimeStr").val(),
			tendaytypeid:$("#tendaytypeid").val()
		};
		return temp;
	};
	return oTableInit;
};
function laterinitbegindate(_one){
	setTimeout("inputbegindate("+_one+")",300);
}
function laterinitplanfinishdate(_one){
	setTimeout("inputplanfinishdate("+_one+")",300);
}
function inputbegindate(_one){
	$("#begindate"+_one).datetimepicker({
		autoclose:true,
		minView:2,
		startView:2,
		language:'zh-CN'
	});
	$("#begindate"+_one).width(110);
}
function inputplanfinishdate(_one){
	$("#planfinishdate"+_one).datetimepicker({
		autoclose:true,
		minView:2,
		startView:2,
		language:'zh-CN'
	});
	$("#planfinishdate"+_one).width(110);
}
function subofficeDataInit(){
	$.ajax({
		url: $("#fule").val()+'suboffice/mysubofficeGetData.json',
		type: 'post',
		data: {},
		dataType: "json",
		success: function (data) {
			if(data.length == 1){
				$("#subofficedata").append('<option selected value="'
						+data[0].subofficeid+'">'+data[0].subofficename+'</option>');
				$("#subofficeid").val(data[0].subofficeid);
			}else{
				$("#subofficedata").append('<option value="0">-请选择-</option>');
				for(var i=0;i<data.length;i++){
					$("#subofficedata").append('<option value="'
							+data[i].subofficeid+'">'+data[i].subofficename+'</option>');
				}
			}
		}
	});
}
function initTableSelect(){
	//初始分局
	$(".subofficeinputsel").html($("#subofficedata").html());
}
function contracinputsel(_one){
	var subofficeid = $("#subofficeid"+_one).val();
	var data = loadContractDataBySubofficeid(subofficeid);
	var strHtml= '<option value="0">-请选择-</option>';
	$.each(data, function(key,value){
		strHtml+='<option value="'+value.contractid+'" title="'+value.contractnum+'" amount="'+value.amount+'">'+value.contractname+'</option>';
	});
	$("#contractid_"+_one).html(strHtml);
}
function loadContractDataBySubofficeid(subofficeid){
	var returnData;
	$.ajax({
		url:$("#fule").val()+"contract/contractSignedListGetDatBySuboffice.json",
		type:"POST",
		dataType:"json",
		async :false,
		data: {suboffice : subofficeid},
		success:function(data){
			returnData = data;
		},
		error:function(){
			
		}
	});
	return returnData;
}
/**
 * 合同下拉修改事件
 */
function setcontractnum(_this){
	$("#contractnum"+_index).html("");
	
	var index = _this.selectedIndex;
	var _contractnum = $(_this.options[index]).attr("title");
	var _contractamount = $(_this.options[index]).attr("amount");
	var _index = $(_this).attr("id").split("_")[1];
	$("#contractnum"+_index).html(_contractnum);
	$("#contractamount"+_index).html(fmoney(_contractamount));
	//年份,月份,旬
	var year = $("#belongTimeStr").val().split("-")[0];
	var month = $("#belongTimeStr").val().split("-")[1];
	var tendaytype = $("#tendaytypeid").val();
	//第一步：点击合同下拉，填充多个某某累计投资金额
	//发送ajax
	var returnData;
	$.ajax({
		url:$("#fule").val()+"subofficewrite/aa.json",
		type:"POST",
		dataType:"json",
		async :false,
		data: {contractid : $("#contractid_"+_index).val(),year : year,month : month,tendaytype: tendaytype},
		success:function(data){
			returnData=data;
			console.info(data);
		},
		error:function(){
			console.info("报错");
		}
	});
	if(returnData!=null){
			
	var _ti = returnData.tendayrealityinvest;
	var _finishinvest = returnData.finishinvest + _ti;
	if(month=='1' && tendaytype == '1'){
		var _yearrealityinvest = 0.0000;
	}else{
		var _yearrealityinvest = returnData.yearrealityinvest + _ti;
	}
	if(tendaytype == '1'){
		var _monthrealityinvest = 0.0000;
	}else{
		var _monthrealityinvest = returnData.monthrealityinvest + _ti;
	}
	
	console.info("_ti====="+_ti);
	console.info("_finishinvest====="+_finishinvest);
	console.info("_yearrealityinvest====="+_yearrealityinvest);
	console.info("_monthrealityinvest====="+_monthrealityinvest);
	//调用统一修改方法
	unifyUpt(_finishinvest , _yearrealityinvest , _monthrealityinvest , _index);
	}
}
/**
 * 第二步：修改旬累计投资金额时其他累计投资金额累加;
 */
function uptTendayrealityinvest(s,n,index){
	var _index = index;
	console.info(_index);
	var f = $("#finishinvest"+_index).val();
	var y = $("#yearrealityinvest"+_index).val();
	var m = $("#monthrealityinvest"+_index).val()
	if(""==f || f==undefined){
		f=0.0000;
	}
	if(""==y || y==undefined){
		y = 0.0000;
	}
	if(""==m || m==undefined){
		m = 0.0000;
	}
	var _finishinvest = parseFloat( f ) + parseFloat(s);
	var _yearrealityinvest = parseFloat( y ) + parseFloat(s);
	var _monthrealityinvest = parseFloat( m ) + parseFloat(s);
	
	//赋值给展示列
	$("#finishinvest_"+_index).html(fmoney(_finishinvest));
	$("#yearrealityinvest_"+_index).html(fmoney(_yearrealityinvest));
	$("#monthrealityinvest_"+_index).html(fmoney(_monthrealityinvest));
}
/**
 * 统一修改 （自开工，年，月）累计投资金额
 */
function unifyUpt(f,y,m,i){
	//赋值给展示列
	$("#finishinvest_"+i).html(f);
	$("#yearrealityinvest_"+i).html(y);
	$("#monthrealityinvest_"+i).html(m);
	//赋值隐藏域
	$("#finishinvest"+i).val(f);
	$("#yearrealityinvest"+i).val(y);
	$("#monthrealityinvest"+i).val(m);
}

/**
 * 新增一行数据
 */
var hasnosave = false;
function addRow(){
	if(hasnosave){
		alert("您尚有未完成的操作，请保存当前行");
	}else{
		var count = $('#t_datagrid').bootstrapTable('getData').length;
	    // newFlag == 1的数据为新规的数据
	    $('#t_datagrid').bootstrapTable('insertRow',{index:count,row:{newFlag:"1",index:count}});
		$("#subofficeid"+count).html($("#subofficedata").html());
	    //$("#subofficeid"+count).selectpicker("refresh");
		$("#contractid_"+count).html('<option value="0">-请选择-</option>');
		contracinputsel(count);
	    $("#begindate"+count).datetimepicker({
			autoclose:true,
			minView:2,
			startView:2,
			language:'zh-CN'
		});
	    $("#planfinishdate"+count).datetimepicker({
			autoclose:true,
			minView:2,
			startView:2,
			language:'zh-CN'
		});
	    hasnosave = true;
	}
	setFootWidth();
}
/**
 * 删除一行数据
 */
function delRow(){
    var count = $('#t_datagrid').bootstrapTable('getData').length;
    var checkRow= $("#t_datagrid").bootstrapTable('getSelections');
    if(checkRow.length<=0){
    	modalTitle("请选中一条数据",1);
	}else{
		var issave = 0;
		$.each(checkRow,function(key,value){
			if(value.newFlag!=null){
				issave = 1;
			}
		});
		if(issave == 1){
			modalTitle("请先保存数据",1);
			return;
		}else{
			var checkIds = "";
			$.each(checkRow,function(key,value){
				checkIds+=value.subofficewriteid+",";
			});
			if(checkIds.length>0){
				checkIds=checkIds.substring(0,checkIds.length-1);
			}
			showloding();
			$.ajax({
				url: $("#fule").val()+'subofficewrite/deleteSubofficewrite.json?checkIds='+checkIds,
				type: 'post',
				dataType: "json",
				success: function (data) {
					console.log(data)
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
    if (count == 1) {
        info("已经是最后一条，不能删除!");
        return;
    }
    hasnosave = false;
}
/*
 * 保存操作
 */
function saveRow() {
	var length = 0;
	if (true) {
		var rows = $("#t_datagrid").bootstrapTable('getData');
		length = rows.length;
	}
	var _budgetinvest = '';
	var _nextmonthplaninvest = '';
	var _finishinvest = '';
	var _surplusinvest = '';
	var _yearplaninvest = '';
	var _monthplaninvest = '';
	var _yearrealityinvest = '';
	var _monthrealityinvest = '';
	var _tendayrealityinvest = '';
	var _earthwork = '';
	var _stonework = '';
	var _beton = '';
	for (var i = 0; i < length; i++) {
		$("#constructioncontent" + i)
				.val($("#constructioncontent_" + i).html());

		_budgetinvest = $("#budgetinvest_" + i).html();
		if (_budgetinvest != null && _budgetinvest != undefined) {
			while (_budgetinvest.indexOf(",") != -1) {
				_budgetinvest = _budgetinvest.replace(",", "");
			}
			$("#budgetinvest" + i).val(_budgetinvest);
		} else {
			alert("保存失败,数据为空请添加数据1")
			return;
		}

		_nextmonthplaninvest = $("#nextmonthplaninvest_" + i).html();
		if (_nextmonthplaninvest != null && _nextmonthplaninvest != undefined) {
			while (_nextmonthplaninvest.indexOf(",") != -1) {
				_nextmonthplaninvest = _nextmonthplaninvest.replace(",", "");
			}
			$("#nextmonthplaninvest" + i).val(_nextmonthplaninvest);
		} else {
			alert("保存失败,数据为空请添加数据2")
			return;
		}

		_finishinvest = $("#finishinvest_" + i).html();
		if (_finishinvest != null && _finishinvest != undefined) {
			while (_finishinvest.indexOf(",") != -1) {
				_finishinvest = _finishinvest.replace(",", "");
			}
			$("#finishinvest" + i).val(_finishinvest);
		} else {
			alert("保存失败,数据为空请添加数据3")
			return;
		}

		_surplusinvest = $("#surplusinvest_" + i).html();
		if (_surplusinvest != null && _surplusinvest != undefined) {
			while (_surplusinvest.indexOf(",") != -1) {
				_surplusinvest = _surplusinvest.replace(",", "");
			}
			$("#surplusinvest" + i).val(_surplusinvest);
		} else {
			alert("保存失败,数据为空请添加数据4")
			return;
		}

		_yearplaninvest = $("#yearplaninvest_" + i).html();
		if (_yearplaninvest != null && _yearplaninvest != undefined) {
			while (_yearplaninvest.indexOf(",") != -1) {
				_yearplaninvest = _yearplaninvest.replace(",", "");
			}
			$("#yearplaninvest" + i).val(_yearplaninvest);
		} else {
			alert("保存失败,数据为空请添加数据5")
			return;
		}

		_monthplaninvest = $("#monthplaninvest_" + i).html();
		if (_monthplaninvest != null && _monthplaninvest != undefined) {
			while (_monthplaninvest.indexOf(",") != -1) {
				_monthplaninvest = _monthplaninvest.replace(",", "");
			}
			$("#monthplaninvest" + i).val(_monthplaninvest);
		} else {
			alert("保存失败,数据为空请添加数据6")
			return;
		}

		_yearrealityinvest = $("#yearrealityinvest_" + i).html();
		if (_yearrealityinvest != null && _yearrealityinvest != undefined) {
			while (_yearrealityinvest.indexOf(",") != -1) {
				_yearrealityinvest = _yearrealityinvest.replace(",", "");
			}
			$("#yearrealityinvest" + i).val(_yearrealityinvest);
		} else {
			alert("保存失败,数据为空请添加数据7")
			return;
		}

		_monthrealityinvest = $("#monthrealityinvest_" + i).html();
		if (_monthrealityinvest != null && _monthrealityinvest != undefined) {
			while (_monthrealityinvest.indexOf(",") != -1) {
				_monthrealityinvest = _monthrealityinvest.replace(",", "");
			}
			$("#monthrealityinvest" + i).val(_monthrealityinvest);
		} else {
			alert("保存失败,数据为空请添加数据8")
			return;
		}

		_tendayrealityinvest = $("#tendayrealityinvest_" + i).html();
		if (_tendayrealityinvest != null && _tendayrealityinvest != undefined) {
			while (_tendayrealityinvest.indexOf(",") != -1) {
				_tendayrealityinvest = _tendayrealityinvest.replace(",", "");
			}
			$("#tendayrealityinvest" + i).val(_tendayrealityinvest);
		} else {
			alert("保存失败,数据为空请添加数据9")
			return;
		}

		_earthwork = $("#earthwork_" + i).html();
		if (_earthwork != null && _earthwork != undefined) {
			while (_earthwork.indexOf(",") != -1) {
				_earthwork = _earthwork.replace(",", "");
			}
			$("#earthwork" + i).val(_earthwork);
		} else {
			alert("保存失败,数据为空请添加数据10")
			return;
		}

		_stonework = $("#stonework_" + i).html();
		if (_stonework != null && _stonework != undefined ) {
			while (_stonework.indexOf(",") != -1) {
				_stonework = _stonework.replace(",", "");
			}
			$("#stonework" + i).val(_stonework);
		} else {
			alert("保存失败,数据为空请添加数据11")
			return;
		}

		_beton = $("#beton_" + i).html();
		if (_beton != null && _beton != undefined) {
			while (_beton.indexOf(",") != -1) {
				_beton = _beton.replace(",", "");
			}
			$("#beton" + i).val(_beton);
		} else {
			console.info(_beton);
			alert("保存失败,数据为空请添加数据12")
			return;
		}

		$("#remark" + i).val($("#remark_" + i).html());
		$("#overallimageprogress" + i).val(
				$("#overallimageprogress_" + i).html());
	}
	modalTitle("是否确定提交", 2);
}

function saveFun(){
	console.log($("#editForm").serialize());
	showloding();
	$.ajax({
		url: $("#fule").val()+'subofficewrite/insertSubofficewriteTenDay.json?belongTimeStr='+$("#belongTimeStr").val(),
		type: 'post',
		data: $("#editForm").serialize(),
		dataType: "json",
		success: function (data) {
			closeloding();
			modalTitle("操作成功",1);
			window.location.reload();
		},error:function(data){
			closeloding();
			modalTitle("操作失败，请重试",1);
		}
	});
}
function showSubmit(){
	if(hasnosave){
		modalTitle("您尚有未完成的操作，请保存当前行",1);
	}else{
		modalTitle("是否确定进行校验并提交当月数据",4);
	}
}
function submitFun(){
	var checkRow= $("#t_datagrid").bootstrapTable('getSelections');
	var checkIds = "";
	$.each(checkRow,function(key,value){
		checkIds+=value.subofficewriteid+",";
	});
	if(checkIds.length>0){
		checkIds=checkIds.substring(0,checkIds.length-1);
	}
	showloding();
	$.ajax({
		url: $("#fule").val()+'subofficewrite/submitSubofficewriteMonth.json?belongTimeStr='+$("#belongTimeStr").val()+'&checkIds='+checkIds,
		type: 'post',
		data: $("#editForm").serialize(),
		dataType: "json",
		success: function (data) {
			console.log(data)
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
/**
 * 提交历史查询
 */
function showHis(){
	window.location.href = $("#fule").val()+'subofficewrite/subofficewriteSubmitHisList.web';
}
function reloadtable(){
	$.ajax({
		url: $("#fule").val()+'subofficewrite/subofficewriteTenDayGetData.json',
		data: {belongTimeStr:$("#belongTimeStr").val(),tendaytypeid:$("#tendaytypeid").val()},
		type: "post",
		dataType:"json",
		success : function(json) {
			$("#t_datagrid").bootstrapTable('load', json);
		}
	});
}