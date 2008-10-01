package com.xwin.web.controller.admin;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.BeanUtils;
import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.Game;
import com.xwin.domain.game.League;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.GameCommand;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminGameController extends XwinController
{
	public ModelAndView registerGameForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String type = (String) request.getParameter("type");
		List<League> leagueList = leagueDao.selectLeagueList();
		
		ModelAndView mv = new ModelAndView("admin/register_game_" + type);
		mv.addObject("leagueList", leagueList);
		return mv;
	}
	
	public ModelAndView registerGame(HttpServletRequest request,
			HttpServletResponse response, GameCommand command) throws Exception
	{
		String type = (String) request.getParameter("type");
		List<League> leagueList = leagueDao.selectLeagueList();
		
		Game game = new Game();
//		game.setHomeTeam(command.getHomeTeam());
//		game.setAwayScore(command.getAwayTeam());
//		game.setLeagueId(command.getLeagueId());
		
		BeanUtils.copyProperties(command, game);
		
		Date date = 
			XwinUtil.getDate(command.getYear(), command.getMonth(), command.getDate(), command.getHour(), command.getMinute());		
		game.setStatus(Code.GAME_STATUS_READY);
		game.setGameDate(date);
		game.setType(type);
		
		gameDao.insertGame(game);
		
		ResultXml rx = new ResultXml(0, null, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView viewGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		List<League> leagueList = leagueDao.selectLeagueList();
		String type = request.getParameter("type");
		
		ModelAndView mv = new ModelAndView("admin/admin_game_" + type);
		mv.addObject("leagueList", leagueList);
		return mv;
	}
	
	public ModelAndView getGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String status = null;//request.getParameter("status");
		String type = request.getParameter("type");
		
		List<Game> gameList = gameDao.selectGameList(type, status, null, null);
		
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
		
	public ModelAndView cancelGameScore(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		String id = request.getParameter("id");
		
		Integer homeScore = null;
		Integer awayScore = null;
		
		ResultXml rx = null;		
		String result = null;
		
		gameDao.updateGameScore(id, homeScore, awayScore, result, Code.GAME_STATUS_RUN);
		bettingDao.updateBettingStatus(id);
		
		rx = new ResultXml(0, null, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView updateGameScore(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		String id = request.getParameter("id");
		String _homeScore = request.getParameter("homeScore");
		String _awayScore = request.getParameter("awayScore");
		
		Integer homeScore = null;
		Integer awayScore = null;
		
		ResultXml rx = null;
		
		try {
			homeScore = Integer.parseInt(_homeScore);
			awayScore = Integer.parseInt(_awayScore);
		
			String result = null;
			if (homeScore > awayScore)
				result = "W";
			else if (homeScore < awayScore)
				result = "L";
			else
				result = "D";
			
			gameDao.updateGameScore(id, homeScore, awayScore, result, Code.GAME_STATUS_END);
			bettingDao.updateBettingStatus(id);
			
			rx = ResultXml.SUCCESS;
		} catch(NumberFormatException e) {
			rx = new ResultXml(-1, "숫자를 입력하세요", null);
		}
		
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
		game.setGameDate(new Date());
		game.setLeagueId("1");
		game.setType(type);
		game.setHandy(-1.5);
		
		gameDao.insertGame(game);
		
		ModelAndView mv = new ModelAndView("game/game_" + type);
		
		return mv;
	}
}