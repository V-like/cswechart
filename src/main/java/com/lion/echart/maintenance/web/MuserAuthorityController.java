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
import com.lion.echart.system.entity.UserEntity;

import net.sf.json.JSONObject;


@Controller
public class MuserAuthorityController {

	@Autowired
	private BaseService baseService;
	
	
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
			
			
			
			//添加权限
			@RequestMapping(value = "/muserauthority/muserauthoritySave.json",method=RequestMethod.POST)
			public @ResponseBody String maintenanceSave(@RequestBody String data,HttpServletRequest req,HttpServletResponse resp, 
					HttpSession session, String subofficeid) throws IOException { 
				JSONObject obj = new JSONObject();
				String[] datas= data.split("&");
				MuserAuthorityEntity muserAuthority=new MuserAuthorityEntity();
				HashMap<String, Object> param = new HashMap<String, Object>();
				for(int i=0;i<datas.length;i++) {
					if("authority".equals(datas[i].split("=")[0])){
						System.out.println(datas[i].split("=")[1]);
						muserAuthority.setAuthority(datas[i].split("=")[1]);
						param.put("authority", datas[i].split("=")[1]);
					}
					if("mid".equals(datas[i].split("=")[0])){
						muserAuthority.setMid(datas[i].split("=")[1]);
						param.put("mid", datas[i].split("=")[1]);
					}
					if("uid".equals(datas[i].split("=")[0])){
						muserAuthority.setUid(datas[i].split("=")[1].split("-")[1]);
						param.put("uid", datas[i].split("=")[1].split("-")[1]);
					}
				}
				try {
					List<Map<String, Object>> list =baseService.queryList("comle.muserauthority.getmuserauthoritySelectById", param);
					if(list.size()==0) {
						baseService.insertObject("comle.muserauthority.muserauthoritySave", muserAuthority);
					}else {
						baseService.updateObject("comle.muserauthority.updateMuserauthority", muserAuthority);
					}
					obj.put("msgType", 1);
				} catch (Exception e) {
					e.printStackTrace();
					obj.put("msgType", 0);
				}
				return obj.toString();
			}
}
