package com.xwin.web.controller.admin;

import java.util.ArrayList;
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
	public static final int ROWSIZE = 30;
	public static final long FIVEMINUTE = 5 * 60 * 1000;
	
	public ModelAndView viewGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String type = XwinUtil.arcNvl(request.getParameter("type"));
		String leagueId = XwinUtil.arcNvl(request.getParameter("leagueId"));
		String betStatus = XwinUtil.arcNvl(request.getParameter("betStatus"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		String grade = XwinUtil.nvl(request.getParameter("grade"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("leagueId", leagueId);
		param.put("status", Code.GAME_STATUS_RUN);
		param.put("betStatus", betStatus);
		if (keyword != null) param.put(search, "%"+keyword+"%");
		param.put("fromDate", XwinUtil.toDate(fromDate));
		param.put("toDate", XwinUtil.toDateFullTime(toDate));
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		param.put("grade", grade);
		
		List<League> leagueList = leagueDao.selectLeagueList();
		Integer gameCount = gameDao.selectGameCount(param);
		List<Game> gameList = gameDao.selectGameList(param);
		
		ModelAndView mv = new ModelAndView("admin/game/admin_game");
		mv.addObject("leagueList", leagueList);
		mv.addObject("gameList", gameList);
		mv.addObject("gameCount", gameCount);
		return mv;
	}
	
	public ModelAndView viewEndGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String type = XwinUtil.arcNvl(request.getParameter("type"));
		String leagueId = XwinUtil.arcNvl(request.getParameter("leagueId"));
		String status = XwinUtil.arcNvl(request.getParameter("status"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		String grade = XwinUtil.nvl(request.getParameter("grade"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("leagueId", leagueId);
		if (status != null) {
			param.put("status", status);
		} else {
			List<String> statusList = new ArrayList<String>();
			statusList.add(Code.GAME_STATUS_END);
			statusList.add(Code.GAME_STATUS_CANCEL);
			param.put("statusList", statusList);
		}
		if (keyword != null) param.put(search, "%"+keyword+"%");
		param.put("fromDate", XwinUtil.toDate(fromDate));
		param.put("toDate", XwinUtil.toDateFullTime(toDate));
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		param.put("ORDERBY", "DESC");
		param.put("grade", grade);
		
		List<League> leagueList = leagueDao.selectLeagueList();
		Integer gameCount = gameDao.selectGameCount(param);
		List<Game> gameList = gameDao.selectGameList(param);
		
		ModelAndView mv = new ModelAndView("admin/game/admin_end_game");
		mv.addObject("leagueList", leagueList);
		mv.addObject("gameList", gameList);
		mv.addObject("gameCount", gameCount);
		return mv;
	}
	
	public ModelAndView viewRegisterGameForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		List<League> leagueList = leagueDao.selectLeagueList();
		
		ModelAndView mv = new ModelAndView("admin/game/register_game");
		mv.addObject("leagueList", leagueList);
		return mv;
	}
	
	public ModelAndView viewUpdateGameForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		List<League> leagueList = leagueDao.selectLeagueList();
		Game game = gameDao.selectGame(id);
		
		ModelAndView mv = new ModelAndView("admin/game/update_game");
		mv.addObject("leagueList", leagueList);
		mv.addObject("game", game);
		return mv;
	}
	
	public ModelAndView viewReprocessGame(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		Game game = gameDao.selectGame(id);
		
		ModelAndView mv = new ModelAndView("admin/game/reprocess_game");
		mv.addObject("game", game);
		return mv;
	}
	
	public ModelAndView registerGame(HttpServletRequest request,
			HttpServletResponse response, GameCommand command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String type = (String) request.getParameter("type");
		
		Game game = new Game();
		game.setLeagueId(command.getLeagueId());
		game.setHomeTeam(command.getHomeTeam());
		game.setAwayTeam(command.getAwayTeam());
		game.setGameDate(XwinUtil.getDate(command.getGameDate(), command.getGameHour(), command.getGameMinute()));
		game.setWinRate(command.getWinRate());
		game.setDrawRate(command.getDrawRate());
		game.setLoseRate(command.getLoseRate());
				
		game.setStatus(Code.GAME_STATUS_RUN);
		game.setDisplayStatus(Code.GAME_DISPLAY_CLOSE);
		game.setBetStatus(Code.BETTING_STATUS_ACCEPT);
		game.setType(type);
		game.setWinDeny(command.getWinDeny());
		game.setDrawDeny(command.getDrawDeny());
		game.setLoseDeny(command.getLoseDeny());
		
		game.setGrade(command.getGrade());
		
		gameDao.insertGame(game);
		
		ResultXml rx = new ResultXml(0, "등록되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView updateGame(HttpServletRequest request,
			HttpServletResponse response, GameCommand command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
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
			
			//game.setStatus(Code.GAME_STATUS_RUN);
			Date now = new Date();
			long timeDiff = game.getGameDate().getTime() - now.getTime();
			if (timeDiff >= FIVEMINUTE) {
				game.setBetStatus(Code.BETTING_STATUS_ACCEPT);
			}
			
			game.setType(type);
			game.setWinDeny(command.getWinDeny());
			game.setDrawDeny(command.getDrawDeny());
			game.setLoseDeny(command.getLoseDeny());
			
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
	
	public ModelAndView cancelGame(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		ResultXml rx = null;		
		String id = request.getParameter("id");
		
		Game game = new Game();
		game.setId(id);
		game.setStatus(Code.GAME_STATUS_CANCEL);
		
		gameDao.updateGame(game);
		
		bettingService.judgeGameResult(game);		
		
		rx = new ResultXml(0, "경기가 취소 되었습니다", null);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView endGame(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		String _homeScore = request.getParameter("homeScore");
		String _awayScore = request.getParameter("awayScore");
		
		Integer homeScore = null;
		Integer awayScore = null;
		
		ResultXml rx = null;
		
		try {
			homeScore = Integer.parseInt(_homeScore);
			awayScore = Integer.parseInt(_awayScore);
		} catch (NumberFormatException e) {}
		
		Game game = gameDao.selectGame(id);
		if (homeScore == null && awayScore == null) {
			rx = new ResultXml(-1, "숫자를 입력하세요", null);
		} else if (game.getStatus().equals(Code.GAME_STATUS_RUN) == false) {
			rx = new ResultXml(-1, "경기진행 상태가 아닙니다", null);
		} else {			
			game.setHomeScore(homeScore);
			game.setAwayScore(awayScore);
			game.setResult(bettingService.judgeGameScore(game));
			game.setStatus(Code.GAME_STATUS_END);
			
			gameDao.updateGame(game);
			
			bettingService.judgeGameResult(game);
			
			rx = new ResultXml(0, "경기가 종료 되었습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}	
	
	public ModelAndView reprocessGame(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		String _homeScore = request.getParameter("homeScore");
		String _awayScore = request.getParameter("awayScore");
		
		Integer homeScore = null;
		Integer awayScore = null;
		
		ResultXml rx = null;
		
		try {
			homeScore = Integer.parseInt(_homeScore);
			awayScore = Integer.parseInt(_awayScore);
		} catch (NumberFormatException e) {}
		
		Game game = gameDao.selectGame(id);
		if (homeScore == null && awayScore == null) {
			rx = new ResultXml(-1, "숫자를 입력하세요", null);
		} else if (game.getStatus().equals(Code.GAME_STATUS_END) == false) {
			rx = new ResultXml(-1, "경기종료 상태가 아닙니다", null);
		} else {			
			game.setHomeScore(homeScore);
			game.setAwayScore(awayScore);
			game.setResult(bettingService.judgeGameScore(game));
			game.setStatus(Code.GAME_STATUS_END);
			
			gameDao.updateGame(game);
			
			bettingService.judgeGameResult(game);
			
			rx = new ResultXml(0, "경기가 재처리 되었습니다", null);
		}
		
		rx.setMessage("경기가 재처리 되었습니다");
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView changeDisplayStatus(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		String displayStatus = request.getParameter("displayStatus");
		
		Game game = new Game();
		game.setId(id);
		game.setDisplayStatus(displayStatus);
		
		gameDao.updateGame(game);
		
		ResultXml rx = new ResultXml(0, "변경되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
}