package com.lion.echart.system.web;

import java.net.URLDecoder;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lion.echart.base.logic.BaseService;
import java.util.ArrayList;

@Controller
public class ExcelController2 {

	@Autowired
	private BaseService baseService;

	@RequestMapping(value = "/excel/toExcelXlsExecute2.web", method = RequestMethod.POST)
	public String proExcelXlsExecute2(HttpServletRequest request, HttpServletResponse response, Model model,
			String dcdytype, String qparam) throws Exception {
		List<HashMap<String, Object>> listData = null;
		HashMap<String, Object> dataMap = new HashMap<String, Object>();

		// 取数据----------------------------------------------

		boolean goon = true;
		String message = "";
		// 将发送请求页面中form表单里所有具有name属性的表单对象获取
		Enumeration paramkey = request.getParameterNames();
		// 表头时间 和表尾资金来源
		HashMap<String, Object> param = new HashMap<String, Object>();
		// 表头时间 和表尾资金来源
		HashMap<String, Object> titlemap = new HashMap<String, Object>();

		String keyname = "";
		// 枚举是否包含的元素
		while (paramkey.hasMoreElements()) {
			// 如果此枚举对象至少还有一个可提供的元素，则返回此枚举的下一个元素 赋值给keyname
			keyname = paramkey.nextElement().toString();
			// 存入param集合中
			param.put(keyname, request.getParameter(keyname));
			titlemap.put(keyname, URLDecoder.decode(request.getParameter(keyname)));
		}
		// 文件名
		String filename = titlemap.get("filename").toString();
		param.put("istitleortail", 1);
		// 表头数据
		List<HashMap<String, Object>> titles = baseService.queryList("com.system.eap.getTitle", param);
		if (titles == null || titles.isEmpty()) {
			goon = false;
			message = "没有设置对应的表头格式";
		}
		param.put("istitleortail", 2);
		// 表尾合计金额
		List<HashMap<String, Object>> tails = baseService.queryList("com.system.eap.getTitle", param);
		// 表格样式
		List<HashMap<String, Object>> propertys = baseService.queryList("com.system.eap.getSqlproerty", param);
		if (propertys == null || propertys.isEmpty()) {
			goon = false;
			message = "没有设置对应的取值属性";
		}
		// 返回地址
		List<HashMap<String, Object>> ibitisSqls = baseService.queryList("com.system.eap.getSqlid", param);
		// 方法名
		String ibitisSql = "";
		String ibitisTitleSql = "";
		if (ibitisSqls == null || ibitisSqls.isEmpty()) {
			goon = false;
			message = "没有设置对应的取值逻辑";
		} else {
			for (int i = 0; i < ibitisSqls.size(); i++) {
				if (ibitisSqls.get(i).get("sqlid") != null) {
					if ("1".equals(ibitisSqls.get(i).get("sqltype"))) {
						ibitisSql = ibitisSqls.get(i).get("sqlid").toString();
					} else {
						ibitisTitleSql = ibitisSqls.get(i).get("sqlid").toString();
					}
				}
			}
		}
		if (goon) {
			// 表中数据
			listData = baseService.queryList(ibitisSql, param);
			int listcount = 0;
			if (listData != null && listData.size() > 0) {
				listcount = listData.size();
			} else {
				message = "没有查询到对应结果";
				goon = false;
			}
		}
		try {
			if (!goon) {
				model.addAttribute("msgType", 0);
			}
			model.addAttribute("message", message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		HSSFWorkbook workbook2003 = new HSSFWorkbook();

		// 创建一个sheet
		Sheet sheet = workbook2003.createSheet("workbook2003");
		// 写数据---------------------------------------------
		String title = titlemap.get("filename").toString();
		// 数据头 需要方法写
		String[] rowsName = new String[] {};
		// 存放表中数据
		List<ArrayList<Object>> dataList = new ArrayList<ArrayList<Object>>();
		Object[] objs = null;
		String prowindex = "1";
		// 创建一行
		Row row = sheet.createRow(0);
		int numberH = 0;
		int numberL = 0;
		for (int i = 0; i < titles.size(); i++) {
			if (!prowindex.equals("" + titles.get(i).get("rowindex"))) {
				// 创建一行
				row = sheet.createRow(++numberL);
				row.setHeight((short) (25 * 15));
				numberH = 0;
			}
			prowindex = titles.get(i).get("rowindex") + "";
			if (titles.get(i).get("tdid") == null || titles.get(i).get("tdid").toString().isEmpty()) {
				// 创建一个单元格
				Cell cell = row.createCell(numberH);
				// 设置值
				cell.setCellValue(titles.get(i).get("showtitle") + "");
				new ExcelController2().setCount(workbook2003,cell,titles.get(i),sheet,numberL,numberH);
				numberH++;
			} else {
				// 创建一个单元格
				Cell cell = row.createCell(numberH);
				// 设置值
				cell.setCellValue(titlemap.get(titles.get(i).get("tdid")) + "");
				new ExcelController2().setCount(workbook2003,cell,titles.get(i),sheet,numberL,numberH);
				numberH++;
			}
		}
		// 创建一行
		row = sheet.createRow(++numberL);
		numberH = 0;
		
		for (int i = 0; i < listData.size(); i++) {
			
			for (int a = 0; a < propertys.size(); a++) {
				// 创建一个单元格
				Cell cell = row.createCell(numberH);
				// 设置值
				if(listData.get(i).get(propertys.get(a).get("keyname"))==null) {
					cell.setCellValue(0+"");
				}else {
					cell.setCellValue(listData.get(i).get(propertys.get(a).get("keyname"))+"");
				}
				new ExcelController2().setCount(workbook2003,cell,listData.get(i),sheet,numberL,numberH);
				numberH++;
			}
			row = sheet.createRow(++numberL);
			row.setHeight((short) (25 * 15));
			numberH = 0;
		}
		prowindex = "1";
		Object obj = request.getAttribute("tails");
		if (obj != null) {
			tails = (ArrayList) obj;
		}
		if (tails != null) {
			for (int i = 0; i < tails.size(); i++) {
				if (!prowindex.equals("" + tails.get(i).get("rowindex"))) {
					// 创建一行
					row = sheet.createRow(++numberL);
					numberH = 0;
					row.setHeight((short) (25 * 15));
				}
				prowindex = tails.get(i).get("rowindex") + "";
				if (tails.get(i).get("tdid") == null || "".equals(tails.get(i).get("tdid"))) {
					// 创建一个单元格
					Cell cell = row.createCell(numberH);
					new ExcelController2().setCount(workbook2003,cell,tails.get(i),sheet,numberL,numberH);
					numberH++;
					cell.setCellValue("合计");
				} else {
					// 创建一个单元格
					Cell cell = row.createCell(numberH);
					// 设置值
					new ExcelController2().setCount(workbook2003,cell,tails.get(i),sheet,numberL,numberH);
					cell.setCellValue(titlemap.get(tails.get(i).get("tdid")) + "");
					numberH++;
				}
			}
		}
		// 写到输出流
		response.setContentType("application/octet-stream");
		filename = new String(filename.getBytes("utf-8"), "iso-8859-1");
		response.addHeader("Content-Disposition", "attachment; filename=" + filename + ".xls");
		workbook2003.write(response.getOutputStream());

		return null;
	}
	
	public void setCount(HSSFWorkbook workbook,Cell cell,HashMap<String, Object> map,Sheet sheet,int numberL,int numberH) {
//		int a=0;
//		if(a==0) {
//			
//			Set<String> set=map.keySet();
//			for(String s:set) {
//				System.out.println(s);
//			}
//			
//		}
//		a=22;
		
		int excelLength=7000;
		if(numberL==0) {
			sheet.setColumnWidth(numberL, excelLength+2000);
		}else {
			sheet.setColumnWidth(numberL, excelLength);
		}
		
		

		// 设置值
		HSSFCellStyle style = workbook.createCellStyle();
		if(map.get("talign")!=null) {
			if(map.get("talign").equals("center")) {
				style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中 
			}
			if(map.get("talign").equals("left")) {
				style.setAlignment(HSSFCellStyle.ALIGN_LEFT); // 居左
			}
			if(map.get("talign").equals("right")) {
				style.setAlignment(HSSFCellStyle.ALIGN_RIGHT); // 居右 
			}
		}
		int mrowspan=1;
		int mcolspan=1;
		if(map.get("mrowspan")!=null) {
			mrowspan=(Integer)map.get("mrowspan");
		}if(map.get("mcolspan")!=null) {
			mcolspan=(Integer)map.get("mcolspan");
		}
		CellRangeAddress region1 = new CellRangeAddress(numberH,numberH+mrowspan-1, (short) numberL, (short) numberL+mcolspan-1); 
		//参数1：起始行 参数2：终止行 参数3：起始列 参数4：终止列    
		 
		sheet.addMergedRegion(region1); 
		
		
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
//		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
//		style.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框

		
		if(map.get("showtitle") !=null &&  !(map.get("tdid")+"").contains("taily")) {
			HSSFFont font = workbook.createFont();  
			font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//粗体显示  
			style.setFont(font);//选择需要用到的字体格式  
		}
		cell.setCellStyle(style);		
	}
}