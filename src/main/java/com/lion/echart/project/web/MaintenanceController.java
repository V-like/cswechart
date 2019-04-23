package com.lion.echart.project.web;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lion.echart.base.logic.BaseService;
import com.lion.echart.project.entity.MaintenanceEntity;
import com.lion.echart.system.entity.UserEntity;


import net.sf.json.JSONObject;

@Controller
public class MaintenanceController {

	@Autowired
	private BaseService baseService;
	//反馈填报列表页 
	@RequestMapping(value = "/project/maintenanceList.web",method=RequestMethod.GET)
	public String maintenanceList(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "maintenance");
		return "/page/project/maintenanceList";
	}
	
	//获取填报列表数据
		@RequestMapping(value = "/project/maintenanceGetDBData.json",method=RequestMethod.POST)
		public @ResponseBody List<Map<String, Object>> maintenanceGetData(String belongTimeStr,HttpServletRequest req,HttpServletResponse resp, 
				HttpSession session, String subofficeid) throws IOException { 
			UserEntity user = (UserEntity)session.getAttribute("USER_SESSION");
			HashMap<String, Object> param = new HashMap<String, Object>();
			List<Integer> ststusList = new ArrayList<Integer>();
			ststusList.add(1);
			ststusList.add(4);
			param.put("status", ststusList);
			param.put("type", 2);
			if(belongTimeStr!=null&&!belongTimeStr.equals("")){
				param.put("year", belongTimeStr.substring(0,4));
				param.put("month", belongTimeStr.substring(5,7));
			}
			//系统管理员传入特殊分局条件
			if("admin".equals(user.getUsername())) {
				param.put("subofficeid", 0);
			}else {
				param.put("subofficeid", user.getSubofficeid());
			}
			List<Map<String, Object>> list = baseService.queryList("comle.Maintenance.getMaintenanceListData", param);
			return list;
		}
		
		
		//部门信息添加列表页 
		@RequestMapping(value = "/project/maintenanceAdd.web",method=RequestMethod.GET)
		public String subofficeAdd(HttpServletRequest req,HttpServletResponse resp, HttpSession session , Model model,String maintenanceid) throws IOException { 
			req.setAttribute("ts", System.currentTimeMillis());
			req.setAttribute("who", "contract");
			model.addAttribute("maintenanceid", maintenanceid);
			return "/page/project/maintenanceAdd";
		}
		
		
		//部门添加保存
		@RequestMapping(value = "/project/maintenanceSave.json",method=RequestMethod.POST)
		public @ResponseBody String maintenanceSave(MaintenanceEntity maintenance,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 			
			JSONObject obj = new JSONObject();
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("maintenanceid", maintenance.getMaintenanceid()); //获取上一级id，也就是当前选中
			Object tempobj = baseService.queryObject("comle.Maintenance.getMaintenanceListData", param); //获取上一级id下的对象
			
			Map<String, Object> parentobj = null; 
			if(tempobj != null) {
				
				parentobj = (Map<String, Object> )tempobj;
			}
			
			//SELECT MAX(t.index)+1 FROM t_f_maintenance t WHERE t.perentid = ?		
			long selfIndex = 0;
			if(baseService.queryObject("comle.Maintenance.getSubMaxInxdexAo", param).toString()==null) {
				selfIndex = 1;
			}else {	
				selfIndex = new Integer( baseService.queryObject("comle.Maintenance.getSubMaxInxdexAo", param).toString()); //上一级的index位置	
			}
			//同级添加		
			String leftcode = "000000000000000000";
			if(parentobj!=null) {
				leftcode = parentobj.get("codeno").toString();//最终code码
			}				
			while("000".equals(leftcode.substring(leftcode.length()-3, leftcode.length()))) {
				leftcode = leftcode.substring(0,leftcode.length()-3);
			}
			
			String leftindex="1";
			//添加的时候将选中的code码的例如001 000000000000000变成002 000000000000000
			leftindex = ""+selfIndex;
			while(leftindex.length()<3){
				leftindex='0'+leftindex;
			}
			leftcode = leftcode+leftindex;
			while(leftcode.length()<18){
				leftcode=leftcode+'0';
			}
			String[] strs = new String[6];
			for (int i = 0; i < strs.length; i++) {
				strs[i] = leftcode.substring(i*3,(i+1)*3);
			}
			//将code码002 000000000000000再转换成最终带点.的序号
			String leftpriority = "";  //最终层级序号
			for (int i = 0; i < strs.length; i++) {
				if(!strs[i].equals("000")) {
					leftpriority = leftpriority + Integer.parseInt(strs[i]) + ".";
				}
			}				
			leftpriority = leftpriority.substring(0,leftpriority.length()-1);
			//层级
			String selfGrade = null;
			if(baseService.queryObject("comle.Maintenance.getSubMaxGradeAo", param).toString()==null) {
				selfGrade = "1";
			}else {
				selfGrade = baseService.queryObject("comle.Maintenance.getSubMaxGradeAo", param).toString(); //上一级的index位置	
			}
			
			MaintenanceEntity maintenances = new MaintenanceEntity(leftpriority,"",selfGrade,maintenance.getMaintenanceid(),selfIndex,leftcode,"",new Date(),new Date(),0);//增加	
			
			System.out.println(maintenances.toString());
	         //放入对象存入数据库			
			try {				
				baseService.insertObject("comle.Maintenance.insertMaintenance",maintenances);
				obj.put("msgType", 1);
			} catch (Exception e) {
				e.printStackTrace();
				obj.put("msgType", 0);
			}
			return obj.toString();
		}		
}
