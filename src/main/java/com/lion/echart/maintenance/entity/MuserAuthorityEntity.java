package com.lion.echart.maintenance.entity;

import com.lion.echart.base.entity.BaseEntity;


public class MuserAuthorityEntity  extends BaseEntity{
	private Long id ;                           
	private String authority;// 0为可修改1为可查看
	private Long uid  ; //用户id
	private Long mid;
	private Long depid;
	private String username;
	private String realname;
	
	@Override
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public Long getUid() {
		return uid;
	}
	public void setUid(Long uid) {
		this.uid = uid;
	}
	public Long getMid() {
		return mid;
	}
	public void setMid(Long mid) {
		this.mid = mid;
	}
	public Long getDepid() {
		return depid;
	}
	public void setDepid(Long depid) {
		this.depid = depid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
	}
	@Override
	public String toString() {
		return "MuserAuthorityEntity [id=" + id + ", authority=" + authority + ", uid=" + uid + ", mid=" + mid
				+ ", depid=" + depid + ", username=" + username + ", realname=" + realname + "]";
	}
	
}
