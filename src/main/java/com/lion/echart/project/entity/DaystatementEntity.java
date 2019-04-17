package com.lion.echart.project.entity;

import com.lion.echart.base.entity.BaseEntity;


public class DaystatementEntity extends BaseEntity{
	
	private Long dayScheduid;		//id
	private Integer monthscheduleid;	//工程月计划id
	private Integer todayaccomplish;	//本日完成量
	private Integer day;				//日
	private String describe;			//施工形象描述
	public Long getDayScheduid() {
		return dayScheduid;
	}
	public void setDayScheduid(Long dayScheduid) {
		this.dayScheduid = dayScheduid;
	}
	public Integer getMonthscheduleid() {
		return monthscheduleid;
	}
	public void setMonthscheduleid(Integer monthscheduleid) {
		this.monthscheduleid = monthscheduleid;
	}
	public Integer getTodayaccomplish() {
		return todayaccomplish;
	}
	public void setTodayaccomplish(Integer todayaccomplish) {
		this.todayaccomplish = todayaccomplish;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	public Integer getDay() {
		return day;
	}
	public void setDay(Integer day) {
		this.day = day;
	}
	@Override
	public String toString() {
		return "DaystatementEntity [dayScheduid=" + dayScheduid + ", monthscheduleid=" + monthscheduleid
				+ ", todayaccomplish=" + todayaccomplish + ", describe=" + describe + "]";
	}
	@Override
	public Long getId() {
		return dayScheduid;
	}
	
}
