package com.xwin.domain.common;

import com.xwin.domain.XwinObject;

public class ReuseComment extends XwinObject
{
	private static final long serialVersionUID = 1553706826408956907L;
	
	private String id;
	private String comment;
	private String type;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
}
