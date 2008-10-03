package com.xwin.web.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	public static final int ROWSIZE = 25;
	
	public ModelAndView viewGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String type = XwinUtil.arcNvl(request.getParameter("type"));
		String leagueId = XwinUtil.arcNvl(request.getParameter("leagueId"));
		String status = XwinUtil.arcNvl(request.getParameter("status"));
		String betStatus = XwinUtil.arcNvl(request.getParameter("betStatus"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String gameDate = XwinUtil.arcNvl(request.getParameter("gameDate"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("leagueId", leagueId);
		param.put("status", status);
		param.put("betStatus", betStatus);
		if (keyword != null) param.put(search, "%"+keyword+"%");
		if (gameDate != null) {
			Date[] pair = XwinUtil.getDatePair(gameDate);
			param.put("fromDate", pair[0]);
			param.put("toDate", pair[1]);
		}
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<League> leagueList = leagueDao.selectLeagueList();
		Integer gameCount = gameDao.selectGameCount(param);
		List<Game> gameList = gameDao.selectGameList(param);
		
		ModelAndView mv = new ModelAndView("admin/game/admin_game");
		mv.addObject("leagueList", leagueList);
		mv.addObject("gameList", gameList);
		mv.addObject("gameCount", gameCount);
		return mv;
	}
	
	public ModelAndView viewRegisterGameForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String type = request.getParameter("type");
		List<League> leagueList = leagueDao.selectLeagueList();
		
		ModelAndView mv = new ModelAndView("admin/game/register_game_" + type);
		mv.addObject("leagueList", leagueList);
		return mv;
	}
	
	public ModelAndView viewUpdateGameForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String type = request.getParameter("type");
		String id = request.getParameter("id");
		List<League> leagueList = leagueDao.selectLeagueList();
		Game game = gameDao.selectGame(id);
		
		ModelAndView mv = new ModelAndView("admin/game/update_game_" + type);
		mv.addObject("leagueList", leagueList);
		mv.addObject("game", game);
		return mv;
	}
	
	public ModelAndView registerGame(HttpServletRequest request,
			HttpServletResponse response, GameCommand command) throws Exception
	{
		String type = (String) request.getParameter("type");
		
		Game game = new Game();
		game.setLeagueId(command.getLeagueId());
		game.setHomeTeam(command.getHomeTeam());
		game.setAwayTeam(command.getAwayTeam());
		game.setGameDate(XwinUtil.getDate(command.getGameDate(), command.getGameHour(), command.getGameMinute()));
		game.setWinRate(command.getWinRate());
		game.setDrawRate(command.getDrawRate());
		game.setLoseRate(command.getLoseRate());
				
		game.setStatus(Code.GAME_STATUS_READY);
		game.setBetStatus(Code.BETTING_STATUS_ACCEPT);
		game.setType(type);
		
		gameDao.insertGame(game);
		
		ResultXml rx = new ResultXml(0, "등록되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView updateGame(HttpServletRequest request,
			HttpServletResponse response, GameCommand command) throws Exception
	{
		ResultXml rx = null;
		
		try {
			String type = (String) request.getParameter("type");
			
			Game game = new Game();
			game.setId(command.getGameId());
			game.setLeagueId(command.getLeagueId());
			game.setHomeTeam(command.getHomeTeam());
			game.setAwayTeam(command.getAwayTeam());
			game.setGameDate(XwinUtil.getDate(command.getGameDate(), command.getGameHour(), command.getGameMinute()));
			game.setWinRate(command.getWinRate());
			game.setDrawRate(command.getDrawRate());
			game.setLoseRate(command.getLoseRate());				
			game.setStatus(Code.GAME_STATUS_READY);
			game.setType(type);
			
			gameDao.updateGame(game);
			
			rx = new ResultXml(0, "수정되었습니다", null);
		} catch (Exception e) {
			rx = new ResultXml(-1, "서버오류", null);
			throw e;
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
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
	
	public ModelAndView runGame(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		ResultXml rx = null;
		
		String id = request.getParameter("id");
		gameDao.updateGameScore(id, null, null, null, Code.GAME_STATUS_RUN);
		
		rx = new ResultXml(0, "경기가 진행 되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView endGame(HttpServletRequest request,
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
		} catch(NumberFormatException e) {}
		
		Game game = gameDao.selectGame(id);
		if (homeScore == null && awayScore == null) {
			rx = new ResultXml(-1, "숫자를 입력하세요", null);
		} else if (game.getStatus().equals(Code.GAME_STATUS_RUN) == false) {
			rx = new ResultXml(-1, "경기진행 상태가 아닙니다", null);
		} else {
			String result = null;
			if (homeScore > awayScore)
				result = "W";
			else if (homeScore < awayScore)
				result = "L";
			else
				result = "D";
			
			gameDao.updateGameScore(id, homeScore, awayScore, result, Code.GAME_STATUS_END);
			
			rx = new ResultXml(0, "경기가 종료 되었습니다", null);
		} 
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView cancelGame(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		ResultXml rx = null;
		
		String id = request.getParameter("id");
		gameDao.updateGameScore(id, null, null, null, Code.GAME_STATUS_CANCEL);
		
		rx = new ResultXml(0, "경기가 취소 되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView readyGame(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		ResultXml rx = null;
		
		String id = request.getParameter("id");
		gameDao.updateGameScore(id, null, null, null, Code.GAME_STATUS_READY);
		
		rx = new ResultXml(0, "경기가 대기 되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView changeBetStatus(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		String id = request.getParameter("id");
		String betStatus = request.getParameter("betStatus");
		
		Game game = new Game();
		game.setId(id);
		game.setBetStatus(betStatus);
		
		gameDao.updateGame(game);
		
		ResultXml rx = new ResultXml(0, "변경되었습니다", null);
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
}