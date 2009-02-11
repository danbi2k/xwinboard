package com.xwin.web.command;

import com.xwin.domain.XwinObject;

public class ResultXml extends XwinObject
{
	private static final long serialVersionUID = 667972321386597867L;

	public static final ResultXml SUCCESS = new ResultXml(0, null, null);
	
	private Integer code;
	private String message;
	private Object object;
	
	public ResultXml() {}
	
	public ResultXml(Integer code, String message, Object object) {
		this.code = code;
		this.message = message;
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
	public Object getObject() {
		return object;
	}
	public void setObject(Object object) {
		this.object = object;
	}	
}
