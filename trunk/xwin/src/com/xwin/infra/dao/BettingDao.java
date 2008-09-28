package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.game.Betting;


public class BettingDao extends XwinDao
{
	private static final Integer pageSize = 3;
	
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
}
