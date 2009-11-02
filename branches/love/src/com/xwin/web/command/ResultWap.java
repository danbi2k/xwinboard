package com.xwin.web.command;

import com.xwin.domain.XwinObject;

public class ResultWap extends XwinObject
{
	private static final long serialVersionUID = 1366599475539305349L;

	public static final ResultWap SUCCESS = new ResultWap(0, null, null, null);
	public static final ResultWap FAILURE = new ResultWap(-1, "UNDEFINED ERROR", "index.wap", null);
	
	private Integer code;
	private String message;
	private String returnUrl;
	private Object object;
	
	public ResultWap() {}
	
	public ResultWap(Integer code, String message, String returnUrl, Object object) {
		this.code = code;
		this.message = message;
		this.returnUrl = returnUrl;
		this.object = object;
	}
	
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getReturnUrl() {
		return returnUrl;
	}
	public void setReturnUrl(String returnUrl) {
		this.returnUrl = returnUrl;
	}
	public Object getObject() {
		return object;
	}
	public void setObject(Object object) {
		this.object = object;
	}	
}
