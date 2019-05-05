package com.lion.echart.Suboffice.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Id;
/**
 * 分局表
 * @author TANGXIAN
 *
 */
public class SubofficeEntity implements Serializable {
	@Id
	private Long subofficeid;
	private Long pid;
	private String subofficename;
	private String remark;
	private Integer priority;
	private String isonlysubo;//是否分局
	private String isdisabled;
	private String operuser;
	private Date operdate;
	public SubofficeEntity(){
		
	}
	public SubofficeEntity(Long subofficeid, String subofficename, String remark, Integer priority, String isonlysubo,
			String isdisabled, String operuser, Date operdate) {
		super();
		this.subofficeid = subofficeid;
		this.subofficename = subofficename;
		this.remark = remark;
		this.priority = priority;
		this.isonlysubo = isonlysubo;
		this.isdisabled = isdisabled;
		this.operuser = operuser;
		this.operdate = operdate;
	}
	public SubofficeEntity(Long subofficeid, Long pid, String subofficename, String remark, Integer priority,
			String isonlysubo, String isdisabled, String operuser, Date operdate) {
		super();
		this.subofficeid = subofficeid;
		this.pid = pid;
		this.subofficename = subofficename;
		this.remark = remark;
		this.priority = priority;
		this.isonlysubo = isonlysubo;
		this.isdisabled = isdisabled;
		this.operuser = operuser;
		this.operdate = operdate;
	}
	public Long getSubofficeid() {
		return subofficeid;
	}
	public void setSubofficeid(Long subofficeid) {
		this.subofficeid = subofficeid;
	}
	public Long getPid() {
		return pid;
	}
	public void setPid(Long pid) {
		this.pid = pid;
	}
	public String getSubofficename() {
		return subofficename;
	}
	public void setSubofficename(String subofficename) {
		this.subofficename = subofficename;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Integer getPriority() {
		return priority;
	}
	public void setPriority(Integer priority) {
		this.priority = priority;
	}
	public String getIsonlysubo() {
		return isonlysubo;
	}
	public void setIsonlysubo(String isonlysubo) {
		this.isonlysubo = isonlysubo;
	}
	public String getIsdisabled() {
		return isdisabled;
	}
	public void setIsdisabled(String isdisabled) {
		this.isdisabled = isdisabled;
	}
	public String getOperuser() {
		return operuser;
	}
	public void setOperuser(String operuser) {
		this.operuser = operuser;
	}
	public Date getOperdate() {
		return operdate;
	}
	public void setOperdate(Date operdate) {
		this.operdate = operdate;
	}
	@Override
	public String toString() {
		return "SubofficeEntity [subofficeid=" + subofficeid + ", pid=" + pid + ", subofficename=" + subofficename
				+ ", remark=" + remark + ", priority=" + priority + ", isonlysubo=" + isonlysubo + ", isdisabled="
				+ isdisabled + ", operuser=" + operuser + ", operdate=" + operdate + "]";
	}
	
	
}