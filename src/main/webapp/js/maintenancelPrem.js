$(document).ready(function(){
	showloding();
	getMaintenanceDate();
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
	        		
	        		$("#left").on("click","li",function(){
	        			var nodeId = $(this).attr("data-nodeid");
	        			var node = $('#left').treeview("getNode",nodeId);
	        			nowid = node["id"];
	        			caozqxs = "";
	        			chakqxs = "";

	        			$.ajax({
	        				url:$("#fule").val()+"muserauthority/muserauthorityList.json",
	        				type:"POST",
	        				dataType:"json",
	        				data:{leftid:nowid},
	        		        success:function(data){
	        		        	if(data != undefined){
	        		        		if(data["caozqxs"] != undefined){
	        		            		caozqxs = data["caozqxs"];
	    		    	        	}
	        		        		if(data["chakqxs"] != undefined){
	        		        			chakqxs = data["chakqxs"];
	        		        		}
	    	        		    }

	        		        	getSubofficeDate();
	        	        	},error:function(){
	        					modalTitle("操作失败",1);
	        					console.log("失败");
	        				}
	        			});
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
function setOfficeNodes(data,outp,checkeds){
	$.each(data, function(index, value) {
		var proNode = {};
		// text是显示的内容
		proNode["pid"] = value.pid;
		proNode["text"] = value.subofficename;
		proNode["id"] = value.subofficeid;
		
		if(checkeds.indexOf(","+value.subofficeid+",") != -1){
			proNode["state"]= {checked: true,selected: true};
		}else{
			proNode["state"]= {checked: false,selected: false};
		}
		proNode["nodes"] = [];
		// 节点不可选中
		//proNode["selectable"] = false;
		if(value.subs != undefined && value.subs.length > 0)
			setMaintNodes(value.subs,proNode["nodes"]);
		
		outp.push(proNode);
	});
}
function getSubofficeDate(){	
	$.ajax({
		url:$("#fule").val()+"suboffice/getDepartTreeData.json",
		type:"POST",
		dataType:"json",
		data:null,
        success:function(data){
        	if (data != undefined && data != null && data.length > 0) {
        		offices = new Array();
				// 遍历子节点
        		setOfficeNodes(data,offices,caozqxs);
				$("#caozqx").treeview({
					data : offices,// 赋值
					highlightSelected : true,// 选中项不高亮，避免和上述制定的颜色变化规则冲突
					multiSelect : true,// 不允许多选，因为我们要通过check框来控制
					showCheckbox : false// 展示checkbox
					}).treeview('collapseAll', {// 节点展开
					silent : false
				});
				
				offices = new Array();
				// 遍历子节点
        		setOfficeNodes(data,offices,chakqxs);
        		$("#caozqx").on("click","li",function(){
        			var nodeId = $(this).attr("data-nodeid");
        			var node = $('#caozqx').treeview("getNode",nodeId);
        			var checkobjid = node["id"];
        			//若原本没有该css，为未选中执行选中操作
        			if(!$(this).hasClass("node-selected")){
        				if(caozqxs.indexOf(","+checkobjid+",") == -1){
        					caozqxs = caozqxs + "," + checkobjid + ",";
        				}
                	}else{
                		if(caozqxs.indexOf(","+checkobjid+",") != -1){
        					caozqxs = caozqxs.replace("," + checkobjid + ",","");
        				}
        			}
        		});
        		
				$("#chakqx").treeview({
					data : offices,// 赋值
					highlightSelected : true,// 选中项不高亮，避免和上述制定的颜色变化规则冲突
					multiSelect : true,// 不允许多选，因为我们要通过check框来控制
					showCheckbox : false// 展示checkbox
					}).treeview('collapseAll', {// 节点展开
					silent : false
				});
        		$("#chakqx").on("click","li",function(){
        			var nodeId = $(this).attr("data-nodeid");
        			var node = $('#chakqx').treeview("getNode",nodeId);
        			var checkobjid = node["id"];
        			//若原本没有该css，为未选中执行选中操作
        			if(!$(this).hasClass("node-selected")){
        				if(chakqxs.indexOf(","+checkobjid+",") == -1){
        					chakqxs = chakqxs + "," + checkobjid + ",";
        				}
                	}else{
                		if(chakqxs.indexOf(","+checkobjid+",") != -1){
                			chakqxs = chakqxs.replace("," + checkobjid + ",","");
        				}
        			}
        		});
			}
		},error:function(){
			modalTitle("操作失败",1);
			console.log("失败");
		}
	});
}
/*
 * 保存数据
 */
function saveRow() {
	modalTitle("是否确定提交", 2);
}
var nowid = '';
var caozqxs = "";
var chakqxs = "";
function saveFun(){
	if(nowid != undefined && nowid != null && nowid != ''){
		$.ajax({
			url:$("#fule").val()+"muserauthority/muserauthoritySave.json",
			type:"POST",
			dataType:"json",
			data:{
				leftid:nowid,
				caozstrs:caozqxs,
				chakstrs:chakqxs
			},
	        success:function(data){
	        	closeloding();
	        	if(data.msgType == 1){
	        		modalTitle("操作成功",1);
				}else{
					modalTitle("操作失败",1);
				}
	    	},error:function(){
				modalTitle("操作失败",1);
				console.log("失败");
			}
		});
	}
}