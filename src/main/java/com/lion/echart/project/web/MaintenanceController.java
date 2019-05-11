package com.lion.echart.project.web;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.apache.commons.beanutils.BeanUtils;

import com.lion.echart.base.logic.BaseService;
import com.lion.echart.global.GlobalThings;
import com.lion.echart.project.entity.MaintenanceEntity;
import com.lion.echart.project.entity.MaintenancesView;
import com.lion.echart.system.entity.UserEntity;

import net.sf.json.JSONObject;

@Controller
public class MaintenanceController {

	@Autowired
	private BaseService baseService;

	//工程总进度权限分配
	@RequestMapping(value = "/maintenance/maintenancelPrem.web",method=RequestMethod.GET)
	public String maintenancelPrem(HttpServletRequest req,HttpServletResponse resp, HttpSession session , Model model,String maintenanceid) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "maintenance");		
		return "/page/project/maintenancelPrem";
	}

	//获取工程总进度权限分配数据
	@RequestMapping(value = "/maintenance/getMaintenancelPremData.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> getMaintenancelPremData(HttpServletRequest req,HttpServletResponse resp, HttpSession session , Model model,String maintenanceid) throws IOException { 
		List<Map<String, Object>> list = baseService.queryList("comle.Maintenance.getMaintenanceListData", null);
		return list;
	}
	
	//保持工程总表权限
	@RequestMapping(value = "/maintenance/insertPremData.json",method=RequestMethod.POST)
	public @ResponseBody String insertPremData(MaintenancesView list
			,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		JSONObject obj = new JSONObject();
		try {
			baseService.insertOupdates("comle.financing.financingWrite", list.getList());
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		return obj.toString();
	}
	
	//工程总进度列表
	@RequestMapping(value = "/project/maintenanceList.web",method=RequestMethod.GET)
	public String maintenanceList(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "maintenance");
		return "/page/project/maintenanceList";
	}
	
	//获取工程总进度树结构数据
	@RequestMapping(value = "/project/maintenanceGetDBTreeData.json",method=RequestMethod.POST)
	public @ResponseBody Map<String, List<Map<String, Object>>> maintenanceGetDBTreeData(String belongTimeStr,HttpServletRequest req,HttpServletResponse resp, 
			HttpSession session, String subofficeid) throws IOException {
		Map<String, List<Map<String, Object>>> result = new HashMap<String, List<Map<String, Object>>>();
		if(GlobalThings.getCash("maintenances")!= null) {
			//缓存中的结果集
			List<Map<String, Object>> list = (List<Map<String, Object>>)GlobalThings.getCash("maintenances");
			List<Map<String, Object>> temp = null;
			for (int i = 0; i < list.size(); i++) {
				if(result.get(list.get(i).get("perentid").toString()) != null) {
					temp = result.get(list.get(i).get("perentid").toString());
				}else {
					temp = new ArrayList<Map<String,Object>>();
				}
				temp.add(list.get(i));
				result.put(list.get(i).get("perentid").toString(), temp);
			
			}
		}
		return result;
	}
	
	//获取工程总进度数据
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
		//List<Map<String, Object>> list = baseService.queryList("comle.Maintenance.getMaintenanceListData", param);
		List<Map<String, Object>> list = (List<Map<String, Object>>) GlobalThings.getCash("maintenances");
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
			maintenance.setPerentid(maintenance.getMaintenanceid());
			maintenance.setMaintenanceid(null);
			JSONObject obj = new JSONObject();
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("maintenanceid", maintenance.getPerentid()); //获取上一级id，也就是当前选中
			Object tempobj = baseService.queryObject("comle.Maintenance.getMaintenanceListData", param); //获取上一级id下的对象
			
			Map<String, Object> parentobj = null; 
			if(tempobj != null) {
				parentobj = (Map<String, Object> )tempobj;
			}
			
			//SELECT MAX(t.index)+1 FROM t_f_maintenance t WHERE t.perentid = ?		
			long selfIndex = 1;
			tempobj = baseService.queryObject("comle.Maintenance.getSubMaxInxdexAo", param);
			if(tempobj != null) {
				selfIndex = new Integer(tempobj.toString()); //上一级的index位置	
			}
			//同级添加		
			String leftcode = "";
			long grade = 1;
			if(parentobj!=null) {
				leftcode = parentobj.get("codeno").toString();//最终code码
				grade = new Integer(parentobj.get("grade").toString())+1;
			}				
			while(leftcode.length() > 0 && 
					"000".equals(leftcode.substring(leftcode.length()-3, leftcode.length()))) {
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
			maintenance.setMaintenanceid((long)(100+Math.random()*(100000000-100+1)));
			maintenance.setPriority(leftpriority);
			maintenance.setGrade(grade);
			maintenance.setIndex(selfIndex);
			maintenance.setCodeno(leftcode);
			
	         //放入对象存入数据库			
			try {				
				System.out.println(maintenance);
				baseService.insertObject("comle.Maintenance.insertMaintenance",maintenance);
				//新增到缓存
				List<Map<String, Object>> list = (List<Map<String, Object>>) GlobalThings.getCash("maintenances");
				//list.add(BeanUtils.describe(maintenance));
				list.add(getmainMap(maintenance));
				GlobalThings.putCash("maintenances", list);
				obj.put("msgType", 1);
			} catch (Exception e) {
				e.printStackTrace();
				obj.put("msgType", 0);
			}
			return obj.toString();
		}
		
		//对象转换成map集合
		public Map<String,Object> getmainMap(MaintenanceEntity main) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException{
			Map<String, Object> mainMap = BeanUtils.describe(main); //new HashMap<String,Object>();
			mainMap.put("perentid",main.getPerentid());
			return mainMap;
		}
}
