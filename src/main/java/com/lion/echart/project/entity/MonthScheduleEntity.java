package com.lion.echart.project.entity;

import java.io.Serializable;

import com.lion.echart.base.entity.BaseEntity;

public class MonthScheduleEntity  extends BaseEntity{

 
	private Long mid;     					// id                   
	private String unit; 						// 单位    
	private String designquantity; 				// 设计工程量      
	private String changequantity;   			// 变更工程量      
	private String plannedvolume;   			// 本月计划完成量
	private String accumulationcumulant;    	// 本月累计完成量
	private String completionrate;         		// 本月完成率      
	private String accumulationcompletionrate;  // 积累完成率      
	private String date;     					// 日期               
	private String backups;                		// 备注           
	private String fid;							// 外键
	
	
	//feedbackEntity中的数据
	private String number;						//序号
	private String entnyname;					//项目名称
	private long codeno;						//coed码
	
	public MonthScheduleEntity() {
		super();
	}

	public MonthScheduleEntity(Long mid, String unit, String designquantity, String changequantity,
			String plannedvolume, String accumulationcumulant, String completionrate, String accumulationcompletionrate,
			String date, String backups, String fid) {
		super();
		this.mid = mid;
		this.unit = unit;
		this.designquantity = designquantity;
		this.changequantity = changequantity;
		this.plannedvolume = plannedvolume;
		this.accumulationcumulant = accumulationcumulant;
		this.completionrate = completionrate;
		this.accumulationcompletionrate = accumulationcompletionrate;
		this.date = date;
		this.backups = backups;
		this.fid = fid;
	}
	public MonthScheduleEntity( String unit, String designquantity, String changequantity,
			String plannedvolume, String accumulationcumulant, String completionrate, String accumulationcompletionrate,
			String date, String backups, String fid) {
		super();
		this.unit = unit;
		this.designquantity = designquantity;
		this.changequantity = changequantity;
		this.plannedvolume = plannedvolume;
		this.accumulationcumulant = accumulationcumulant;
		this.completionrate = completionrate;
		this.accumulationcompletionrate = accumulationcompletionrate;
		this.date = date;
		this.backups = backups;
		this.fid = fid;
	}

	public Long getMid() {
		return mid;
	}

	public void setMid(Long mid) {
		this.mid = mid;
	}

	public String getDesignquantity() {
		return designquantity;
	}

	public void setDesignquantity(String designquantity) {
		this.designquantity = designquantity;
	}

	public String getChangequantity() {
		return changequantity;
	}

	public void setChangequantity(String changequantity) {
		this.changequantity = changequantity;
	}

	public String getPlannedvolume() {
		return plannedvolume;
	}

	public void setPlannedvolume(String plannedvolume) {
		this.plannedvolume = plannedvolume;
	}

	public String getAccumulationcumulant() {
		return accumulationcumulant;
	}

	public void setAccumulationcumulant(String accumulationcumulant) {
		this.accumulationcumulant = accumulationcumulant;
	}

	public String getCompletionrate() {
		return completionrate;
	}

	public void setCompletionrate(String completionrate) {
		this.completionrate = completionrate;
	}

	public String getAccumulationcompletionrate() {
		return accumulationcompletionrate;
	}

	public void setAccumulationcompletionrate(String accumulationcompletionrate) {
		this.accumulationcompletionrate = accumulationcompletionrate;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getBackups() {
		return backups;
	}

	public void setBackups(String backups) {
		this.backups = backups;
	}

	public String getFid() {
		return fid;
	}

	public void setFid(String fid) {
		this.fid = fid;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	@Override
	public String toString() {
		return "MonthScheduleEntity [mid=" + mid + ", unit=" + unit + ", designquantity=" + designquantity
				+ ", changequantity=" + changequantity + ", plannedvolume=" + plannedvolume + ", accumulationcumulant="
				+ accumulationcumulant + ", completionrate=" + completionrate + ", accumulationcompletionrate="
				+ accumulationcompletionrate + ", date=" + date + ", backups=" + backups + ", fid=" + fid + "]";
	}

	@Override
	public Long getId() {
		// TODO Auto-generated method stub
		return mid;
	}

}
