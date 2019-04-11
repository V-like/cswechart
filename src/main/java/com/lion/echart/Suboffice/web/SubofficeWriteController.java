package com.lion.echart.Suboffice.web;

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

import com.lion.echart.Suboffice.entity.SubofficeWriteEntity;
import com.lion.echart.Suboffice.entity.SubofficeWriteView;
import com.lion.echart.base.logic.BaseService;
import com.lion.echart.financing.entity.FinancingWritesView;
import com.lion.echart.project.entity.MonthTotalEntity;
import com.lion.echart.project.entity.PayforEntity;
import com.lion.echart.system.entity.UserEntity;

import net.sf.json.JSONObject;

/**
 * 分局填报相关跳转控制
 * @author TANGXIAN
 *
 */
@Controller
public class SubofficeWriteController {
	@Autowired
	private BaseService baseService;
	//分局月填报列表页 
	@RequestMapping(value = "/subofficewrite/subofficewriteMonthList.web",method=RequestMethod.GET)
	public String subofficewriteMonthList(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		return "/page/suboffice/subofficeWriteMonthList";
	}
	
	//获取分局月填报列表数据
	@RequestMapping(value = "/subofficewrite/subofficewriteMonthGetData.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> subofficewriteMonthGetData(String belongTimeStr,HttpServletRequest req,HttpServletResponse resp, 
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
		//系统管理员传入特殊分局条件0
		if("admin".equals(user.getUsername())) {
			param.put("subofficeid", 0);
		}else {
			param.put("subofficeid", user.getSubofficeid());
		}
		List<Map<String, Object>> list = baseService.queryList("comle.SubofficeWrite.getSubofficewriteListData", param);
		return list;
	}
	
	//分局月填报保存
	@RequestMapping(value = "subofficewrite/insertSubofficewriteMonth.json",method=RequestMethod.POST)
	public @ResponseBody String insertSubofficewriteMonth(String belongTimeStr,SubofficeWriteView list
			,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		UserEntity user = (UserEntity)session.getAttribute("USER_SESSION");
		JSONObject obj = new JSONObject();
		try {
			for(SubofficeWriteEntity s :list.getList()){
				s.setPriority(0);
				if(belongTimeStr!=null&&!belongTimeStr.equals("")){
					s.setYear(belongTimeStr.substring(0,4));
					s.setMonth(belongTimeStr.substring(5,7));
				}
				if(s.getBegindate().equals("")){
					s.setBegindate("1970-01-01");
				}
				if(s.getPlanfinishdate().equals("")){
					s.setPlanfinishdate("1970-01-01");
				}
				if(s.getId()!= null&&s.getId()!=0){
					//修改
				}else{
					//现在默认状态已填报
					s.setStatus(1);
				}
				s.setType(2);
				s.setIsdisabled("0");
				s.setOperuser(user.getId()+"");
				s.setOperdate(new Date());
			}
			baseService.insertOupdates("comle.SubofficeWrite.subofficewrite", list.getList());
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		return obj.toString();
	}
	
	//分局填报提交
	@RequestMapping(value = "subofficewrite/submitSubofficewriteMonth.json",method=RequestMethod.POST)
	public void submitSubofficewriteMonth(String belongTimeStr, String checkIds,SubofficeWriteView list
			,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException {
		UserEntity user = (UserEntity)session.getAttribute("USER_SESSION");
		JSONObject obj = new JSONObject();
		try {
			ArrayList<Long> ids = new ArrayList<Long>();
			if(list != null && list.getList() != null) {
				for (int i = 0; i < list.getList().size(); i++) {
					if(list.getList().get(i).getId() != null)
					ids.add(list.getList().get(i).getId());
				}
				
				if(ids.isEmpty()) {
					obj.put("msgType", 0);
					obj.put("message", "请先保存数据");
				}else {
					HashMap<String, Object> param = new HashMap<String, Object>();
					param.put("ids", ids);
					List<Map<String, Object>> checkresults = 
							baseService.queryList("comle.SubofficeWrite.subofficewritecheck", param);
					
					boolean hasError = false;
					if(checkresults != null && !checkresults.isEmpty()) {
						StringBuffer sb = new StringBuffer();
						for (int i = 0; i < checkresults.size(); i++) {
							
							if(!checkresults.get(i).get("yearrealityinvest").equals(checkresults.get(i).get("fornowsumyear"))
									|| !checkresults.get(i).get("finishinvest").equals(checkresults.get(i).get("fornowall"))) {
								sb.append("<br/>合同："+checkresults.get(i).get("contractname"));
								if(!checkresults.get(i).get("yearrealityinvest").equals(checkresults.get(i).get("fornowsumyear"))){
									sb.append("[今年累计完成："+checkresults.get(i).get("yearrealityinvest")+"]与实际数据["+
											checkresults.get(i).get("fornowsumyear")+"]不符，请重新填写");
								}
								if(!checkresults.get(i).get("finishinvest").equals(checkresults.get(i).get("fornowall"))) {
									sb.append(";[合同累计完成："+checkresults.get(i).get("finishinvest")+"]与实际数据["+
											checkresults.get(i).get("fornowall")+"]不符，请重新填写");
								}
								hasError = true;	
							}

						}
						
						if(hasError) {
							obj.put("msgType", 0);
							obj.put("message", sb.toString());
						}else {
							//TODO 请完善提交逻辑
							HashMap<String, Object> paramUpdate = new HashMap<String, Object>();
							paramUpdate.put("status", 2);//审核中
							if(belongTimeStr!=null&&!belongTimeStr.equals("")){
								paramUpdate.put("year", belongTimeStr.substring(0,4));
								paramUpdate.put("month", belongTimeStr.substring(5,7));
							}
							//系统管理员传入特殊分局条件0
							if("admin".equals(user.getUsername())) {
								paramUpdate.put("subofficeid", 0);
							}else {
								paramUpdate.put("subofficeid", user.getSubofficeid());
							}
							baseService.updateObject("comle.SubofficeWrite.subofficewriteStatusUpdate", paramUpdate);
							obj.put("msgType", 1);
						}
					}else {
						obj.put("msgType", 0);
						obj.put("message", "数据校验发生异常，请联维护人员");
					}
				}
			}else {
				obj.put("msgType", 0);
				obj.put("message", "没有数据");
			}
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		resp.setContentType("text/html;charset=UTF-8");
		resp.getWriter().print(obj.toString());
		//return obj.toString();
	}
	
	//分局旬填报列表页 
	@RequestMapping(value = "/subofficewrite/subofficewriteTenDayList.web",method=RequestMethod.GET)
	public String subofficewriteTenDayList(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		return "/page/suboffice/subofficeWriteTenDayList";
	}
	
	//获取分局旬填报列表数据
	@RequestMapping(value = "/subofficewrite/subofficewriteTenDayGetData.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> subofficewriteTenDayGetData(String belongTimeStr,String tendaytypeid,HttpServletRequest req,HttpServletResponse resp, 
			HttpSession session, String subofficeid) throws IOException { 
		UserEntity user = (UserEntity)session.getAttribute("USER_SESSION");
		HashMap<String, Object> param = new HashMap<String, Object>();
		List<Integer> ststusList = new ArrayList<Integer>();
		ststusList.add(1);
		ststusList.add(4);
		param.put("status", ststusList);
		param.put("type", 1);
		param.put("tendaytype", Integer.valueOf(tendaytypeid));
		if(belongTimeStr!=null&&!belongTimeStr.equals("")){
			param.put("year", belongTimeStr.substring(0,4));
			param.put("month", belongTimeStr.substring(5,7));
		}
		//系统管理员传入特殊分局条件0
		if("admin".equals(user.getUsername())) {
			param.put("subofficeid", 0);
		}else {
			param.put("subofficeid", user.getSubofficeid());
		}
		List<Map<String, Object>> list = baseService.queryList("comle.SubofficeWrite.getSubofficewriteListData", param);
		return list;
	}
	
	//分局月填报保存
	@RequestMapping(value = "subofficewrite/insertSubofficewriteTenDay.json",method=RequestMethod.POST)
	public @ResponseBody String insertSubofficewriteTenDay(String belongTimeStr,SubofficeWriteView list
			,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		UserEntity user = (UserEntity)session.getAttribute("USER_SESSION");
		JSONObject obj = new JSONObject();
		try {
			for(SubofficeWriteEntity s :list.getList()){
				s.setPriority(0);
				if(belongTimeStr!=null&&!belongTimeStr.equals("")){
					s.setYear(belongTimeStr.substring(0,4));
					s.setMonth(belongTimeStr.substring(5,7));
				}
				if(s.getBegindate().equals("")){
					s.setBegindate("1970-01-01");
				}
				if(s.getPlanfinishdate().equals("")){
					s.setPlanfinishdate("1970-01-01");
				}
				if(s.getId()!= null&&s.getId()!=0){
					//修改
				}else{
					//现在默认状态已填报
					s.setStatus(1);
				}
				s.setType(1);
				s.setIsdisabled("0");
				s.setOperuser(user.getId()+"");
				s.setOperdate(new Date());
			}
			baseService.insertOupdates("comle.SubofficeWrite.subofficewrite", list.getList());
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		return obj.toString();
	}
	
	//删除分局填报
	@RequestMapping(value = "subofficewrite/deleteSubofficewrite.json",method=RequestMethod.POST)
	public void deleteSubofficewrite(String checkIds
			,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		JSONObject obj = new JSONObject();
		try {
			HashMap<String, Object> paramUpdate = new HashMap<String, Object>();
			List<Integer> subofficewriteList = new ArrayList<Integer>();
			for(String s : checkIds.split(",")){
				subofficewriteList.add(Integer.valueOf(s));
			}
			paramUpdate.put("subofficewriteList", subofficewriteList);
			baseService.updateObject("comle.SubofficeWrite.deletesubofficewrite", paramUpdate);
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		resp.setContentType("text/html;charset=UTF-8");
		resp.getWriter().print(obj.toString());
		//return obj.toString();
	}
	//分局填报审批列表页 
	@RequestMapping(value = "/subofficewrite/subofficewriteApproveList.web",method=RequestMethod.GET)
	public String subofficewriteApproveList(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		return "/page/suboffice/subofficewriteApproveList";
	}
	//获取分局填报审批列表数据
	@RequestMapping(value = "/subofficewrite/subofficewriteApproveGetData.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> subofficewriteApproveGetData(HttpServletRequest req,HttpServletResponse resp, 
			HttpSession session, String subofficeid) throws IOException { 
		UserEntity user = (UserEntity)session.getAttribute("USER_SESSION");
		HashMap<String, Object> param = new HashMap<String, Object>();
		List<Integer> ststusList = new ArrayList<Integer>();
		ststusList.add(2);
		param.put("status", ststusList);
		param.put("subofficeid", 0);
		List<Map<String, Object>> list = baseService.queryList("comle.SubofficeWrite.getSubofficewriteListData", param);
		return list;
	}
	//分局填报审批通过or驳回
	@RequestMapping(value = "subofficewrite/submitSubofficewriteApprove.json",method=RequestMethod.POST)
	public void submitSubofficewriteApprove(String checkIds,String flag
			,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		JSONObject obj = new JSONObject();
		try {
			HashMap<String, Object> paramUpdate = new HashMap<String, Object>();
			paramUpdate.put("status", Integer.valueOf(flag));
			List<Integer> subofficewriteList = new ArrayList<Integer>();
			for(String s : checkIds.split(",")){
				subofficewriteList.add(Integer.valueOf(s));
			}
			paramUpdate.put("subofficewriteList", subofficewriteList);
			paramUpdate.put("subofficeid", 0);
			baseService.updateObject("comle.SubofficeWrite.subofficewriteStatusUpdate", paramUpdate);
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		resp.setContentType("text/html;charset=UTF-8");
		resp.getWriter().print(obj.toString());
		//return obj.toString();
	}
	//分局填报提交历史数据列表页 
	@RequestMapping(value = "/subofficewrite/subofficewriteSubmitHisList.web",method=RequestMethod.GET)
	public String subofficewriteSubmitHisList(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		return "/page/suboffice/subofficewriteSubmitHisList";
	}
	//获取分局填报提交历史记录列表数据
	@RequestMapping(value = "/subofficewrite/subofficewriteSubmitHisGetData.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> subofficewriteSubmitHisGetData(HttpServletRequest req,HttpServletResponse resp, 
			HttpSession session, String subofficeid) throws IOException { 
		UserEntity user = (UserEntity)session.getAttribute("USER_SESSION");
		HashMap<String, Object> param = new HashMap<String, Object>();
		List<Integer> ststusList = new ArrayList<Integer>();
		ststusList.add(2);
		ststusList.add(3);
		ststusList.add(4);
		param.put("status", ststusList);
		//系统管理员传入特殊分局条件0
		if("admin".equals(user.getUsername())) {
			param.put("subofficeid", 0);
		}else {
			param.put("subofficeid", user.getSubofficeid());
		}
		List<Map<String, Object>> list = baseService.queryList("comle.SubofficeWrite.getSubofficewriteListData", param);
		return list;
	}
	//加载计算实际完成投资
	@RequestMapping(value = "subofficewrite/calculateRealityInvestGetDat.json",method=RequestMethod.POST)
	public void calculateRealityInvestGetDat(String contractid,String year,String month,String tendaytype,String belongTimeStr
			,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		JSONObject obj = new JSONObject();
		try {
			if(contractid!=null&&!contractid.equals("0")){
				HashMap<String, Object> paramUpdate = new HashMap<String, Object>();
				paramUpdate.put("contractid", contractid);
				if(year!=null&&!year.equals("")){
					paramUpdate.put("year", year);
				}else{
					paramUpdate.put("year", belongTimeStr.substring(0,4));
				}
				if(month!=null&&!month.equals("")){
					paramUpdate.put("month", month);
				}else{
					paramUpdate.put("month", belongTimeStr.substring(5,7));
				}
				paramUpdate.put("tendaytype", tendaytype);
				List<Map<String, Object>> calculateMonthRealityInvestList = baseService.queryList("comle.SubofficeWrite.calculateMonthRealityInvest", paramUpdate);
				if(calculateMonthRealityInvestList.size()>0){
					obj.put("calculateMonthRealityInvestData", calculateMonthRealityInvestList.get(0).get("calculatemonthrealityinvest"));
				}
				List<Map<String, Object>> calculateYearRealityInvestList = baseService.queryList("comle.SubofficeWrite.calculateYearRealityInvest", paramUpdate);
				if(calculateYearRealityInvestList.size()>0){
					obj.put("calculateYearRealityInvestData", calculateYearRealityInvestList.get(0).get("calculateyearrealityinvest"));
				}
				List<Map<String, Object>> calculateFinishInvestList = baseService.queryList("comle.SubofficeWrite.calculateFinishInvest", paramUpdate);
				if(calculateFinishInvestList.size()>0){
					obj.put("calculateFinishInvestData", calculateFinishInvestList.get(0).get("calculatefinishinvest"));
				}
			}else{
				obj.put("calculateMonthRealityInvestData",0.00);
				obj.put("calculateYearRealityInvestData",0.00);
				obj.put("calculateFinishInvestData",0.00);
			}
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		resp.setContentType("text/html;charset=UTF-8");
		resp.getWriter().print(obj.toString());
		//return obj.toString();
	}
	
	//查询上个旬的填报
	@RequestMapping(value = "subofficewrite/aa.json",method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> aa(String contractid,String year,String month,String tendaytype,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		try {
			//判断合同id是否为空
			if(tendaytype!=null&&!tendaytype.equals("0")){
				HashMap<String, Object> paramUpdate = new HashMap<String, Object>();
				if("1".equals(tendaytype) && "1".equals(month)) {
					year = ""+(Integer.parseInt(year)-1);					
				}
				if("1".equals(tendaytype)) {
					if("1".equals(month)) {
						month = "12";
					}else {
						
						month = ""+(Integer.parseInt(month)-1);
					}
					tendaytype = "3" ;
				}else {
					tendaytype = ""+(Integer.parseInt(tendaytype)-1);
				}
				paramUpdate.put("contractid",contractid);
				paramUpdate.put("year",year);
				paramUpdate.put("month",""+(Integer.parseInt(month)));
				paramUpdate.put("tendaytype",tendaytype);
				List<Map<String, Object>> calculateMonthRealityInvestList = baseService.queryList("comle.SubofficeWrite.aa", paramUpdate);
				System.out.println(calculateMonthRealityInvestList.toString());
				if(calculateMonthRealityInvestList.size()==0) {
					return null;
				}
				return calculateMonthRealityInvestList.get(0);		
			}else{
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	
	
	
}