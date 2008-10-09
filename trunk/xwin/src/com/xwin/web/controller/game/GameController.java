package com.xwin.web.controller.game;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import com.xwin.infra.util.XwinUtil;
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
		
		session.setAttribute("cartMap_" + type, new HashMap<String, GameCartItem>());
		List<League> leagueList = leagueDao.selectLeagueList();
		
		ModelAndView mv = new ModelAndView("game/game");
		mv.addObject("leagueList", leagueList);

		return mv; 
	}
	
	public ModelAndView viewGameResultList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String type = XwinUtil.arcNvl(request.getParameter("type"));
		String leagueId = XwinUtil.arcNvl(request.getParameter("leagueId"));
		String gameDate = XwinUtil.arcNvl(request.getParameter("gameDate"));
		
		Date fromDate = null;
		Date toDate = null;
		
		if (gameDate == null) {
			Calendar fromCal = Calendar.getInstance();
			Calendar toCal = Calendar.getInstance();
			fromCal = XwinUtil.getOnlyDate(fromCal);
			toCal = XwinUtil.getOnlyDate(toCal);
			
			fromCal.add(Calendar.DATE, -7);			
			toCal.add(Calendar.DATE, 1);
			toCal.add(Calendar.MILLISECOND, -1);
			
			fromDate = fromCal.getTime();
			toDate = toCal.getTime();			
		} else {
			Date[] datePair = XwinUtil.getDatePair(gameDate);
			fromDate = datePair[0];
			toDate = datePair[1];
		}
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("leagueId", leagueId);
		param.put("status", Code.GAME_STATUS_END);
		param.put("fromDate", fromDate);
		param.put("toDate", toDate);
		
		List<Game> gameList = gameDao.selectGameList(param);		
		List<League> leagueList = leagueDao.selectLeagueList();		
		
		ModelAndView mv = new ModelAndView("game/result");
		mv.addObject("gameList", gameList);
		mv.addObject("leagueList", leagueList);

		return mv; 
	}
	
	public ModelAndView getGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String leagueId = XwinUtil.arcNvl(request.getParameter("leagueId"));
		String type = request.getParameter("type");
		
		Calendar cal = Calendar.getInstance();
		cal = XwinUtil.getOnlyDate(cal);
		cal.add(Calendar.DATE, 3);
		cal.add(Calendar.MILLISECOND, -1);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("leagueId", leagueId);
		List<String> statusList = new ArrayList<String>();
		statusList.add(Code.GAME_STATUS_READY);
		statusList.add(Code.GAME_STATUS_RUN);
		param.put("betStatus", Code.BETTING_STATUS_ACCEPT);
		param.put("statusList", statusList);
		param.put("toDate", cal.getTime());
		
		List<Game> gameList = gameDao.selectGameList(param);
		
		ResultXml resultXml = new ResultXml(0, null, gameList);

		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(resultXml));
		
		return mv;
	}
}
