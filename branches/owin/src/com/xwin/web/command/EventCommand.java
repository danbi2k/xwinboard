package com.xwin.web.command;

import com.xwin.domain.XwinObject;

public class EventCommand extends XwinObject
{
	private static final long serialVersionUID = 7702825108375388741L;
	
	private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}	
}
