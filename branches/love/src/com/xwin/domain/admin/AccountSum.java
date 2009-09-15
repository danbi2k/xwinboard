package com.xwin.domain.admin;

import com.xwin.domain.XwinObject;

public class AccountSum extends XwinObject
{
	private static final long serialVersionUID = 348110947888858684L;
	
	private String type;
	private Long sum;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Long getSum() {
		return sum;
	}
	public void setSum(Long sum) {
		this.sum = sum;
	}
}
