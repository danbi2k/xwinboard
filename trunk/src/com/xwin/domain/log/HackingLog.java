package com.xwin.domain.log;

import java.util.Date;

import com.xwin.domain.XwinObject;

public class HackingLog extends XwinObject
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -1716526527838644409L;
	
	private String id;
	private String userId;
	private String nickName;
	private Date date;
	private String value;
	private String mode;
	private String isChecked;
	
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
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getIsChecked() {
		return isChecked;
	}
	public void setIsChecked(String isChecked) {
		this.isChecked = isChecked;
	}	
}
