package com.xwin.web.controller.sports;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.xwin.domain.game.GameWdl;
import com.xwin.domain.game.League;
import com.xwin.infra.dao.GameWdlDao;
import com.xwin.infra.dao.LeagueDao;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.GameCartItem;
import com.xwin.web.command.ResultXml;

public class GameWdlController extends MultiActionController
{
	public ModelAndView viewGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String leagueId = request.getParameter("leagueId");
		List<GameWdl> gameWdlList = null;
		if (leagueId == null || leagueId.length() == 0)
			gameWdlList = gameWdlDao.selectGameWdlList();
		else
			gameWdlList = gameWdlDao.selectGameWdlListByLeagueId(leagueId);
		
		HttpSession session = request.getSession();
		
		if (gameWdlList != null && gameWdlList.size() > 0) {
			Map<String, GameWdl> gameWdlMap = new HashMap<String, GameWdl>();
			for (GameWdl gameWdl : gameWdlList) {
				gameWdlMap.put(gameWdl.getId(), gameWdl);
			}
			session.setAttribute("gameWdlMap", gameWdlMap);
		}
		
		if (session.getAttribute("gameWdlCart") == null) {
			session.setAttribute("gameWdlCart", new HashMap<String, GameCartItem>());
		}		
		
		List<League> leagueList = leagueDao.selectLeagueList();
		
		ModelAndView mv = new ModelAndView("game/game_wdl");
		mv.addObject("gameWdlList", gameWdlList);
		mv.addObject("leagueList", leagueList);

		return mv; 
	}
	
	public ModelAndView getGameListXml(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String leagueId = request.getParameter("leagueId");
		List<GameWdl> gameWdlList = null;
		if (leagueId == null || leagueId.length() == 0)
			gameWdlList = gameWdlDao.selectGameWdlList();
		else
			gameWdlList = gameWdlDao.selectGameWdlListByLeagueId(leagueId);
		
		ResultXml resultXml = new ResultXml();
		resultXml.setCode(0);
		resultXml.setObject(gameWdlList);

		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(resultXml));
		return mv;
	}
	
	public ModelAndView addGameWdlCart(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		HttpSession session = request.getSession();
		Map<String, GameCartItem> gameWdlCart = (Map<String, GameCartItem>) session.getAttribute("gameWdlCart");
		Map<String, GameWdl> gameWdlMap = (Map<String, GameWdl>) session.getAttribute("gameWdlMap");
		
		String gameId = request.getParameter("gameId");
		String match = request.getParameter("match");
		
		GameWdl gameWdl = gameWdlMap.get(gameId);
		
		GameCartItem gci = new GameCartItem();
		gci.setGameId(gameId);
		gci.setHomeTeam(gameWdl.getHomeTeam());
		gci.setAwayTeam(gameWdl.getAwayTeam());
		if (match.equals("w"))
			gci.setRate(XwinUtil.to2Digit(gameWdl.getWinRate()));
		else if (match.equals("d"))
			gci.setRate(XwinUtil.to2Digit(gameWdl.getDrawRate()));
		else if (match.equals("l"))
			gci.setRate(XwinUtil.to2Digit(gameWdl.getLoseRate()));
		gci.setMatch(match);
		gci.setLeague(gameWdl.getLeagueName());
		
		gameWdlCart.put(gci.getGameId(), gci);
		
		List<GameCartItem> itemList = new ArrayList<GameCartItem>(gameWdlCart.size());
		itemList.addAll(gameWdlCart.values());
		
		ResultXml rx = new ResultXml(0, null, itemList);
				
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView deleteGameWdlCart(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		HttpSession session = request.getSession();
		Map<String, GameCartItem> gameWdlCart = (Map<String, GameCartItem>) session.getAttribute("gameWdlCart");
		Map<String, GameWdl> gameWdlMap = (Map<String, GameWdl>) session.getAttribute("gameWdlMap");
		
		String gameId = request.getParameter("gameId");
		
		gameWdlCart.remove(gameId);
		
		List<GameCartItem> itemList = new ArrayList<GameCartItem>(gameWdlCart.size());
		itemList.addAll(gameWdlCart.values());
		
		ResultXml rx = new ResultXml();
		rx.setCode(0);
		rx.setObject(itemList);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView emptyGameWdlCart(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		HttpSession session = request.getSession();
		session.removeAttribute("gameWdlCart");
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(new ResultXml(0, null, null)));
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
