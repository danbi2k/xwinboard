package com.xwin.infra.dao;

import java.util.Date;
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
	
	public List<Game> selectGameList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectGameList", param);
	}
	
	public Integer selectGameCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectGameCount", param);
	}
	
	public List<Game> selectGameList(String type, String status, String leagueId, Date toDate)
	{
		Map<String, Object> param = new HashMap<String, Object>(4);
		param.put("type", type);
		param.put("status", status);
		param.put("leagueId", leagueId);
		param.put("toDate", toDate);
		
		return sqlMapClientTemplate.queryForList("selectGameList", param);
	}
	
	public void updateGame(Game game)
	{
		sqlMapClientTemplate.update("updateGame", game);
	}
	
	public void updateGameScoreNull(String id, String homeScore, String awayScore, String result, String status)
	{
		Map<String, String> param = new HashMap<String, String>(5);
		param.put("id", id);
		param.put("homeScore", homeScore);
		param.put("awayScore", awayScore);
		param.put("result", result);
		param.put("statue", status);
		
		sqlMapClientTemplate.update("updateGameScoreNull", param);
	}
	
	public void deleteGame(String id)
	{
		sqlMapClientTemplate.delete("deleteGameById", id);
	}

	public void batchGameBetStatus(Date date)
	{	
		sqlMapClientTemplate.update("batchGameBetStatus", date);
	}
	
	public void batchGameStatus(Date date)
	{	
		sqlMapClientTemplate.update("batchGameStatus", date);
	}
}
