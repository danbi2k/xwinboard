package com.xwin.web.controller.sports;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.xwin.domain.game.GameWdl;
import com.xwin.domain.game.League;
import com.xwin.infra.dao.GameWdlDao;
import com.xwin.infra.dao.LeagueDao;

public class GameWdlController extends MultiActionController
{
	public ModelAndView viewGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		
		List<GameWdl> gameWdlList = gameWdlDao.selectGameWdlList();
		List<League> leagueList = leagueDao.selectLeagueList();
		
		ModelAndView mv = new ModelAndView("game/game_wdl");
		mv.addObject("gameWdlList", gameWdlList);

		return mv; 
	}
	
	public ModelAndView createGameWdl(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		GameWdl gameWdl = new GameWdl();
		gameWdl.setHomeTeam("LA 다저스");
		gameWdl.setAwayTeam("샌디에이고");
		gameWdl.setWinRate(1.30);
		gameWdl.setDrawRate(0.0);
		gameWdl.setLoseRate(2.30);
		gameWdl.setStatus("준비중");
		gameWdl.setDate(new Date());
		gameWdl.setLeagueId("1");
		
		gameWdlDao.insertGameWdl(gameWdl);
		
		ModelAndView mv = new ModelAndView("game/game_wdl");
		
		return mv;
	}

	private GameWdlDao gameWdlDao = null;
	private LeagueDao leagueDao = null;

	public void setGameWdlDao(GameWdlDao gameWdlDao) {
		this.gameWdlDao = gameWdlDao;
	}

	public void setLeagueDao(LeagueDao leagueDao) {
		this.leagueDao = leagueDao;
	}
}
