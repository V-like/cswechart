package com.lion.echart.contract.web;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lion.echart.base.logic.BaseService;
import com.lion.echart.contract.entity.ContractEntity;
import com.lion.echart.contract.entity.ContractExecuteEntity;
import com.lion.echart.global.GlobalThings;
import com.lion.echart.system.entity.UserEntity;

import net.sf.json.JSONObject;

/**
 * 合同管理相关跳转控制
 * @author TANGXIAN
 *
 */
@Controller
public class ContractController {
	@Autowired
	private BaseService baseService;
	
	//合同签订管理列表页 
	@RequestMapping(value = "/contract/contractSignedList.web",method=RequestMethod.GET)
	public String contractSignedList(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		return "/page/contract/contractSignedList";
	}
	
	//获取合同签订列表数据
	@RequestMapping(value = "/contract/contractSignedListGetData.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> contractSignedListGetData(String contractname,String suboffice, HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		Map<String, Object> searchmap = new HashMap<String, Object>();
		searchmap.put("subofficeid", suboffice);
		searchmap.put("contractname", contractname);
		List<Map<String, Object>> list = baseService.queryList("comle.contract.getcontractSignedListData", searchmap);
		return list;
	}
	//删除合同签订
	@RequestMapping(value = "contract/contractSignedDel.json",method=RequestMethod.POST)
	public void contractSignedDel(String checkIds
			,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		JSONObject obj = new JSONObject();
		try {
			HashMap<String, Object> paramUpdate = new HashMap<String, Object>();
			List<Integer> idList = new ArrayList<Integer>();
			for(String s : checkIds.split(",")){
				idList.add(Integer.valueOf(s));
			}
			paramUpdate.put("idList", idList);
			baseService.updateObject("comle.contract.deleteContractSigned", paramUpdate);
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		resp.setContentType("text/html;charset=UTF-8");
		resp.getWriter().print(obj.toString());
		//return obj.toString();
	}
	//通过分局ID获取合同签订列表数据
	@RequestMapping(value = "/contract/contractSignedListGetDatBySuboffice.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> contractSignedListGetDatBySuboffice(String contractname,Integer suboffice, HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		Map<String, Object> searchmap = new HashMap<String, Object>();
		searchmap.put("subofficeid", suboffice);
		searchmap.put("contractname", contractname);
		Object obj = GlobalThings.getCash("contracts");
		//List<Map<String, Object>> list = baseService.queryList("comle.contract.getcontractSignedListData", searchmap);
		List<Map<String, Object>> resultlist = new ArrayList<Map<String,Object>>();
		if(obj != null) {
			List<Map<String, Object>> tmplist = (List<Map<String, Object>>)obj;
			if(contractname != null && !contractname.isEmpty()) {
				for (int i = 0; i < tmplist.size(); i++) {
					if(contractname.equals(tmplist.get(i).get("contractname"))) {
						resultlist.add(tmplist.get(i));
						break;
					}
				}
			}else if(suboffice != null) {
				for (int i = 0; i < tmplist.size(); i++) {
					if((""+suboffice).equals(""+tmplist.get(i).get("subofficeid"))) {
						resultlist.add(tmplist.get(i));
					}
				}
			}
		}
		return resultlist;
	}
//	@RequestMapping(value = "/contract/contractSignedListGetDatBySuboffice.json",method=RequestMethod.POST)
//	public @ResponseBody List<Map<String, Object>> contractSignedListGetDatBySuboffice(String contractname,Integer suboffice, HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
//		Map<String, Object> searchmap = new HashMap<String, Object>();
//		searchmap.put("subofficeid", suboffice);
//		searchmap.put("contractname", contractname);
//		List<Map<String, Object>> list = baseService.queryList("comle.contract.getcontractSignedListData", searchmap);
//		return list;
//	}
	
	//合同签订添加页 
	@RequestMapping(value = "/contract/contractSignedAdd.web",method=RequestMethod.GET)
	public String contractSignedAdd(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		return "/page/contract/contractSignedAdd";
	}
	
	//合同签订保存
	@RequestMapping(value = "/contract/contractSignedSave.json",method=RequestMethod.POST)
	public @ResponseBody String contractSignedSave(String contractName,String contractNum,Double amount,String durationTime,String signTime,String contractPartyB,String remark,Integer subofficeId,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		SimpleDateFormat si = new SimpleDateFormat("yyyy-MM-dd");
		JSONObject obj = new JSONObject();
		try {
			ContractEntity contract = new ContractEntity(contractName, contractNum, amount, durationTime, si.parse(signTime), contractPartyB, remark, 0, 9, "0", "admin", new Date(), subofficeId);
			baseService.insertObject("comle.contract.insertContractSigned", contract);
			obj.put("flag", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("flag", 0);
		}
		return obj.toString();
	}
	
	//合同执行管理列表页 
	@RequestMapping(value = "/contract/contractExecuteList.web",method=RequestMethod.GET)
	public String contractExecuteList(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		return "/page/contract/contractExecuteList";
	}
	
	//获取合同执行列表数据
	@RequestMapping(value = "/contract/contractExecuteListGetData.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> contractExecuteListGetData(String contractname,String suboffice,String belongTimeStr,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		Map<String, Object> searchmap = new HashMap<String, Object>();
		searchmap.put("subofficeid", suboffice);
		searchmap.put("contractname", contractname);
		if(belongTimeStr!=null&&!belongTimeStr.equals("")){
			searchmap.put("year", belongTimeStr.substring(0,4));
			searchmap.put("month", belongTimeStr.substring(5,7));
		}
		List<Map<String, Object>> list = baseService.queryList("comle.contract.getcontractExecuteListData", searchmap);
		return list;
	}
	
	//合同执行添加页 
	@RequestMapping(value = "/contract/contractExecuteAdd.web",method=RequestMethod.GET)
	public String contractExecuteAdd(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "contract");
		return "/page/contract/contractExecuteAdd";
	}
	
	//合同执行保存
	@RequestMapping(value = "/contract/contractExecuteSave.json",method=RequestMethod.POST)
	public @ResponseBody String contractExecuteSave(Integer contractId,Double monthamount,String belongTime,String remark,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		SimpleDateFormat si = new SimpleDateFormat("yyyy-MM-dd");
		JSONObject obj = new JSONObject();
		try {
			ContractExecuteEntity contractExecute = new ContractExecuteEntity(contractId, monthamount, remark, belongTime.substring(0,4), belongTime.substring(5,7), 0, "0", "admin", new Date());
			//ContractEntity contract = new ContractEntity(contractName, contractNum, amount, durationTime, si.parse(signTime), contractPartyB, remark, 0, 9, "false", "admin", new Date(), subofficeId);
			baseService.insertObject("comle.contract.insertContractExecute", contractExecute);
			obj.put("flag", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("flag", 0);
		}
		return obj.toString();
	}
	//删除合同执行
	@RequestMapping(value = "contract/contractExecuteDel.json",method=RequestMethod.POST)
	public void contractExecuteDel(String checkIds
			,HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		JSONObject obj = new JSONObject();
		try {
			HashMap<String, Object> paramUpdate = new HashMap<String, Object>();
			List<Integer> idList = new ArrayList<Integer>();
			for(String s : checkIds.split(",")){
				idList.add(Integer.valueOf(s));
			}
			paramUpdate.put("idList", idList);
			baseService.updateObject("comle.contract.deleteContractExecute", paramUpdate);
			obj.put("msgType", 1);
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("msgType", 0);
		}
		resp.setContentType("text/html;charset=UTF-8");
		resp.getWriter().print(obj.toString());
		//return obj.toString();
	}
	//合同月度统计表列表页 
	@RequestMapping(value = "/contract/contractExecuteMonthTotalList.web",method=RequestMethod.GET)
	public String contractExecutemonthTotalList(HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		req.setAttribute("ts", System.currentTimeMillis());
		req.setAttribute("who", "report");
		req.setAttribute("realname",((UserEntity)session.getAttribute("USER_SESSION")).getRealname());
		return "/page/contract/contractExecuteMonthTotalList";
	}
	//合同月度统计表数据
	@RequestMapping(value = "/contract/contractExecuteMonthTotalListGetDat.json",method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> contractExecutemonthTotalListGetData(Integer year, Integer month, HttpServletRequest req,HttpServletResponse resp, HttpSession session) throws IOException { 
		Map<String, Object> searchmap = new HashMap<String, Object>();
		searchmap.put("year", year);
		searchmap.put("month", month);
		List<Map<String, Object>> list = baseService.queryList("comle.contract.getcontractExecuteMonthTotalListData", searchmap);
		return list;
	}
}