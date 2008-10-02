package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	public List<League> selectLeagueList(String search, String keyword)
	{
		Map<String, String> param = new HashMap<String, String>(1);
		param.put(search, "%" + keyword + "%");
		
		return sqlMapClientTemplate.queryForList("selectLeagueList", param);
	}
	
	public League selectLeagueById(String id)
	{
		return (League) sqlMapClientTemplate.queryForObject("selectLeagueById", id);
	}

	public void updateLeague(League league)
	{
		sqlMapClientTemplate.update("updateLeague", league);
		
	}
}
