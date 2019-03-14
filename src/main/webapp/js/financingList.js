$(document).ready(function(){
	var oTable = new TableInit();
	oTable.Init();
	$("#contentTablediv").height(window.innerHeight-$("#head").height()-$("#searchdiv").height()-40);
});
function showDetail(_year,_costType){
	window.location.href = $("#fule").val()+'financing/financingListDetail.web?year='+_year+'&costtype='+_costType;
}
function addDetail(){
	
}
var TableInit = function () {
	var oTableInit = new Object();
	//初始化Table
	oTableInit.Init = function () {
		var _writeyear = $("#txt_search_year").val();
		$('#t_datagrid').bootstrapTable({
			url: '/echart/financing/getfinancingListData.json?writeyear='+_writeyear,         //请求后台的URL（*）
			method: 'post',                      //请求方式（*）
			editable:true,//开启编辑模式
			toolbar: false,                //工具按钮用哪个容器
			striped: true,                      //是否显示行间隔色
			cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
			pagination: false,                   //是否显示分页（*）
			sortable: false,                     //是否启用排序
			sortOrder: "asc",                   //排序方式
			queryParams: null,//传递参数（*）
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
				  {field: 'costType',visible: false},
				  {field: 'costTypeStr',align: 'left',title: '款项类型' ,valign : "middle",width : 100},
				  {field: 'mainType',visible: false},
				  {field: 'mainTypeStr',align: 'center',title: '款项所属' ,valign : "middle",width : 100},
				  {field: 'year',align: 'center',title: '所属年份' ,valign : "middle",width : 120,
						formatter:function (value, row, index, field) {
							return _writeyear;
						}
				  },
				  {field: 'total',align: 'center',title: '累计金额' ,width : 150},
				  {field: '',align: 'center',title: '操作' ,width : 150,
						formatter:function (value, row, index, field) {
					        return [
							      '<button type="button" onclick="addDetail('+_writeyear+',\''+row["costType"]+'\')" class="RoleOfdelete btn btn-primary  btn-sm" style="margin-right:15px;">增加明细</button>',
							      '<button type="button" onclick="showDetail('+_writeyear+',\''+row["costType"]+'\')" class="RoleOfedit btn btn-primary  btn-sm" style="margin-right:15px;">查看明细</button>'
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
			limit: params.limit,   //页面大小
			offset:params.offset
		};
		return temp;
	};
	return oTableInit;
};

/**
 * 新增一行数据
 */
function addRow(){
    var count = $('#t_datagrid').bootstrapTable('getData').length;
    // newFlag == 1的数据为新规的数据
    $('#t_datagrid').bootstrapTable('insertRow',{index:count,row:{newFlag:"1"}});
}
/**
 * 删除一行数据
 */
function delRow(){
    var count = $('#t_datagrid').bootstrapTable('getData').length;
    var checkRow= $("#t_datagrid").bootstrapTable('getSelections');
    if(checkRow.length<=0){
		 alert("请选中一行")
	}else{
		var check=JSON.stringify(checkRow);
		console.log(check);
	}
    if (count == 1) {
        info("已经是最后一条，不能删除!");
        return;
    }
}