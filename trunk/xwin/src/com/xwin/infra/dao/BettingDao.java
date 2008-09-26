package com.xwin.infra.dao;

import com.xwin.domain.game.Betting;


public class BettingDao extends XwinDao
{
	public String insertBetting(Betting betting)
	{
		String bettingId = (String) sqlMapClientTemplate.insert("insertBetting", betting);

		return bettingId;
	}
	
	public void deleteBetting(String id)
	{
		sqlMapClientTemplate.delete("deleteBetting", id);
	}
	
	public void selectBetting(String id)
	{
		sqlMapClientTemplate.queryForObject("selectBetting", id);
	}
	
	public void selectBettingList()
	{
		sqlMapClientTemplate.queryForList("selectBettingList");
	}
	
	public void selectBettingByUserId(String userId)
	{
		sqlMapClientTemplate.queryForList("selectBettingByUserId", userId);
	}
}
