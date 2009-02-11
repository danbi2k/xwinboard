package com.xwin.domain.admin;

import java.util.Date;

import com.xwin.domain.XwinObject;

public class Access extends XwinObject
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -304777905486581506L;
	
	String id;
	String userId;
	String nickName;
	Date date;
	String ipAddress;
	String block;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public String getBlock() {
		return block;
	}
	public void setBlock(String block) {
		this.block = block;
	}
}
