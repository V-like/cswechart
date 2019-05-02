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

import com.lion.echart.Suboffice.entity.SubofficeWriteEntity;
import com.lion.echart.base.entity.Page;
import com.lion.echart.base.logic.BaseService;
import com.lion.echart.project.entity.MonthTotalEntity;
import com.lion.echart.project.entity.PayforEntity;
import com.lion.echart.system.entity.RoleEntity;
import com.lion.echart.system.entity.RoleMenuEntity;
import com.lion.echart.system.entity.UserEntity;
import com.lion.echart.system.entity.UserRoleEntity;

import net.sf.json.JSONObject;

/**
 * 角色信息相关跳转控制
 * @author TANGXIAN
 *
 */
@Controller
public class RoleController {
	@Autowired
	private BaseService baseService;
	//角色信息列表页 
	@RequestMapping(value = "/role/roleList.web",method=RequestMethod.GET)
	public String roleList(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		return "/page/system/roleList";
	}
	
	//角色信息列表数据
	@RequestMapping(value = "/role/roleGetData.json",method=RequestMethod.POST)
	public @ResponseBody Page roleGetData(String currPage, String pageSize, String rolename,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		currPage=currPage==null?"1":currPage;   //当前页码
	    pageSize=pageSize==null?"10":pageSize;   //页面大小
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("rolename", rolename);
		param.put("currPage", Integer.valueOf(currPage));
		param.put("pageSize", Integer.valueOf(pageSize));
		List<Map<String, Object>> list = baseService.queryList("comle.role.getRoleListDataByPage", param);
		//数据总条数
		List<Map<String, Object>> listAll = baseService.queryList("comle.role.getRoleListData", param);
		 //封装返回结果
        Page page = new Page();
        page.setTotal(listAll.size()+"");
        page.setRows(list);
		return page;
	}
	
	//角色信息添加列表页 
	@RequestMapping(value = "/role/roleAdd.web",method=RequestMethod.GET)
	public String roleAdd(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		return "/page/system/roleAdd";
	}
	
	//角色添加保存
	@RequestMapping(value = "/role/roleSave.json",method=RequestMethod.POST)
	public @ResponseBody String roleSave(String rolename,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		SimpleDateFormat si = new SimpleDateFormat("yyyy-MM-dd");
		JSONObject obj = new JSONObject();
		try {
			RoleEntity role = new RoleEntity(null,rolename, new Date(), "", 0, 1, "0", "1", new Date());
			baseService.insertObject("comle.role.insertRole", role);
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		return obj.toString();
	}
	
	//角色信息修改列表页 
	@RequestMapping(value = "/role/roleEdit.web",method=RequestMethod.GET)
	public String roleEdit(String roleid,HttpServletRequest req,HttpServletResponse resp, HttpSession session,Model model) throws IOException { 
		Map<String, Object> searchmap = new HashMap<String, Object>();
		searchmap.put("roleid", roleid);
		RoleEntity role = (RoleEntity)baseService.queryObject("comle.role.getRoleData", searchmap);
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		model.addAttribute("role", role);
		return "/page/system/roleEdit";
	}
	
	//角色修改保存
	@RequestMapping(value = "/role/roleEditSave.json",method=RequestMethod.POST)
	public @ResponseBody String roleEditSave(String roleid,String rolename,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		SimpleDateFormat si = new SimpleDateFormat("yyyy-MM-dd");
		JSONObject obj = new JSONObject();
		try {
			RoleEntity role = new RoleEntity(Long.valueOf(roleid),rolename, new Date(), "", 0, 1, "0", "1", new Date());
			baseService.updateObject("comle.role.updateRole", role);
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		return obj.toString();
	}
	
	//角色菜单分配列表页 
	@RequestMapping(value = "/role/roleMenuAssign.web",method=RequestMethod.GET)
	public String roleMenuAssign(String roleid,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		Map<String, Object> searchmap = new HashMap<String, Object>();
		searchmap.put("roleid", roleid);
		
		//获得菜单
		List<Map<String, Object>> list = baseService.queryList("comle.role.getRoleMenuListData", searchmap);
		String menuListStr = "";
		for(Map<String, Object> map : list){
			menuListStr+=map.get("menuid")+","; 
		}
		if(list.size()>0){
			menuListStr=menuListStr.substring(0,menuListStr.length()-1);
		}
		
		//获得用户
		List<Map<String, Object>> list2 = baseService.queryList("comle.user.getUserRoleListData",searchmap);
		String userListStr = "";
		for(Map<String, Object> map : list2){
			userListStr+=map.get("userid")+","; 
		}
		if(list2.size()>0){
			userListStr=userListStr.substring(0,userListStr.length()-1);
		}
		
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		req.setAttribute("roleid", roleid);
		req.setAttribute("menuListStr", menuListStr);
		req.setAttribute("userListStr", userListStr);
		return "/page/system/roleMenuAssign";
	}
	//用户角色分配添加保存
	@RequestMapping(value = "/role/roleMenuSave.json",method=RequestMethod.POST)
	public @ResponseBody String userRoleSave(String roleid,String menuidArrStr,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		SimpleDateFormat si = new SimpleDateFormat("yyyy-MM-dd");
		JSONObject obj = new JSONObject();
		try {
			//先删除用户角色表，然后添加
			//del
			Map<String, Object> delmap = new HashMap<String, Object>();
			delmap.put("roleid", roleid);
			baseService.delete("comle.role.deleteRoleMenu", delmap);
			//insert
			String menuidArr[] = menuidArrStr.split(",");
			for(String menuid : menuidArr){
				RoleMenuEntity roleMenu = new RoleMenuEntity(Long.valueOf(roleid), Long.valueOf(menuid));
				baseService.insertObject("comle.role.insertRoleMenu", roleMenu);
			}
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		return obj.toString();
	}
	//删除角色
	@RequestMapping(value = "role/roleDel.json",method=RequestMethod.POST)
	public void roleDel(String checkIds
			,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		JSONObject obj = new JSONObject();
		try {
			HashMap<String, Object> paramUpdate = new HashMap<String, Object>();
			List<Integer> idList = new ArrayList<Integer>();
			for(String s : checkIds.split(",")){
				idList.add(Integer.valueOf(s));
			}
			paramUpdate.put("idList", idList);
			baseService.updateObject("comle.role.deleteRole", paramUpdate);
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