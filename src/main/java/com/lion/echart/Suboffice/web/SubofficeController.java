package com.lion.echart.Suboffice.web;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lion.echart.Suboffice.entity.SubofficeEntity;
import com.lion.echart.base.entity.Page;
import com.lion.echart.base.logic.BaseService;
import com.lion.echart.global.GlobalThings;
import com.lion.echart.project.entity.MaintenanceEntity;
import com.lion.echart.system.entity.UserEntity;

import net.sf.json.JSONObject;

/**
 * 分局信息相关跳转控制
 * @author TANGXIAN
 *
 */
@Controller
public class SubofficeController {
	@Autowired
	private BaseService baseService;
	//分局信息列表页 
	@RequestMapping(value = "/suboffice/subofficeList.web",method=RequestMethod.GET)
	public String subofficeList(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		return "/page/suboffice/subofficeList";
	}
	
	//获取分局列表数据数据库
	@RequestMapping(value = "/suboffice/subofficeGetDBData.json",method=RequestMethod.POST)
	public @ResponseBody Page subofficewriteGetDBData(String currPage, String pageSize,String subofficename,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		//currPage=currPage==null?"1":currPage;   //当前页码
	    //pageSize=pageSize==null?"10":pageSize;   //页面大小
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("subofficename", subofficename);
		//param.put("currPage", Integer.valueOf(currPage));
		//param.put("pageSize", Integer.valueOf(pageSize));
		//List<Map<String, Object>> list = baseService.queryList("comle.Suboffice.getSubofficeListDBDataByPage", param);
		//数据总条数
		List<Map<String, Object>> listAll = null;
		if(subofficename == null || subofficename=="") {
			listAll = (List<Map<String, Object>>)GlobalThings.getCash("subofficeList");
			System.out.println("大集合大集合"+listAll);
		}else {
			listAll = baseService.queryList("comle.Suboffice.getSubofficeListDBData", param);
		}
		
		 //封装返回结果
        Page page = new Page();
        //page.setTotal(listAll.size()+"");
        page.setRows(listAll);
		return page;
	}
	
	//获取分局列表数据
	@RequestMapping(value = "/suboffice/subofficeGetData.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> subofficewriteGetData(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		List<Map<String, Object>> list = (List<Map<String, Object>>)GlobalThings.getCash("suboffices");
		return list;
	}
	
	//获取权限设置部门树结构数据
	@RequestMapping(value = "/suboffice/getDepartTreeData.json",method=RequestMethod.POST)
	public @ResponseBody Map<String, List<Map<String, Object>>> getDepartTreeData(HttpServletRequest req,
			HttpServletResponse resp,HttpSession session) throws IOException {
		Map<String, List<Map<String, Object>>> result = new HashMap<String, List<Map<String,Object>>>();
		if(GlobalThings.getCash("subofficeList")!= null) {
			//查询结果
			List<Map<String, Object>> list = (List<Map<String, Object>>)GlobalThings.getCash("subofficeList");
			//父id归类
			//临时对象
			List<Map<String, Object>> temp = null;
			for (int i = 0; i < list.size(); i++) {
				
				if(result.get(list.get(i).get("pid").toString()) != null) {
					temp = result.get(list.get(i).get("pid").toString());
				}else {
					temp = new ArrayList<Map<String,Object>>();
				}
				temp.add(list.get(i));
				result.put(list.get(i).get("pid").toString(), temp);
			
			}
		}
		
		return result;
	}
	
	//获取登录用户的分局列表数据
	@RequestMapping(value = "/suboffice/mysubofficeGetData.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> mysubofficeGetData(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		UserEntity user = (UserEntity)session.getAttribute("USER_SESSION");

		List<Map<String, Object>> restuleList = null;
		List<Map<String, Object>> templist = (List<Map<String, Object>>)GlobalThings.getCash("suboffices");
		if(templist!=null) {
			for (int i = templist.size()-1; i >= 0; i--) {
				if(user.getUsername().equals("admin")) {
					restuleList = (List<Map<String, Object>>)GlobalThings.getCash("suboffices");
				}else if(user.getSubofficeid() == null)  {
					break;
				}else if(Integer.parseInt(templist.get(i).get("subofficeid").toString()) == user.getSubofficeid()) {
					restuleList = new ArrayList<Map<String,Object>>();
					restuleList.add(templist.get(i));
					break;
				}
			}			
		}
		
		return restuleList;
	}
	//部门信息添加列表页 
	@RequestMapping(value = "/suboffice/subofficeAdd.web",method=RequestMethod.GET)
	public String subofficeAdd(String subofficeid,HttpServletRequest req,HttpServletResponse resp, HttpSession session,Model model) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		if(subofficeid != null) {
			Map<String, Object> searchmap = new HashMap<String, Object>();
			searchmap.put("subofficeid", subofficeid);
			SubofficeEntity suboffice = (SubofficeEntity)baseService.queryObject("comle.Suboffice.getSubofficeLBysubid", searchmap);
			//req.getSession().setAttribute("suboffice", suboffice);
			model.addAttribute("suboffice", suboffice);
		}
		return "/page/suboffice/subofficeAdd";
	}
	
	//部门添加保存
	@RequestMapping(value = "/suboffice/subofficeSave.json",method=RequestMethod.POST)
	public @ResponseBody String subofficeSave(String subofficeid,String subofficename,String pid,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		SimpleDateFormat si = new SimpleDateFormat("yyyy-MM-dd");
		JSONObject obj = new JSONObject();
		try {

			if(subofficeid!=null && subofficeid!="") {

				SubofficeEntity suboffice = new SubofficeEntity(Long.parseLong(subofficeid),Long.parseLong(pid), subofficename, "", 0, "", "", "", new Date());
				System.out.println("====================================="+suboffice);
				baseService.updateObject("comle.Suboffice.updateSuboffice", suboffice);
			}else {
				SubofficeEntity suboffice = new SubofficeEntity(0L,Long.parseLong(pid), subofficename, "", 0, "", "", "", new Date());
				System.out.println("====================================="+suboffice);
				baseService.insertObject("comle.Suboffice.insertSuboffice", suboffice);
				//修改缓存中数据
				List<Map<String,Object>> subList = (List<Map<String,Object>>)GlobalThings.getCash("subofficeList");
				subList.add(getsubMap(suboffice));
				System.out.println("集合集合集合"+subList);
				GlobalThings.putCash("suboffices", subList);
			}
		
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		return obj.toString();
	}
	
	//部门信息修改列表页 
	@RequestMapping(value = "/suboffice/subofficeEdit.web",method=RequestMethod.GET)
	public String subofficeEdit(String subofficeid,HttpServletRequest req,HttpServletResponse resp, HttpSession session,Model model) throws IOException { 
		Map<String, Object> searchmap = new HashMap<String, Object>();
		searchmap.put("subofficeid", subofficeid);
		SubofficeEntity suboffice = (SubofficeEntity)baseService.queryObject("comle.Suboffice.getSubofficeData", searchmap);
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		model.addAttribute("suboffice", suboffice);
		return "/page/suboffice/subofficeEdit";
	}
	
	//部门修改保存
	@RequestMapping(value = "/suboffice/subofficeEditSave.json",method=RequestMethod.POST)
	public @ResponseBody String subofficeEditSave(String subofficeid,String subofficename,String isonlysubo,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		SimpleDateFormat si = new SimpleDateFormat("yyyy-MM-dd");
		JSONObject obj = new JSONObject();
		try {
			SubofficeEntity suboffice = new SubofficeEntity(Long.valueOf(subofficeid),subofficename, "", 0,isonlysubo,"0", "1", new Date());
			baseService.updateObject("comle.Suboffice.updateSuboffice", suboffice);
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		return obj.toString();
	}
	//删除部门
	@RequestMapping(value = "suboffice/subofficeDel.json",method=RequestMethod.POST)
	public void subofficeDel(String checkIds
			,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		JSONObject obj = new JSONObject();
		try {
			HashMap<String, Object> paramUpdate = new HashMap<String, Object>();
			List<Integer> idList = new ArrayList<Integer>();
			for(String s : checkIds.split(",")){
				idList.add(Integer.valueOf(s));
			}
			paramUpdate.put("idList", idList);
			baseService.updateObject("comle.Suboffice.deleteSuboffice", paramUpdate);
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		resp.setContentType("text/html;charset=UTF-8");
		resp.getWriter().print(obj.toString());
		//return obj.toString();
	}
	
	//查询部门所有数据
	@RequestMapping(value = "/suboffice/subofficeGetDataAll.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> subofficeGetDataAll(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		List<Map<String, Object>> list = baseService.queryList("comle.Suboffice.getSubofficeTreeData", null);;
		return list;
	}
	
	//对象转换成map集合
	public Map<String,Object> getsubMap(SubofficeEntity sub) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException{
		Map<String, Object> subMap = BeanUtils.describe(sub); //new HashMap<String,Object>();
		subMap.put("pid",sub.getPid());
		return subMap;
	}
	
	
}