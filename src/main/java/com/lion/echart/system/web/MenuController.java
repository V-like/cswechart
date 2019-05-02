package com.lion.echart.system.web;

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

import com.lion.echart.base.entity.Page;
import com.lion.echart.base.logic.BaseService;
import com.lion.echart.system.entity.MenuEntity;
import com.lion.echart.system.entity.UserEntity;

import net.sf.json.JSONObject;

/**
 * 菜单信息相关跳转控制
 * @author TANGXIAN
 *
 */
@Controller
public class MenuController {
	@Autowired
	private BaseService baseService;
	//菜单信息列表页 
	@RequestMapping(value = "/menu/menuList.web",method=RequestMethod.GET)
	public String menuList(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		return "/page/system/menuList";
	}
	
	//菜单信息列表数据
	@RequestMapping(value = "/menu/menuGetData.json",method=RequestMethod.POST)
	public @ResponseBody Page menuGetData(String currPage, String pageSize, String menuname,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		currPage=currPage==null?"1":currPage;   //当前页码
	    pageSize=pageSize==null?"40":pageSize;   //页面大小
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("menuname", menuname);
		param.put("currPage", Integer.valueOf(currPage));
		param.put("pageSize", Integer.valueOf(pageSize));
		List<Map<String, Object>> list = baseService.queryList("comle.menu.getMenuListDataByPage", param);
		//数据总条数
		List<Map<String, Object>> listAll = baseService.queryList("comle.menu.getMenuListData", param);
		 //封装返回结果
        Page page = new Page();
        page.setTotal(listAll.size()+"");
        page.setRows(list);
		return page;
	}
	//父级菜单信息列表数据
	@RequestMapping(value = "/menu/menuParentGetData.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> menuParentGetData(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		List<Map<String, Object>> list = baseService.queryList("comle.menu.getMenuParentListData", null);
		return list;
	}
	//菜单信息添加列表页 
	@RequestMapping(value = "/menu/menuAdd.web",method=RequestMethod.GET)
	public String menuAdd(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		return "/page/system/menuAdd";
	}
	
	//菜单添加保存
	@RequestMapping(value = "/menu/menuSave.json",method=RequestMethod.POST)
	public @ResponseBody String menuSave(String menuname,String url,Integer ismenu,Long pid,Integer priority,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		SimpleDateFormat si = new SimpleDateFormat("yyyy-MM-dd");
		JSONObject obj = new JSONObject();
		try {
			if(ismenu==1){
				pid=(long) 0;
			}
			MenuEntity menu = new MenuEntity(null,menuname, url, ismenu, pid, new Date(), "", priority, 1, "0", "1", new Date());
			baseService.insertObject("comle.menu.insertMenu", menu);
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		return obj.toString();
	}
	//菜单信息修改列表页 
	@RequestMapping(value = "/menu/menuEdit.web",method=RequestMethod.GET)
	public String menuEdit(String menuid,HttpServletRequest req,HttpServletResponse resp, HttpSession session,Model model) throws IOException { 
		Map<String, Object> searchmap = new HashMap<String, Object>();
		searchmap.put("menuid", menuid);
		MenuEntity menu = (MenuEntity)baseService.queryObject("comle.menu.getMenuData", searchmap);
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		model.addAttribute("menu", menu);
		return "/page/system/menuEdit";
	}
	//菜单修改保存
	@RequestMapping(value = "/menu/menuEditSave.json",method=RequestMethod.POST)
	public @ResponseBody String menuEditSave(String roleid,String menuname,String url,Integer ismenu,Long pid,Integer priority,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		SimpleDateFormat si = new SimpleDateFormat("yyyy-MM-dd");
		JSONObject obj = new JSONObject();
		try {
			if(ismenu==1){
				pid=(long) 0;
			}
			MenuEntity menu = new MenuEntity(Long.valueOf(roleid),menuname, url, ismenu, pid, new Date(), "", priority, 1, "0", "1", new Date());
			baseService.insertObject("comle.menu.updateMenu", menu);
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		return obj.toString();
	}
	//通过userid菜单信息列表数据
	@RequestMapping(value = "/menu/menuGetDataByUserId.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> menuGetDataByUserId(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		String userid = "";
		UserEntity user = (UserEntity)req.getSession().getAttribute("USER_SESSION");
		userid = user.getId()+"";
		Map<String, Object> searchmap = new HashMap<String, Object>();
		if(!"1".equals(userid))
			searchmap.put("userid", userid);
		
		List<Map<String, Object>> list = null;
		if(req.getSession().getAttribute("USER_MENU") != null) {
			list = (List<Map<String, Object>>)req.getSession().getAttribute("USER_MENU");
		}else {
			list = baseService.queryList("comle.menu.getMenuListDataByUserId", searchmap);
			req.getSession().setAttribute("USER_MENU",list);
		}
		return list;
	}
	//删除菜单
	@RequestMapping(value = "menu/menuDel.json",method=RequestMethod.POST)
	public void menuDel(String checkIds
			,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		JSONObject obj = new JSONObject();
		try {
			HashMap<String, Object> paramUpdate = new HashMap<String, Object>();
			List<Integer> idList = new ArrayList<Integer>();
			for(String s : checkIds.split(",")){
				idList.add(Integer.valueOf(s));
			}
			paramUpdate.put("idList", idList);
			baseService.updateObject("comle.menu.deleteMenu", paramUpdate);
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		resp.setContentType("text/html;charset=UTF-8");
		resp.getWriter().print(obj.toString());
		//return obj.toString();
	}
}