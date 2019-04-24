package com.lion.echart.project.web;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lion.echart.base.logic.BaseService;
import com.lion.echart.project.entity.DaystatementEntity;
import com.lion.echart.system.entity.UserEntity;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 工程日进度报表
 * @author 乾蓝神
 *
 */
@Controller
public class DaystatementController {
	@Autowired
	private BaseService baseService;
	
	//工程日进度报表表页
	@RequestMapping(value = "/project/DayScheduLeist.web",method=RequestMethod.GET)
	public String DayScheduLeist(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		return "/page/project/DayScheduLeist";
	}
	
	//获取工进度报表
	@RequestMapping(value = "/project/getdaystatementListData.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> subofficewriteMonthGetData(String belongTimeStr,HttpServletRequest req,HttpServletResponse resp, 
			HttpSession session, String subofficeid) throws IOException { 
		
		UserEntity user = (UserEntity)session.getAttribute("USER_SESSION");
		HashMap<String, Object> param = new HashMap<String, Object>();	
		if(belongTimeStr!=null&&!belongTimeStr.equals("")){
			Integer year = Integer.parseInt(belongTimeStr.substring(0,4));
			Integer month = Integer.parseInt(belongTimeStr.substring(5,7));
			Integer day = Integer.parseInt(belongTimeStr.substring(8,10));
			if(day>25) {
				if(month==12) {
					month=1;
					year+=1;
				}else {
					month+=1;
				}
			}
			String m = ""+month;
			if(m.length()==1) {
				m= "0"+m;
			}
			System.out.println("year==="+year);
			System.out.println("month==="+month);
			System.out.println("day==="+day);
			param.put("date", ""+year+"-"+m);
			param.put("day", day+"");	
		}
		List<Map<String, Object>> list = list = baseService.queryList("comle.daystatement.getdaystatementListData", param);
		return list;
	}
	
	//保存工程日报
//	@RequestMapping(value = "/project/getdaystatementListData.json",method=RequestMethod.POST)
//	public @ResponseBody String insertSubofficewriteTenDay(
//			/* @RequestParam("daystatementlist")List<Object> daystatementlist, */
//			@RequestParam("name")String name,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
//		UserEntity user = (UserEntity)session.getAttribute("USER_SESSION");
////		JSONObject obj = new JSONObject();
//		try {
//			System.out.println(name);
////			for(int i = 0;i < daystatementlist.size();i++){
////				System.out.println(daystatementlist.get(i));
////			}
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//
//		}
//		return null;
//	}
	//日报的新增与修改
	@RequestMapping(value = "/project/savedaystatementList.json",method=RequestMethod.POST )
	public @ResponseBody String insertSubofficewriteTenDay(String daystatementliststr,HttpServletRequest req,HttpServletResponse resp, HttpSession session) {
		UserEntity user = (UserEntity)session.getAttribute("USER_SESSION");
		JSONObject obj = new JSONObject();
		
		System.out.println(daystatementliststr);
		JSONArray jlist = JSONArray.fromObject(daystatementliststr);
		System.out.println(jlist);
		//DaystatementEntity entity = JSONObject.toBean(jlist.get(1), DaystatementEntity.class);
		
		try {
			List<DaystatementEntity> dlist = new ArrayList<DaystatementEntity>();
			for(int i = 0;i < jlist.size();i++){	
				DaystatementEntity entity = (DaystatementEntity) JSONObject.toBean((JSONObject) jlist.get(i), DaystatementEntity.class);
				System.out.println(entity);
				dlist.add(entity);
			}
			
			baseService.insertOupdates("comle.daystatement.daystatement", dlist);
			//baseService.updateObject("comle.monthschedule.accumulationcumulantUpdate", dlist);
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		
		return obj.toString();
	}
	
	
	
}
