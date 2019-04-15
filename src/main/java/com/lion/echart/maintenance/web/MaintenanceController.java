package com.lion.echart.maintenance.web;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lion.echart.base.logic.BaseService;
import com.lion.echart.maintenance.entity.MaintenanceEntity;
import com.lion.echart.system.entity.UserEntity;


import net.sf.json.JSONObject;

@Controller
public class MaintenanceController {

	@Autowired
	private BaseService baseService;
	//反馈填报列表页 
	@RequestMapping(value = "/maintenance/maintenanceList.web",method=RequestMethod.GET)
	public String maintenanceList(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "maintenance");
		return "/page/maintenance/maintenanceList";
	}
	
	//获取填报列表数据
		@RequestMapping(value = "/maintenance/maintenanceGetDBData.json",method=RequestMethod.POST)
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
		@RequestMapping(value = "/maintenance/maintenanceAdd.web",method=RequestMethod.GET)
		public String subofficeAdd(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
			req.setAttribute("ts", System.currentTimeMillis());
			req.setAttribute("who", "contract");
			return "/page/maintenance/maintenanceAdd";
		}
		
		//部门添加保存
		@RequestMapping(value = "/maintenance/maintenanceSave.json",method=RequestMethod.POST)
		public @ResponseBody String maintenanceSave(String entnyname,String priority,String unit,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
			
			JSONObject obj = new JSONObject();
			try {
				MaintenanceEntity maintenance = new MaintenanceEntity(0,priority,entnyname,"",0,"",unit);
				baseService.insertObject("comle.Maintenance.insertMaintenance",maintenance);
				obj.put("msgType", 1);
			} catch (Exception e) {
				e.printStackTrace();
				obj.put("msgType", 0);
			}
			return obj.toString();
		}
		
}
