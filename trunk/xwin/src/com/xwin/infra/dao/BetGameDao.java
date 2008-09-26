package com.xwin.infra.dao;

import com.xwin.domain.game.BetGame;

public class BetGameDao extends XwinDao
{
	public void insertBetGame(BetGame betGame)
	{
		sqlMapClientTemplate.insert("insertBetGame", betGame);
	}
}
