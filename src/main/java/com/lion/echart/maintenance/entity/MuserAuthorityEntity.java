package com.lion.echart.maintenance.entity;

import java.io.Serializable;

import com.lion.echart.base.entity.BaseEntity;


public class MuserAuthorityEntity  extends BaseEntity{
	private long id ;                           
	private String authority;// 0为可修改1为可查看
	private String uid  ; //用户id
	private String mid;
	private String username;
	private String realname;
	
	@Override
	public Long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	@Override
	public String toString() {
		return "MuserAuthorityEntity [id=" + id + ", authority=" + authority + ", uid=" + uid + ", mid=" + mid + "]";
	}
}
