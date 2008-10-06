package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.game.Betting;


public class BettingDao extends XwinDao
{
	private static final Integer pageSize = 100;
	
	public String insertBetting(Betting betting)
	{
		String bettingId = (String) sqlMapClientTemplate.insert("insertBetting", betting);

		return bettingId;
	}
	
	public void deleteBetting(String id)
	{
		sqlMapClientTemplate.delete("deleteBetting", id);
	}
	
	public Betting selectBetting(String id)
	{
		Map<String, Object> param = new HashMap<String, Object>(1);
		param.put("id", id);
		
		return (Betting) sqlMapClientTemplate.queryForObject("selectBettingList", param);
	}
	
	public List<Betting> selectBettingList()
	{
		return sqlMapClientTemplate.queryForList("selectBettingList");
	}
	
	public List<Betting> selectBettingList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectBettingList", param);
	}
	
	public Integer selectBettingCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectBettingCount", param);
	}
	
	public List<Betting> selectBettingListByUserId(String userId, String status, String gameType, Integer pageIndex)
	{
		Map<String, Object> param = new HashMap<String, Object>(5);
		param.put("userId", userId);
		param.put("status", status);
		param.put("gameType", gameType);
		param.put("fromRow", pageIndex * pageSize);
		param.put("rowSize", pageSize);
		
		return sqlMapClientTemplate.queryForList("selectBettingList", param);
	}

	public Betting selectBettingByUserId(String userId, String id) {
		Map<String, String> param = new HashMap<String, String>(2);
		param.put("userId", userId);
		param.put("id", id);
		
		return (Betting) sqlMapClientTemplate.queryForObject("selectBettingList", param);
	}
	
	public void updateBetting(Betting betting)
	{
		sqlMapClientTemplate.update("updateBetting", betting);
	}
	
	public void updateBettingStatus(String gameId)
	{
		sqlMapClientTemplate.update("updateGameCountCancel", gameId);
		sqlMapClientTemplate.update("updateGameCountSuccess", gameId);
		sqlMapClientTemplate.update("updateGameCountFailure", gameId);
		sqlMapClientTemplate.update("updateGameCountHandyDraw", gameId);
		sqlMapClientTemplate.update("updateBettingStatusByCount");
	}
	
	public void updateBettingStatusWhenGameCancel(String gameId)
	{
		sqlMapClientTemplate.update("updateGameCountCancel", gameId);
		sqlMapClientTemplate.update("updateGameCountSuccess", gameId);
		sqlMapClientTemplate.update("updateGameCountFailure", gameId);
		sqlMapClientTemplate.update("updateGameCountHandyDraw", gameId);
		sqlMapClientTemplate.update("updateBettingStatusByCount");
	}
}
