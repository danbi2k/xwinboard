package com.xwin.infra.dao;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.xwin.domain.game.Event;

public class EventDao
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

	private SqlMapClientTemplate sqlMapClientTemplate;
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
}
