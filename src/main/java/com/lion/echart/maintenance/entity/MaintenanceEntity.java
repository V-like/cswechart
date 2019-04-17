package com.lion.echart.maintenance.entity;

import java.io.Serializable;

public class MaintenanceEntity implements Serializable{
	
	
	private long maintenanceid;
	private String priority;//序号
	private String entnyname;//项目名称
	private String grade;//层级
	private long perentid;//父ID
	private long index;//自己所在位置
	private String codeno;//coed码
	private String unit; //单位

	
	public long getMaintenanceid() {
		return maintenanceid;
	}
	public void setMaintenanceid(long maintenanceid) {
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
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public long getPerentid() {
		return perentid;
	}
	public void setPerentid(long perentid) {
		this.perentid = perentid;
	}
	public long getIndex() {
		return index;
	}
	public void setIndex(long index) {
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
	public MaintenanceEntity(String priority, String entnyname, String grade, long perentid,
			long index, String codeno, String unit) {
		super();
		this.priority = priority;
		this.entnyname = entnyname;
		this.grade = grade;
		this.perentid = perentid;
		this.index = index;
		this.codeno = codeno;
		this.unit = unit;
	}
	@Override
	public String toString() {
		return "MaintenanceEntity [maintenanceid=" + maintenanceid + ", priority=" + priority + ", entnyname="
				+ entnyname + ", grade=" + grade + ", perentid=" + perentid + ", index=" + index + ", codeno=" + codeno
				+ ", unit=" + unit + "]";
	}
	
	

	
	

}
