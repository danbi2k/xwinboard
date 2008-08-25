package com.xwin.dao;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.xwin.domain.sports.Event;

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

	private SqlMapClientTemplate sqlMapClientTemplate;
	
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
}
