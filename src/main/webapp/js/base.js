$(document).ready(function(){
	$("#content").height(window.innerHeight-$("#head").height()-1);
	$("#bodydiv").height(window.innerHeight-$("#head").height()-$("#searchdiv").height()-45);
	
	$("#navbar").find("li").removeClass("active");
	if($("#who").val() != '' && $("#who").val() != 'null'){
		$("#"+$("#who").val()+"li").addClass("active");
	}else{
		$("#mainpli").addClass("active");
	}
	$(".icon-arrow-right").addClass("icon-angle-right");
	
	$.fn.serializeObj=function(){
	    var serializeObj={};
	    var array=this.serializeArray();
	    var str=this.serialize();
	    $(array).each(function(){
	        if(serializeObj[this.name]){
	            if($.isArray(serializeObj[this.name])){
	                serializeObj[this.name].push(this.value);
	            }else{
	                serializeObj[this.name]=[serializeObj[this.name],this.value];
	            }
	        }else{
	            serializeObj[this.name]=this.value; 
	        }
	    });
	    return serializeObj;
	};
});


function print(){
	modalTitle('工程师正在努力实现中<br/>您可以导入后打印',1);
}

function doexcel(){
	if($("#filename").val() == ''){
		modalTitle('无法导出，请先设置关键查询条件',1);		
		return;
	}
	$("#formSearch").attr('action',$("#fule").val()+"excel/toExcelXlsExecute2.web");
	document.getElementById("formSearch").submit();
}

function modalTitle(_msg,_type){
	$("#infobody").html(_msg);
	$(".rightBtn").hide();
	$("#leftBtn").show();
	if(_type != ''){
		$("#rightBtn"+_type).show();
	}
	$('#show-modal').modal().open();
}
function showloding(){
	$("#leftBtn").hide();
	$(".rightBtn").hide();
	$("#infobody").html('<img width="50" src="'+$("#fule").val()+'/image/loading.gif" />处理中，请稍等！');
	$('#show-modal').modal().open();
}
function closeloding(){
	$.modal().close();
}

function fmoney(s, n) {
	if(s == null || s == undefined || s == ''){
		if(n != undefined && n != 2 && n > 0) {
			var result = '';
			while(result.length < n){
				result = result + 0;
			}
			return '0.' + result;
		}else return '0.00';
	}
	
	while((""+s).indexOf(",") != -1){
		s = s.replace(",","");
	}
	n = n > 0 && n <= 20 ? n : 2;
	s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
	var l = s.split(".")[0].split("").reverse(), r = s.split(".")[1];
	t = "";
	for (i = 0; i < l.length; i++) {
		t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
	}
	return t.split("").reverse().join("") + "." + r;
}
function mparseFloat(_val){
	if(_val == undefined) return 0;
	if(_val == null) return 0;
	if(_val == '') return 0;
	return parseFloat(_val);
}
//判断是否为整数或者小数
function isZsOrXs(s){
	var re = /^[0-9]+([.]{1}[0-9]+){0,1}$/;
	return re.test(s)
}
/**
 * 选中父项时，同时选中子项
 * @param datas 所有的数据
 * @param row 当前数据
 * @param id id 字段名
 * @param pid 父id字段名
 */
function ckupdown(priority,id) {
	var mcheck = $("#ck"+id).prop("checked");
	var datas = $('#t_datagrid').bootstrapTable('getData');
	var target = new Array();
	var shangjitemp = priority;
	while(priority.indexof(".") > -1){
		shangjitemp = shangjitemp.substring(0,priority.lastIndexof("."));
		target.push(shangjitemp);
	}
	
	for(var i in datas){
		for(var j in target){
			if(datas[i]["priority"] == target[j]){
				$("#ck"+datas[i]["id"]).prop("checked",true);
			}
		}
		if(datas[i]["priority"].length > priority.length){
			if(datas[i]["priority"].substring(0,priority.length)== priority){
				$("#ck"+datas[i]["id"]).prop("checked",true);
			}
		}
	}
	
	/*
    for(var i in datas){
    	concole.log(datas[i][pid] + "::" + row[id] + "::" + (datas[i][pid] == row[id]));
        if(datas[i][pid] == row[id]){
            $("#ck"+datas[i][id]).prop("checked",true);
            selectChilds(datas,datas[i],id,pid,checked);
        };
    }
    */
}