package com.xwin.web.controller.game;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.Game;
import com.xwin.domain.game.League;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.GameCartItem;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class GameController extends XwinController
{
	public ModelAndView viewGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String type = request.getParameter("type");
		HttpSession session = request.getSession();
		
		session.setAttribute("cartMap_wdl", new HashMap<String, GameCartItem>());
		session.setAttribute("cartMap_handy", new HashMap<String, GameCartItem>());
		
		List<League> leagueList = leagueDao.selectLeagueList();
		
		ModelAndView mv = new ModelAndView("game/game_" + type);
		mv.addObject("leagueList", leagueList);

		return mv; 
	}
	
	public ModelAndView getGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String leagueId = request.getParameter("leagueId");
		String type = request.getParameter("type");
		
		List<Game> gameList = null;
		if (leagueId == null || leagueId.length() == 0)
			gameList = gameDao.selectGameList(type);//, "GS001");
		else
			gameList = gameDao.selectGameListByLeagueId(leagueId, type);
		
		ResultXml resultXml = new ResultXml(0, null, gameList);

		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(resultXml));
		
		return mv;
	}
	
	public ModelAndView addGameCart(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String type = request.getParameter("type");
		HttpSession session = request.getSession();
		Map<String, GameCartItem> gameCart = (Map<String, GameCartItem>) session.getAttribute("cartMap_" + type);
		
		String gameId = request.getParameter("gameId");
		String guess = request.getParameter("guess");
		
		Game game = gameDao.selectGame(gameId);
		
		GameCartItem gci = new GameCartItem();
		gci.setGameId(gameId);
		gci.setHomeTeam(game.getHomeTeam());
		gci.setAwayTeam(game.getAwayTeam());
		if (guess.equals("W"))
			gci.setRate(game.getWinRateStr());
		else if (guess.equals("D"))
			gci.setRate(game.getDrawRateStr());
		else if (guess.equals("L"))
			gci.setRate(game.getLoseRateStr());
		gci.setGuess(guess);
		gci.setLeague(game.getLeagueName());
		
		gameCart.put(gci.getGameId(), gci);
		
		List<GameCartItem> itemList = new ArrayList<GameCartItem>(gameCart.size());
		itemList.addAll(gameCart.values());
		
		ResultXml rx = new ResultXml(0, null, itemList);
				
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView deleteGameCart(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String type = request.getParameter("type");
		String gameId = request.getParameter("gameId");
		
		HttpSession session = request.getSession();
		Map<String, GameCartItem> cartMap = (Map<String, GameCartItem>) session.getAttribute("cartMap_" + type);
		
		cartMap.remove(gameId);
		
		List<GameCartItem> cartList = new ArrayList<GameCartItem>(cartMap.size());
		cartList.addAll(cartMap.values());
		
		ResultXml rx = new ResultXml(0, null, cartList);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView emptyGameCart(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String type = request.getParameter("type");
		HttpSession session = request.getSession();
		session.removeAttribute("cartMap_" + type);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(new ResultXml(0, null, null)));
		return mv;
	}
}
