package com.lion.echart.project.entity;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.lion.echart.base.entity.BaseEntity;

public class MaintenanceEntity extends BaseEntity{
	
	
	private Long maintenanceid;
	private String priority;//序号
	private String entnyname;//项目名称
	private Long grade;//层级
	private Long perentid;//父ID
	private Long index;//自己所在位置
	private String codeno;//coed码
	private String unit; //单位
	private Date begindate;//开工时间
	private String begindatestr;
	private Date planfinishdate;//计划完工时间
	private String planfinishdatestr;
	private Double workload;//设计工程总量
	private Double changeworkload;//总变更工程量
	private Double accumulatedcompletion;//总累计完成量
	private Double accumulationcompletionrate;//总累计完成率
	
	public MaintenanceEntity() {
		super();
	}
	
	

	public MaintenanceEntity(Long maintenanceid, String priority, String entnyname, Long grade, Long perentid,
			Long index, String codeno, String unit, Date begindate, String begindatestr, Date planfinishdate,
			String planfinishdatestr, Double workload, Double changeworkload, Double accumulatedcompletion,
			Double accumulationcompletionrate) {
		super();
		this.maintenanceid = maintenanceid;
		this.priority = priority;
		this.entnyname = entnyname;
		this.grade = grade;
		this.perentid = perentid;
		this.index = index;
		this.codeno = codeno;
		this.unit = unit;
		this.begindate = begindate;
		this.begindatestr = begindatestr;
		this.planfinishdate = planfinishdate;
		this.planfinishdatestr = planfinishdatestr;
		this.workload = workload;
		this.changeworkload = changeworkload;
		this.accumulatedcompletion = accumulatedcompletion;
		this.accumulationcompletionrate = accumulationcompletionrate;
	}



	public Double getChangeworkload() {
		return changeworkload;
	}

	public void setChangeworkload(Double changeworkload) {
		this.changeworkload = changeworkload;
	}

	public Long getMaintenanceid() {
		return maintenanceid;
	}
	public void setMaintenanceid(Long maintenanceid) {
		this.maintenanceid = maintenanceid;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public String getEntnyname() {
		return entnyname;
	}
	public void setEntnyname(String entnyname) {
		this.entnyname = entnyname;
	}
	public Long getGrade() {
		return grade;
	}
	public void setGrade(Long grade) {
		this.grade = grade;
	}
	public long getPerentid() {
		return perentid;
	}
	public void setPerentid(Long perentid) {
		this.perentid = perentid;
	}
	public Long getIndex() {
		return index;
	}
	public void setIndex(Long index) {
		this.index = index;
	}
	public String getCodeno() {
		return codeno;
	}
	public void setCodeno(String codeno) {
		this.codeno = codeno;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public Date getBegindate() {
		return begindate;
	}
	public void setBegindate(Date begindate) {
		this.begindate = begindate;
	}
	public Date getPlanfinishdate() {
		return planfinishdate;
	}
	public void setPlanfinishdate(Date planfinishdate) {
		this.planfinishdate = planfinishdate;
	}
	
	public Double getWorkload() {
		return workload;
	}
	public void setWorkload(Double workload) {
		this.workload = workload;
	}
	
	public String getBegindatestr() {
		if(begindate != null) {
			this.begindatestr = new SimpleDateFormat("yyyy-MM-dd").format(begindate);  
		}
		return begindatestr;
	}

	public void setBegindatestr(String begindatestr) {
		this.begindatestr = begindatestr;
		if(begindatestr != null && !begindatestr.isEmpty()) {
			try {
				this.begindate = new SimpleDateFormat("yyyy-MM-dd").parse(begindatestr);
			} catch (ParseException e) {
				e.printStackTrace();
			}  
		}
	}

	public String getPlanfinishdatestr() {
		if(planfinishdate != null) {
			this.planfinishdatestr = new SimpleDateFormat("yyyy-MM-dd").format(planfinishdate);  
		}
		return planfinishdatestr;
	}

	public void setPlanfinishdatestr(String planfinishdatestr) {
		this.planfinishdatestr = planfinishdatestr;
		if(planfinishdatestr != null && !planfinishdatestr.isEmpty()) {
			try {
				this.planfinishdate = new SimpleDateFormat("yyyy-MM-dd").parse(planfinishdatestr);
			} catch (ParseException e) {
				e.printStackTrace();
			}  
		}
	}
	public Double getAccumulatedcompletion() {
		return accumulatedcompletion;
	}
	public void setAccumulatedcompletion(Double accumulatedcompletion) {
		this.accumulatedcompletion = accumulatedcompletion;
	}
	
	public Double getAccumulationcompletionrate() {
		return accumulationcompletionrate;
	}
	public void setAccumulationcompletionrate(Double accumulationcompletionrate) {
		this.accumulationcompletionrate = accumulationcompletionrate;
	}
	
	@Override
	public String toString() {
		return "MaintenanceEntity [maintenanceid=" + maintenanceid + ", priority=" + priority + ", entnyname="
				+ entnyname + ", grade=" + grade + ", perentid=" + perentid + ", index=" + index + ", codeno=" + codeno
				+ ", unit=" + unit + ", begindate=" + begindate + ", begindatestr=" + begindatestr + ", planfinishdate="
				+ planfinishdate + ", planfinishdatestr=" + planfinishdatestr + ", workload=" + workload
				+ ", changeworkload=" + changeworkload + ", accumulatedcompletion=" + accumulatedcompletion
				+ ", accumulationcompletionrate=" + accumulationcompletionrate + "]";
	}



	@Override
	public Long getId() {
		return maintenanceid;
	}
	
}