package com.lion.echart.project.web;

import java.io.IOException;
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
import com.lion.echart.global.GlobalThings;

/**
 * 工作面展示
 * @author 乾蓝神
 *
 */
@Controller
public class WorkingfaceController {
	@Autowired
	private BaseService baseService;
	
	
	//工程日进度报表表页
	@RequestMapping(value = "/project/workingfaveList.web",method=RequestMethod.GET)
	public String DayScheduLeist(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		return "/page/project/workingfaceList";
	}
	
	//获取一级分局
	@RequestMapping(value = "/project/stairsubofficeGet.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> subofficewriteGetData(String grade,String perentid,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		System.out.println("grade======="+grade);
		System.out.println("perentid======="+perentid);
		System.out.println("");
		HashMap<String, Object> param = new HashMap<String, Object>();
		if(grade != null) {
			param.put("grade",grade);
		}
		if(perentid != null) {
			param.put("perentid",perentid);
		}
		List<Map<String, Object>> list = baseService.queryList("getstairsubofficeGet",param);
		return list;
	}
	
	//查询指定三级下的三级四级数据
	@RequestMapping(value = "/project/findByperentidon3on4.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> aa(String perentid,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		System.out.println("perentid======="+perentid);
		System.out.println("");
		if(perentid == null) {
			return null;
		}
		HashMap<String, Object> param = new HashMap<String, Object>();
//		if(grade != null) {
//			param.put("grade",grade);
//		}
		
		param.put("perentid",perentid);
		
		List<Map<String, Object>> list = baseService.queryList("findByperentidon3on4",param);
		System.out.println(list);
		return list;
	}
	
	
}
