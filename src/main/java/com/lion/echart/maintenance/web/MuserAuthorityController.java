package com.lion.echart.maintenance.web;



import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lion.echart.base.logic.BaseService;
import com.lion.echart.maintenance.entity.MuserAuthorityEntity;
import com.lion.echart.maintenance.logic.MuserAuthorityService;
import com.lion.echart.system.entity.UserEntity;

import net.sf.json.JSONObject;


@Controller
public class MuserAuthorityController {

	@Autowired
	private BaseService baseService;

	@Autowired
	private MuserAuthorityService muserAuthorityService;
	
	//获取用户数据
	@RequestMapping(value = "/muserauthority/muserauthorityData.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> maintenanceGetData(@RequestBody String id,HttpServletRequest req,HttpServletResponse resp, 
			HttpSession session, String subofficeid) throws IOException { 
		UserEntity user = (UserEntity)session.getAttribute("USER_SESSION");
		HashMap<String, Object> param = new HashMap<String, Object>();
		//系统管理员传入特殊分局条件
		if("admin".equals(user.getUsername())) {
			param.put("subofficeid", 0);
		}else {
			param.put("subofficeid", user.getSubofficeid());
		}
		param.put("mid", id.split("=")[1]);
		List<Map<String, Object>> list = baseService.queryList("comle.muserauthority.getMuserauthorityData", param);
		return list;
	}
	
	//获取该列管理者数据
	@RequestMapping(value = "/muserauthority/muserauthorityData2.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> maintenanceData(@RequestBody String id,HttpServletRequest req,HttpServletResponse resp, 
			HttpSession session, String subofficeid) throws IOException { 
		UserEntity user = (UserEntity)session.getAttribute("USER_SESSION");
		HashMap<String, Object> param = new HashMap<String, Object>();
		//系统管理员传入特殊分局条件
		if("admin".equals(user.getUsername())) {
			param.put("subofficeid", 0);
		}else {
			param.put("subofficeid", user.getSubofficeid());
		}
		param.put("mid", id.split("=")[1]);				
		List<Map<String, Object>> list = baseService.queryList("comle.muserauthority.getMuserauthorityData3", param);
		return list;
	}

	//权限列表获取选择数据
	@RequestMapping(value = "/muserauthority/muserauthorityList.json",method=RequestMethod.POST)
	public @ResponseBody String muserauthorityList(HttpServletRequest req,HttpServletResponse resp, 
			HttpSession session, String leftid) throws IOException { 
		HashMap<String, Object> param = new HashMap<String, Object>();
		//系统管理员传入特殊分局条件
		List<Map<String, Object>> list = null;
		JSONObject obj = new JSONObject();
		if(leftid != null && !leftid.isEmpty()) {
			param.put("mid", leftid);
			list = baseService.queryList("comle.muserauthority.getMuserauthorityList", param);
			String caozqxs = "";
			String chakqxs = "";
			for (int i = 0; i < list.size(); i++) {
				if(list.get(i).get("authority") != null && 
						"1".equals(list.get(i).get("authority").toString())) {
					caozqxs = caozqxs + ","+list.get(i).get("depid")+",";
				}else {
					chakqxs = chakqxs + ","+list.get(i).get("depid")+",";
				}
			}
			obj.element("caozqxs", caozqxs);
			obj.element("chakqxs", chakqxs);
		}
		return obj.toString();
	}
	
	//添加权限
	@RequestMapping(value = "/muserauthority/muserauthoritySave.json",method=RequestMethod.POST)
	public @ResponseBody String maintenanceSave(HttpServletRequest req,HttpServletResponse resp, 
			HttpSession session, Long leftid, String caozstrs, String chakstrs) throws IOException { 
		JSONObject obj = new JSONObject();
		
		//入库对象
		ArrayList<MuserAuthorityEntity> listobj = new ArrayList<MuserAuthorityEntity>();
		//分割临时字符串
		String[] datas = null;
		//临时单个对象
		MuserAuthorityEntity muserAuthority = null;
		if(!caozstrs.isEmpty()) {
			caozstrs = caozstrs.substring(1,caozstrs.length()-1);
			if(caozstrs.indexOf(",,") != -1) {
				datas = caozstrs.split(",,");
			}else {
				datas = new String[1];
				datas[0] = caozstrs;
			}
			for (int i = 0; i < datas.length; i++) {
				if(datas[i] != null && !"null".equals(datas[i])) {
					muserAuthority = new MuserAuthorityEntity();
					muserAuthority.setMid(leftid);
					muserAuthority.setAuthority("1");
					muserAuthority.setDepid(new Long(datas[i]));
					listobj.add(muserAuthority);
				}
			}
		}
		if(!chakstrs.isEmpty()) {
			chakstrs = chakstrs.substring(1,chakstrs.length()-1);
			if(chakstrs.indexOf(",,") != -1) {
				datas = chakstrs.split(",,");
			}else {
				datas = new String[1];
				datas[0] = chakstrs;
			}
			for (int i = 0; i < datas.length; i++) {
				if(datas[i] != null && !"null".equals(datas[i])) {
					muserAuthority = new MuserAuthorityEntity();
					muserAuthority.setMid(leftid);
					muserAuthority.setAuthority("0");
					muserAuthority.setDepid(new Long(datas[i]));
					listobj.add(muserAuthority);
				}
			}
		}
		
		try {
			muserAuthorityService.saveMuserList(listobj, leftid);
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		return obj.toString();
	}
}
