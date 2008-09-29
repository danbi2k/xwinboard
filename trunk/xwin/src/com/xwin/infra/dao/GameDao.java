package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.game.Game;

public class GameDao extends XwinDao
{	
	private static final Integer pageSize = 5;
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
	
	public List<Game> selectGameList(String type)//, String status)
	{
		Map<String, Object> param = new HashMap<String, Object>(4);
		param.put("type", type);
		//param.put("status", status);
		//param.put("pageIndex", pageIndex * pageSize);
		//param.put("pageSize", pageSize);
		
		return sqlMapClientTemplate.queryForList("selectGameList", param);
	}
	
	public List<Game> selectGameListByLeagueId(String leagueId, String type) {
		Map<String, String> param = new HashMap<String, String>(2);
		param.put("leagueId", leagueId);
		param.put("type", type);
		
		return sqlMapClientTemplate.queryForList("selectGameListByLeagueId", param);
	}
	
	public void updateGameScore(String id, Integer homeScore, Integer awayScore, String result, String status)
	{
		Map<String, Object> param = new HashMap(5);
		param.put("id", id);
		param.put("homeScore", homeScore);
		param.put("awayScore", awayScore);
		param.put("result", result);
		param.put("status", status);
		
		sqlMapClientTemplate.update("updateGameScore", param);
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
