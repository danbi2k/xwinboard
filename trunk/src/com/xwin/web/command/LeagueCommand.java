package com.xwin.web.command;

import org.springframework.web.multipart.MultipartFile;

import com.xwin.domain.XwinObject;


public class LeagueCommand extends XwinObject
{
	private static final long serialVersionUID = -5640522486997302274L;
	
	private String name;
	private MultipartFile image;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public MultipartFile getImage() {
		return image;
	}
	public void setImage(MultipartFile image) {
		this.image = image;
	}
}
