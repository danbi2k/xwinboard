package com.xwin.service.sports;

import java.util.List;

import com.xwin.domain.sports.GameWdl;
import com.xwin.infra.dao.GameWdlDao;

public class GameWdlService
{
	public void createGameWdl(GameWdl gameWdl)
	{
		gameWdlDao.insertGameWdl(gameWdl);
	}

	public List<GameWdl> getGameWdlList() {
		return (List<GameWdl>) gameWdlDao.selectGameWdlList();
	}
	
	private GameWdlDao gameWdlDao = null;

	public void setGameWdlDao(GameWdlDao gameWdlDao) {
		this.gameWdlDao = gameWdlDao;
	}
}
