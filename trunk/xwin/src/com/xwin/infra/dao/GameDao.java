package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.game.Game;

public class GameDao extends XwinDao
{	
	public void insertGame(Game gameWdl)
	{
		sqlMapClientTemplate.insert("insertGame", gameWdl);
	}
	
	public Game selectGame(String id)
	{
		return (Game) sqlMapClientTemplate.queryForObject("selectGameById", id);
	}
	
	public List<Game> selectGame(Map<String, String> where)
	{
		return sqlMapClientTemplate.queryForList("selectGameByWhere");
	}

	public List<Game> selectGameList(String type) {
		return sqlMapClientTemplate.queryForList("selectGameList", type);
	}
	
	public List<Game> selectGameListByLeagueId(String leagueId, String type) {
		Map<String, String> param = new HashMap<String, String>(2);
		param.put("leagueId", leagueId);
		param.put("type", type);
		
		return sqlMapClientTemplate.queryForList("selectGameListByLeagueId", param);
	}
	
	public void updateGame(Map<String, String> value, Map<String, String> where)
	{
		Map<String, String> condition = new HashMap<String, String>();
		condition.putAll(value);
		condition.putAll(where);
		
		sqlMapClientTemplate.update("updateGame", condition);
	}
	
	public void deleteGame(String id)
	{
		sqlMapClientTemplate.delete("deleteGameById", id);
	}
}
