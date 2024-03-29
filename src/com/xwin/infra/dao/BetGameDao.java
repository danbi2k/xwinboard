package com.xwin.infra.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.xwin.domain.game.BetGame;

public class BetGameDao extends XwinDao
{
	private static final long serialVersionUID = 8967198207731265382L;

	public void insertBetGame(BetGame betGame)
	{
		sqlMapClientTemplate.insert("insertBetGame", betGame);
	}
	
	public List<BetGame> selectBetGameList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectBetGameList", param);
	}

	public void updateBetGame(BetGame betGame) {
		sqlMapClientTemplate.update("updateBetGame", betGame);
	}
	
	public void deleteBetGameByDate(Date date) {
		sqlMapClientTemplate.delete("deleteBetGameByDate", date);
	}
}
