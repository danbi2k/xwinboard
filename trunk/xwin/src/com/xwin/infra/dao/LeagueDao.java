package com.xwin.infra.dao;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.xwin.domain.sports.League;

public class LeagueDao
{
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	public void insertLeague(League league)
	{
		sqlMapClientTemplate.insert("insertLeague", league);
	}
	
	public List<League> selectLeagueList()
	{
		return sqlMapClientTemplate.queryForList("selectLeagueList");
	}
	
	public League selectLeagueById(String id)
	{
		return (League) sqlMapClientTemplate.queryForObject("selectLeagueById", id);
	}

	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
}
