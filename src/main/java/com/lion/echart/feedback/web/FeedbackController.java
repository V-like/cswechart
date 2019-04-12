package com.lion.echart.feedback.web;

import java.io.IOException;
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
import com.lion.echart.system.entity.UserEntity;



@Controller
public class FeedbackController {

	@Autowired
	private BaseService baseService;
	//反馈填报列表页 
	@RequestMapping(value = "/feedback/feedbackList.web",method=RequestMethod.GET)
	public String feedbackList(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "feedback");
		return "/page/feedback/feedbackList";
	}
	
	//获取填报列表数据
		@RequestMapping(value = "/feedback/feedbackGetDBData.json",method=RequestMethod.POST)
		public @ResponseBody List<Map<String, Object>> feedbackGetData(String belongTimeStr,HttpServletRequest req,HttpServletResponse resp, 
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
			List<Map<String, Object>> list = baseService.queryList("comle.Feedback.getFeedbackListData", param);
			return list;
		}
}
