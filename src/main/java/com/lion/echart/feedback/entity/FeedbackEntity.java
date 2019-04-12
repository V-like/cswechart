package com.lion.echart.feedback.entity;

import java.io.Serializable;

public class FeedbackEntity implements Serializable{
	
	private long feedbackid;
	private Integer priority;//序号
	private String entnyname;//项目名称
	private String grade;//层级
	private long perentid;//父ID
	private long codeno;//coed码
	private String unit; //单位
	
	
	public long getFeedbackid() {
		return feedbackid;
	}
	public void setFeedbackid(long feedbackid) {
		this.feedbackid = feedbackid;
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
	public long getCodeno() {
		return codeno;
	}
	public void setCodeno(long codeno) {
		this.codeno = codeno;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	
	
	

}
