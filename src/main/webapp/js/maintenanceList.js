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
			url: $("#fule").val()+"maintenance/maintenanceGetDBData.json",       //请求后台的URL（*）
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
			contentType: "json",
			strictSearch: false,
			showColumns: false,                  //是否显示所有的列
			showRefresh: false,                  //是否显示刷新按钮
			minimumCountColumns: 2,             //最少允许的列数
			clickToSelect: true,                //是否启用点击选中行
			uniqueId: "no",                     //每一行的唯一标识，一般为主键列
			showToggle: false,                    //是否显示详细视图和列表视图的切换按钮
			cardView: false,                    //是否显示详细视图
			detailView: false,                   //是否显示父子表
			height: window.innerHeight-$("#head").height()-$("#searchdiv").height()-50,
			columns: [
				[
				  {checkbox: true}
				 ,{field: 'priority',title: '序号'}
				 ,{field: 'entnyname',title: '项目名称'}
				 ,{field: 'unit',title: '单位' }
				 ,{field: 'perentid',align: 'center',title: '' ,width:100,
					 formatter:function (value, row, index, field) {
				        return [
				        	  '<button type="button" onclick="maintenanceAdd('+row["perentid"]+')" class="RoleOfedit btn btn-primary  btn-sm" style="margin-right:15px;" >同级添加</button>',
				        	 ].join('');
				    },
				 }
				 ,{field: 'maintenanceid',align: 'center',title: '' ,width:100,
						formatter:function (value, row, index, field) {
					        return [
					        	   '<button type="button" onclick="maintenanceAdd('+row["maintenanceid"]+')" class="RoleOfedit btn btn-primary  btn-sm" style="margin-right:15px;" >下级添加</button>',
							      ].join('');
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
	oTableInit.queryParams = function (params) {
		var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
			limit: params.limit,   //页面大小
			offset:params.offset
		};
		return temp;
	};
	return oTableInit;
};


function reloadtable(){
	$.ajax({
		url: $("#fule").val()+'maintenance/maintenanceGetDBData.json',
		data: $("#formSearch").serializeObj(),
		type: "post",
		dataType:"json",
		success : function(json) {
			$("#t_datagrid").bootstrapTable('load', json);
		}
	});
}

//维护添加
function maintenanceAdd(_id){
	var _html = '';
	_html = _html + '<input type="hidden" id="maintenanceid" value="'+_id+'" />';
	_html = _html + '<div style="width:600px;height:100px;">';
	_html = _html + '<div class="panel-body" style="padding-bottom:0px;width:600px;height:100px;">';
	_html = _html + '		  <div class="form-group">';
	_html = _html + '			<label for="subofficename" class="col-sm-3 control-label">项目名称</label>';
	_html = _html + '			<div class="col-sm-7">';
	_html = _html + '				<input type="text" class="form-control" id="entnyname"';
	_html = _html + '					placeholder="请输入项目名称" style="margin-top:-10px;">';
	_html = _html + '			</div>';
	_html = _html + '		  </div><br/><br/>';
	_html = _html + '		  <div class="form-group">';
	_html = _html + '			<label for="subofficename" class="col-sm-3 control-label">单位(CM)</label>';
	_html = _html + '			<div class="col-sm-7">';
	_html = _html + '				<input type="text" class="form-control" id="unit" ';
	_html = _html + '					placeholder="请输入单位"  style="margin-top:-10px;">';
	_html = _html + '			</div>';
	_html = _html + '		  </div>';
	_html = _html + '		</div>';
	_html = _html + '</div>';
		
	modalTitle(_html,2);
	}

function saveFun(){
	var entnyname = $("#entnyname").val();
	console.log(1);
	var priority = $("#priority").val();
	console.log(2);
	var unit = $("#unit").val();
	console.log(3);
	var maintenanceid = $("#maintenanceid").val();	
	console.log(4);
	if(entnyname == ""){
    	alert('请输入项目名称');
        return false;
    }
	console.log(5);
	if(unit == ""){
    	alert('请输入单位');
        return false;
    }
	console.log(6);
	$.ajax({
		url:$("#fule").val()+"maintenance/maintenanceSave.json",
		type:"POST",
		dataType:"json",
		data: {
			entnyname : entnyname,
			priority : priority,
			unit : unit,
			maintenanceid : maintenanceid
        },
		success:function(data){
			 alert("操作成功");
		},
		error:function(){
			console.log("失败");
		}
	});
	console.log(7);
}
