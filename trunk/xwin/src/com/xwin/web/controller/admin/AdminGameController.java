package com.xwin.web.controller.admin;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.Game;
import com.xwin.domain.game.League;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.GameCommand;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminGameController extends XwinController
{
	public ModelAndView viewGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("admin/game");
		return mv;
	}
	
	public ModelAndView getGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String status = request.getParameter("status");
		String type = request.getParameter("type");
		String _pageIndex = request.getParameter("pageIndex");
		
		Integer pageIndex = null;
		try {
			pageIndex = Integer.parseInt(_pageIndex);
		}  catch (Exception e) {
			pageIndex = 0;
		}
		
		List<Game> gameList = gameDao.selectGameList(type, status, pageIndex);
		
		ResultXml rx = new ResultXml(0, null, gameList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView viewLeagueList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("admin/league");
		return mv;
	}
	
	public ModelAndView getLeagueList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		List<League> leagueList = leagueDao.selectLeagueList();
		
		ResultXml rx = new ResultXml(0, null, leagueList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView createLeague(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		leagueDao.insertLeague(command);
		
		ModelAndView mv = new ModelAndView("admin/league");
		return mv;
	}
	
	public ModelAndView createGame(HttpServletRequest request,
			HttpServletResponse response, GameCommand command) throws Exception
	{
		String type = request.getParameter("type");
		
		Game game = new Game();
		game.setHomeTeam("LA 다저스");
		game.setAwayTeam("샌디에이고");
		game.setWinRate(1.30);
		game.setDrawRate(0.0);
		game.setLoseRate(2.30);
		game.setStatus("준비중");
		game.setDate(new Date());
		game.setLeagueId("1");
		game.setType(type);
		game.setHandy(-1.5);
		
		gameDao.insertGame(game);
		
		ModelAndView mv = new ModelAndView("game/game_" + type);
		
		return mv;
	}
}
