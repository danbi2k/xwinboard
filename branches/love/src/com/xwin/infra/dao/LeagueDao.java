package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.game.League;

public class LeagueDao extends XwinDao
{
	private static final long serialVersionUID = -7992667764345839658L;

	public void insertLeague(League league)
	{
		sqlMapClientTemplate.insert("insertLeague", league);
	}
	
	public void insertSyncLeague(League league)
	{
		sqlMapClientTemplate.insert("insertSyncLeague", league);
	}
	
	public List<League> selectLeagueList()
	{
		return sqlMapClientTemplate.queryForList("selectLeagueList");
	}
	
	public List<League> selectLeagueList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectLeagueList", param);
	}
	
	public Integer selectLeagueCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectLeagueCount", param);
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
	
	public League selectLeagueByName(String name)
	{
		return (League) sqlMapClientTemplate.queryForObject("selectLeagueByName", name);
	}

	public void updateLeague(League league)
	{
		sqlMapClientTemplate.update("updateLeague", league);
		
	}

	public void removeLeague(String id)
	{
		sqlMapClientTemplate.delete("removeLeague", id);		
	}

	public void removeAllLeague()
	{
		sqlMapClientTemplate.delete("removeAllLeague");		
	}
}
