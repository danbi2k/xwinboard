package com.xwin.domain.comm;

import com.xwin.domain.XwinObject;

public class SmsWait extends XwinObject
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5073399954072846627L;
	
	private String id;
	private String msg;
	private String phone;
	private String callback;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCallback() {
		return callback;
	}
	public void setCallback(String callback) {
		this.callback = callback;
	}
}
