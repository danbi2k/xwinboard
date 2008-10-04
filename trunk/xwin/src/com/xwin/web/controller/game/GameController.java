package com.xwin.web.controller.game;

import java.util.Calendar;
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
		String leagueId = XwinUtil.arcNvl(request.getParameter("leagueId"));
		String type = request.getParameter("type");
		
		Calendar cal = Calendar.getInstance();
		cal = XwinUtil.getOnlyDate(cal);
		cal.add(Calendar.DATE, 3);
		cal.add(Calendar.MILLISECOND, -1);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("status", Code.GAME_STATUS_READY);
		param.put("leagueId", leagueId);
		param.put("toDate", cal.getTime());
		param.put("betStatus", Code.BETTING_STATUS_ACCEPT);
		
		List<Game> gameList = gameDao.selectGameList(param);
		
		ResultXml resultXml = new ResultXml(0, null, gameList);

		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(resultXml));
		
		return mv;
	}
}
