package com.lion.echart.login.web;

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
import com.lion.echart.global.GlobalThings;
import com.lion.echart.system.entity.UserEntity;
import com.lion.echart.utils.ImageUtils;

import net.sf.json.JSONObject;

/**
 * 登陆相关后台请求
 * @author lion-y
 *
 */
@Controller
public class LoginController {
	@Autowired
	private BaseService baseService;
	
	//获取验证码 
	@RequestMapping(value = "/drawcheckcode.json",method=RequestMethod.POST)
	public void drawCheckCode(HttpServletResponse resp, HttpSession session) throws IOException { 
		//resp.setContentType("image/jpg"); 
		//int width = 70; int height = 25; 
		//OutputStream os = resp.getOutputStream();
		//int verifySize = 4;
		//ImageUtils.outputVerifyImage(width, height, os, verifySize);
		String ckcode = ImageUtils.generateVerifyCode(4);
		resp.getOutputStream().write(ckcode.getBytes());
	}
	@RequestMapping(value = "/",method=RequestMethod.GET)
	public String login_main(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException { 
		JSONObject jsonObject = new JSONObject();
		//先判断session中有没有用户信息
		if(session.getAttribute("USER_SESSION")!=null){
			//重定向到主页面的跳转方法
            return "/page/main";
		}else{
	        return "login";
		}
	}
	//登陆验证 
	@RequestMapping(value = "/login.json",method=RequestMethod.GET)
	public String login_get(String username,String password, HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException { 
		JSONObject jsonObject = new JSONObject();
		//先判断session中有没有用户信息
		if(session.getAttribute("USER_SESSION")!=null){
			//重定向到主页面的跳转方法
            return "/page/main";
		}else{
			//获取用户名和密码
			//从数据库中获取对用户名和密码后进行判断
			Map<String, Object> searchmap = new HashMap<String, Object>();
			searchmap.put("username", username);
			searchmap.put("password", password);
	    	UserEntity user = (UserEntity) baseService.queryObject("comle.user.getUserData", searchmap);
	        if(user!=null){
	            //将用户对象添加到Session中
	            session.setAttribute("USER_SESSION",user);
	            jsonObject.accumulate("msgType", 0);
	    		
	            List<HashMap<String, Object>> codetypes = baseService.queryList("com.system.code.getCodetypes", null);
	            String codetype = "";
	            for (int i = 0; i < codetypes.size(); i++) {
	            	codetype = codetypes.get(i).get("codetype").toString();
	            	if(GlobalThings.getCash(codetype) == null) {
	            		GlobalThings.putCash(codetype,new ArrayList<HashMap<String, Object>>());
	            	}
	            	((List<HashMap<String, Object>>)GlobalThings.getCash(codetype)).add(codetypes.get(i));
	            }
	    		GlobalThings.putCash("suboffices", baseService.queryList("comle.Suboffice.getSubofficeListData", null));
	    		GlobalThings.putCash("contracts", baseService.queryList("comle.contract.getcontractSignedListData", null));
	            //重定向到主页面的跳转方法
	            return "/page/main";
	        }else{
	        	System.out.println("密码");
	        	req.setAttribute("msg","用户名或密码错误，请重新登录！");
	        	return "login";
	        }
		}
	}

	//登陆验证 
	@RequestMapping(value = "/login.json",method=RequestMethod.POST)
	public String login(String username,String password, HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException { 
		JSONObject jsonObject = new JSONObject();
		//先判断session中有没有用户信息
		if(session.getAttribute("USER_SESSION")!=null){
			//重定向到主页面的跳转方法
            return "/page/main";
		}else{
			//获取用户名和密码
			//从数据库中获取对用户名和密码后进行判断
			Map<String, Object> searchmap = new HashMap<String, Object>();
			searchmap.put("username", username);
			searchmap.put("password", password);
	    	UserEntity user = (UserEntity) baseService.queryObject("comle.user.getUserData", searchmap);
	        if(user!=null){
	            //将用户对象添加到Session中
	            session.setAttribute("USER_SESSION",user);
	            jsonObject.accumulate("msgType", 0);
	    		GlobalThings.putCash("costtypes", baseService.queryList("com.system.code.getCodetypes", null));
	    		
	    		GlobalThings.putCash("suboffices", baseService.queryList("comle.Suboffice.getSubofficeListData", null));
	    		GlobalThings.putCash("contracts", baseService.queryList("comle.contract.getcontractSignedListData", null));
	    		maintenanceSetGlobalThings();
	    		req.removeAttribute("msg");
	            //重定向到主页面的跳转方法
	            return "/page/main";
	        }else{
	        	req.setAttribute("msg","用户名或密码错误，请重新登录！");
	        	return "login";
	        }
		}
	}
	
	/**
     * 向用户登录页面跳转
     */
    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public String toLogin(){
        return  "login";
    }
    /**
     * 退出登录
     * @param session
     * @return
     */
    @RequestMapping(value = "/logout")
    public String logout(HttpSession session){
        //清除session
        session.invalidate();
        //重定向到登录页面的跳转方法
        return "redirect:login";
    }
	
	/**
	 * 获取缓存数据
	 * @param resp
	 * @param cashtype
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/getCashListData.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> getCashListData(HttpServletResponse resp, String cashtype) throws IOException { 
		List<Map<String, Object>> result = new ArrayList<Map<String,Object>>();
		Object obj = GlobalThings.getCash(cashtype);
		if(obj != null) {
			result = (List<Map<String, Object>>)obj;
		}
		return result;
	}
	
	//缓存各种数据
	public void maintenanceSetGlobalThings() {
		//把工程总进度缓存到缓存中
		GlobalThings.putCash("maintenances",baseService.queryList("comle.Maintenance.getMaintenanceListData", null));
		//把部门数据放缓存中
		GlobalThings.putCash("subofficeList",baseService.queryList("comle.Suboffice.getSubofficeListDBData", null));
		
		System.out.println("成功缓存工程总进度！！");
	 
	}
}