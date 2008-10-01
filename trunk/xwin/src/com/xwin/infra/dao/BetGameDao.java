package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.game.BetGame;

public class BetGameDao extends XwinDao
{
	public void insertBetGame(BetGame betGame)
	{
		sqlMapClientTemplate.insert("insertBetGame", betGame);
	}
	
	public List<BetGame> selectBetGameList(String bettingId)
	{
		return sqlMapClientTemplate.queryForList("selectBetGameList", bettingId);
	}
}
