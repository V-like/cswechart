$(document).ready(function(){
	showloding();
	getMaintenanceDate();
	getSubofficeDate();
	closeloding();
});
var leftDate = null;
function setMaintNodes(data,outp){
	$.each(data, function(index, value) {
		var proNode = {};
		// text是显示的内容
		proNode["priority"] = value.priority;
		proNode["text"] = value.entnyname;
		proNode["id"] = value.maintenanceid;
		proNode["nodes"] = [];
		// 节点不可选中
		//proNode["selectable"] = false;
		if(value.subs != undefined && value.subs.length > 0)
			setMaintNodes(value.subs,proNode["nodes"]);
		
		outp.push(proNode);
	});
}
function getMaintenanceDate(){
	if(leftDate == null){
		$.ajax({
			url:$("#fule").val()+"project/maintenanceGetDBTreeData.json",
			type:"POST",
			dataType:"json",
			data:null,
	        success:function(data){
	        	if (data != undefined && data != null && data.length > 0) {
	        		leftDate = new Array();
					// 遍历子节点
	        		setMaintNodes(data,leftDate)
					$("#left").treeview({
						data : leftDate,// 赋值
						highlightSelected : true,// 选中项不高亮，避免和上述制定的颜色变化规则冲突
						multiSelect : false,// 不允许多选，因为我们要通过check框来控制
						showCheckbox : false,// 展示checkbox
						}).treeview('collapseAll', {// 节点展开
						silent : false
					});
				}
			},error:function(){
				modalTitle("操作失败",1);
				console.log("失败");
			}
		});
	}
}

var offices = null;
function setOfficeNodes(data,outp){
	$.each(data, function(index, value) {
		var proNode = {};
		// text是显示的内容
		proNode["pid"] = value.pid;
		proNode["text"] = value.subofficename;
		proNode["subofficeid"] = value.subofficeid;
		proNode["nodes"] = [];
		// 节点不可选中
		//proNode["selectable"] = false;
		if(value.subs != undefined && value.subs.length > 0)
			setMaintNodes(value.subs,proNode["nodes"]);
		
		outp.push(proNode);
	});
}
function getSubofficeDate(){
	if(leftDate == null){
		$.ajax({
			url:$("#fule").val()+"suboffice/getDepartTreeData.json",
			type:"POST",
			dataType:"json",
			data:null,
	        success:function(data){
	        	if (data != undefined && data != null && data.length > 0) {
	        		offices = new Array();
					// 遍历子节点
	        		setOfficeNodes(data,offices);
					$("#caozqx").treeview({
						data : offices,// 赋值
						highlightSelected : true,// 选中项不高亮，避免和上述制定的颜色变化规则冲突
						multiSelect : false,// 不允许多选，因为我们要通过check框来控制
						showCheckbox : false,// 展示checkbox
						}).treeview('collapseAll', {// 节点展开
						silent : false
					});
					$("#chakqx").treeview({
						data : offices,// 赋值
						highlightSelected : true,// 选中项不高亮，避免和上述制定的颜色变化规则冲突
						multiSelect : false,// 不允许多选，因为我们要通过check框来控制
						showCheckbox : false,// 展示checkbox
						}).treeview('collapseAll', {// 节点展开
						silent : false
					});
				}
			},error:function(){
				modalTitle("操作失败",1);
				console.log("失败");
			}
		});
	}
}

/*
 * 保存数据
 */
function saveRow() {
	modalTitle("是否确定提交", 2);
}

function saveFun(){
	
}