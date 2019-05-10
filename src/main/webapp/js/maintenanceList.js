$(document).ready(function(){
	var oTable = new TableInit();
	oTable.Init();
	$("#contentTablediv").height(window.innerHeight-$("#head").height()-$("#searchdiv").height()-40);
	$("#prembtn").click(premForward);
});
function premForward(){
	window.location.href = $("#fule").val()+"maintenance/maintenancelPrem.web";
}

var TableInit = function () {
	var oTableInit = new Object();
	//初始化Table
	oTableInit.Init = function () {
		$('#t_datagrid').bootstrapTable({
			url: $("#fule").val()+"project/maintenanceGetDBData.json",       //请求后台的URL（*）
			method: 'post',                      //请求方式（*）
			toolbar: false,                //工具按钮用哪个容器
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
			contentType: "json",
			strictSearch: false,
			showColumns: false,                  //是否显示所有的列
			showRefresh: false,                  //是否显示刷新按钮
			minimumCountColumns: 2,             //最少允许的列数
			clickToSelect: false,                //是否启用点击选中行
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
				 ,{field: 'begindatestr',title: '计划开工时间' }
				 ,{field: 'planfinishdatestr',title: '计划完工时间' }			//,align: 'center'
				 ,{field: 'gongqi',title: '工期',
					 formatter:function(value, row, index, field){
					 var begindatestr = row["begindatestr"];
					 var planfinishdatestr = row["planfinishdatestr"];
					 if(begindatestr != null && planfinishdatestr != null){
						 return dateDiffIncludeToday(begindatestr,planfinishdatestr);
					 }else{
						 return "-";
					 }
				 }}	 				 
				 ,{field: 'workload',title: '设计工程量' }
				 ,{field: 'changeworkload',title: '变更工程量' }
				 ,{field: 'accumulatedcompletion',title: '累计完成量' }
				 ,{field: 'accumulationcompletionrate',title: '累计完成率',
					 formatter:function (value, row, index, field) {
							
							if(value != undefined && value != ''){
								return fmoney(value*100,2)+"%";
							}else{
								return value;
							}
							
					    }
				 }
				 ,{field: 'perentid',align: 'center',title: '同级添加' ,width:100,
					 formatter:function (value, row, index, field) {
				        return [
				        	  '<button type="button" onclick="maintenanceAdd('+row["perentid"]+')" class="RoleOfedit btn btn-primary  btn-sm" style="margin-right:15px;" >同级添加</button>',
				        	 ].join('');
				    },
				 }
				 ,{field: 'maintenanceid',align: 'center',title: '下级添加' ,width:100,
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
			idField:'maintenanceid',
			parentIdField: 'perentid',
			treeShowField: 'priority',
			onResetView: function(data) {
				$('#t_datagrid').treegrid({
					treeColumn: 1,//指明第几列数据改为树形
					initialState: 'collapsed',//收缩
					expanderExpandedClass: 'glyphicon glyphicon-triangle-bottom',
					expanderCollapsedClass: 'glyphicon glyphicon-triangle-right',
					onChange: function() {
						$('#t_datagrid').bootstrapTable('resetWidth');
					}
				});
			}
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
var authority="";
function reloadtable(){
	$.ajax({
		url: $("#fule").val()+'project/maintenanceGetDBData.json',
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
	_html = _html + '<div style="width:600px;height:300px;">';
	_html = _html + '	<div class="panel-body" style="padding-bottom:0px;width:600px;height:300px;">';
	_html = _html + '		<div class="form-group">';
	_html = _html + '			<label for="subofficename" class="col-sm-3 control-label">项目名称：</label>';
	_html = _html + '			<div class="col-sm-7">';
	_html = _html + '				<input type="text" class="form-control" id="entnyname"';
	_html = _html + '					placeholder="请输入项目名称" style="margin-top:-10px;">';
	_html = _html + '			</div>';
	_html = _html + '		</div><br/><br/>';
	_html = _html + '		<div class="form-group">';
	_html = _html + '			<label for="subofficename" class="col-sm-3 control-label">单位：</label>';
	_html = _html + '			<div class="col-sm-7">';
	_html = _html + '				<input type="text" class="form-control" id="unit" ';
	_html = _html + '					placeholder="请输入单位"  style="margin-top:-10px;">';
	_html = _html + '			</div>';
	_html = _html + '		</div><br/><br/>';
	_html = _html + '		<div class="form-group">';
	_html = _html + '			<label for="subofficename" class="col-sm-3 control-label">计划开始时间：</label>';
	_html = _html + '			<div class="col-sm-7">';
	_html = _html + '				<input type="text" class="datetimepicker" id="begindate" ';
	_html = _html + '					placeholder="请选择计划开始时间"  style="margin-top:-10px;width:300px;" readonly="true" data-date-format="yyyy-mm-dd" data-pure-clear-button >';
	_html = _html + '			</div>';
	_html = _html + '		</div><br/><br/>';
	_html = _html + '		<div class="form-group">';
	_html = _html + '			<label for="subofficename" class="col-sm-3 control-label">计划结束时间：</label>';
	_html = _html + '			<div class="col-sm-7">';
	_html = _html + '				<input type="text" class="datetimepicker" id="planfinishdate" ';
	_html = _html + '					placeholder="请选择计划结束时间"  style="margin-top:-10px;width:300px;" readonly="true" data-date-format="yyyy-mm-dd" data-pure-clear-button >';
	_html = _html + '			</div>';
	_html = _html + '		</div><br/><br/>';
	_html = _html + '		<div class="form-group">';
	_html = _html + '			<label for="subofficename" class="col-sm-3 control-label">设计工程量：</label>';
	_html = _html + '			<div class="col-sm-7">';
	_html = _html + '				<input type="text" class="form-control" id="workload" ';
	_html = _html + '					placeholder="请输出设计工程量"  style="margin-top:-10px;">';
	_html = _html + '			</div>';
	_html = _html + '		</div><br/><br/>';
	_html = _html + '	</div>';
	_html = _html + '</div>';

	modalTitle(_html,2);
	$("#planfinishdate").datetimepicker({
		autoclose:true,
		minView:2,
		startView:2,
		language:'zh-CN'
	});
	$("#begindate").datetimepicker({
		autoclose:true,
		minView:2,
		startView:2,
		language:'zh-CN'
	});
}



//权限添加
function maintenanceAdd2(_id){
	$.ajax({
		url:$("#fule").val()+"muserauthority/muserauthorityData.json",
		type:"POST",
		dataType:"json",
		data: {
			id : _id,
        },
		success:function(data){
			var _html = '';
			_html = _html + '<input type="hidden" id="maintenanceid2" value="'+_id+'" />';
			_html = _html + '<div style="width:600px;height:150px;">';
			_html = _html + '	<div class="panel-body" style="padding-bottom:0px;width:600px;height:100px;">';
			_html = _html + '		<div class="form-group">';
			_html = _html + '			<label for="subofficename" class="col-sm-3 control-label">分局/姓名</label>';
			_html = _html + '			<div class="col-sm-7">';
			_html = _html + '				<select name="uid" id="uid" style="width:300px;height:30px;" onchange="changeAuthority(value)">';
			_html = _html + '					<option value ="0">请选择用户</option>';
												for(var i=0;i<data.length;i++){
			_html = _html + '					<option value ="'+data[i].authority+'-'+data[i].uid+'">'+data[i].realname+" : "+data[i].username+'</option>';
												}
			_html = _html + '				</select>';
			_html = _html + '			</div>';
			_html = _html + '		</div><br/><br/>';
			_html = _html + '		<div class="form-group">';
			_html = _html + '			<label for="subofficename" class="col-sm-3 control-label">权限</label>';
			_html = _html + '			<div class="col-sm-7">';
			_html = _html + '				可修改：<input type="radio" value="0" name="authority" class="authority"  id="authority0" onclick="authorityclick(0)"/>&nbsp;&nbsp;&nbsp;';
			_html = _html + '				可查看：<input type="radio" value="1" name="authority" class="authority"  id="authority1" onclick="authorityclick(1)"/>&nbsp;&nbsp;&nbsp;';
			_html = _html + '				无权限：<input type="radio" value="2" name="authority" class="authority" id="authority2"  onclick="authorityclick(2)""/>';
			_html = _html + '			</div>';
			_html = _html + '		</div><br/><br/>';
			_html = _html + '	</div>';
			_html = _html + '</div>';
				
			modalTitle(_html,2);
		},
		error:function(){
			console.log("失败");
		}
	});
	

}

function authorityclick(data){
	authority=data;
}
function changeAuthority(data) {
	var authority=data.split("-")[0];
	if(authority=="undefined"){
		$("#authority2").prop("checked","checked");
	}else if(authority==0){
		$("#authority0").prop("checked","checked");
		console.log(0)
		
	}else if(authority==1){
		$("#authority1").prop("checked","checked");
			
		console.log(1)
	}else if(authority==2 || authority==null || authority==""){
		$("#authority2").prop("checked","checked");
		console.log(2)
		
	}
	$("#authority").val()
	
}

function saveFun(){
	var entnyname = $("#entnyname").val();//项目名称
	var unit = $("#unit").val();	//单位
	var maintenanceid = $("#maintenanceid").val();//id
	var begindate = $("#begindate").val();
	var planfinishdate = $("#planfinishdate").val();
	var workload = $("#workload").val();
	var uid = $("#uid").val();
	var mid = $("#mid").val();
	if(uid!=null && uid !=""&& uid!=undefined){
		var mid = $("#maintenanceid2").val();	
		$.ajax({
			url:$("#fule").val()+"muserauthority/muserauthoritySave.json",
			type:"POST",
			dataType:"json",
			data: {
				uid : uid,
				authority : authority,
				mid : mid,
				workload : workloas
				
	        },
			success:function(data){
				$('#t_datagrid').bootstrapTable('refresh');
				modalTitle("操作成功",1);
			},
			error:function(){
				modalTitle("操作失败",1);
				console.log("失败");
			}
		});
		closeloding();
	}else{
		if(entnyname == ""){
	    	alert('请输入项目名称');
	        return false;
	    }
		
		$.ajax({
			url:$("#fule").val()+"project/maintenanceSave.json",
			type:"POST",
			dataType:"json",
			data: {
				entnyname : entnyname,
				unit : unit,
				maintenanceid : maintenanceid,
				begindatestr:begindate,
				planfinishdatestr:planfinishdate,
				workload:workload
	        },
			success:function(data){
				$('#t_datagrid').bootstrapTable('refresh');
				modalTitle("操作成功",1);
			},
			error:function(){
				modalTitle("操作失败",1);
				console.log("失败");
			}
		});
		closeloding();
	}
}
//获得两个日期间的差天数
function dateDiffIncludeToday(startDateString, endDateString){  

	var startTime=startDateString.substr(0,10);//截取时间
	var endTime=endDateString.substr(0,10);
    var separator = "-"; //日期分隔符  
    var startDates = startTime.split(separator);  
    var endDates = endTime.split(separator);  
    var startDate = new Date(startDates[0], startDates[1]-1, startDates[2]);  
    var endDate = new Date(endDates[0], endDates[1]-1, endDates[2]);  
    return parseInt(Math.abs(endDate - startDate)/86400000) + 1;//把相差的毫秒数转换为天数   
};  