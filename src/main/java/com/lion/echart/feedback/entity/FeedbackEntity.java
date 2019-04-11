package com.lion.echart.feedback.entity;

import java.io.Serializable;

public class FeedbackEntity implements Serializable{
	
	private long id;
	private Integer priority;//序号
	private String entnyname;//项目名称
	private long subofficeid;//分局ID
	private String grade;//分级
	private long perentid;//父ID
	private long code;//coed码
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public Integer getPriority() {
		return priority;
	}
	public void setPriority(Integer priority) {
		this.priority = priority;
	}
	public String getEntnyname() {
		return entnyname;
	}
	public void setEntnyname(String entnyname) {
		this.entnyname = entnyname;
	}
	public long getSubofficeid() {
		return subofficeid;
	}
	public void setSubofficeid(long subofficeid) {
		this.subofficeid = subofficeid;
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
	public long getCode() {
		return code;
	}
	public void setCode(long code) {
		this.code = code;
	}
	
	

}
