package com.xwin.infra.dao;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.xwin.domain.game.League;

public class LeagueDao extends XwinDao
{
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
}
