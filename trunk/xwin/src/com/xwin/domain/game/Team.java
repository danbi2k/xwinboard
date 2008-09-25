package com.xwin.domain.game;

import com.xwin.domain.XwinObject;

public class Team extends XwinObject
{
	private String id;
	private String name;
	private League league;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public League getLeague() {
		return league;
	}
	public void setLeague(League league) {
		this.league = league;
	}
}
