package com.xwin.infra.dao;

import java.util.List;

import com.xwin.domain.game.Event;

public class EventDao extends XwinDao
{	
	public void insertEvent(Event event)
	{
		sqlMapClientTemplate.insert("insertEvent", event);
	}
	
	public List<Event> selectEventList()
	{
		return sqlMapClientTemplate.queryForList("selectEventList");
	}

	public void deleteEvent(String eventId) {
		sqlMapClientTemplate.delete("deleteEvent", eventId);
		
	}
}
