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
		return (Betting) sqlMapClientTemplate.queryForObject("selectBetting", id);
	}
	
	public List<Betting> selectBettingList()
	{
		return sqlMapClientTemplate.queryForList("selectBettingList");
	}
	
	public List<Betting> selectBettingListByUserId(String userId, Integer pageIndex)
	{
		Map<String, Object> param = new HashMap<String, Object>(3);
		param.put("userId", userId);
		param.put("pageIndex", pageIndex * pageSize);
		param.put("pageSize", pageSize);
		
		return sqlMapClientTemplate.queryForList("selectBettingListByUserId", param);
	}

	public Betting selectBettingByUserId(String userId, String bettingId) {
		Map<String, String> param = new HashMap<String, String>(2);
		param.put("userId", userId);
		param.put("bettingId", bettingId);
		
		return (Betting) sqlMapClientTemplate.queryForObject("selectBettingByUserId", param);
	}
	
	public void updateBettingStatus(String gameId)
	{
		sqlMapClientTemplate.update("updateGameCountSuccess", gameId);
		sqlMapClientTemplate.update("updateGameCountFailure", gameId);
		sqlMapClientTemplate.update("updateBettingStatusByCount");
	}
}
