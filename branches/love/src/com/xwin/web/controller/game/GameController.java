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
import com.xwin.domain.game.GameFolder;
import com.xwin.domain.game.League;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class GameController extends XwinController
{
	int ROWSIZE = 30;
	
	public ModelAndView viewGameList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		String type = request.getParameter("type");
		String grade = XwinUtil.nvl(request.getParameter("grade"));
		HttpSession session = request.getSession();
		
		session.setAttribute("gameFolder_" + type, new GameFolder(type));
		
		Calendar cal = Calendar.getInstance();
		cal = XwinUtil.getOnlyDate(cal);
		cal.add(Calendar.DATE, 3);
		cal.add(Calendar.MILLISECOND, -1);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("status", Code.GAME_STATUS_RUN);
		param.put("displayStatus", Code.GAME_DISPLAY_OPEN);
		param.put("toDate", cal.getTime());
		param.put("grade", grade);
		
		List<Game> gameList = gameDao.selectGameList(param);
		
		ModelAndView mv = new ModelAndView("game/game");
		mv.addObject("gameList", gameList);

		return mv; 
	}
	
	public ModelAndView viewGameResultList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		String type = XwinUtil.arcNvl(request.getParameter("type"));
		String leagueId = XwinUtil.arcNvl(request.getParameter("leagueId"));
		String gameDate = XwinUtil.arcNvl(request.getParameter("gameDate"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		if (gameDate == null)
			gameDate = XwinUtil.toDateStr(new Date(), 2);
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
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
		List<String> statusList = new ArrayList<String>();
		statusList.add(Code.GAME_STATUS_END);
		statusList.add(Code.GAME_STATUS_CANCEL);
		param.put("statusList", statusList);
		param.put("fromDate", fromDate);
		param.put("toDate", toDate);
		param.put("ORDERBY", "DESC");
		param.put("gradeLess", member.getGrade());
		//param.put("fromRow", pIdx * ROWSIZE);
		//param.put("rowSize", ROWSIZE);
		
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
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		String leagueId = XwinUtil.arcNvl(request.getParameter("leagueId"));
		String type = request.getParameter("type");
		String grade = XwinUtil.nvl(request.getParameter("grade"));
		
		Calendar cal = Calendar.getInstance();
		cal = XwinUtil.getOnlyDate(cal);
		cal.add(Calendar.DATE, 3);
		cal.add(Calendar.MILLISECOND, -1);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("leagueId", leagueId);
		param.put("status", Code.GAME_STATUS_RUN);
		param.put("displayStatus", Code.GAME_DISPLAY_OPEN);
		param.put("toDate", cal.getTime());
		if (grade.equals(Code.USER_GRADE_VIP) && member.getGrade().equals(Code.USER_GRADE_VIP))
			param.put("grade", Code.USER_GRADE_VIP);
		else
			param.put("grade", Code.USER_GRADE_NORMAL);
		
		List<Game> gameList = gameDao.selectGameList(param);
		//Integer gameCount = gameDao.selectGameCount(param);
		
		ResultXml resultXml = new ResultXml(0, null, gameList);

		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(resultXml));
		
		return mv;
	}
	
	public ModelAndView deleteFolder(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String type = request.getParameter("type");
		request.getSession().setAttribute("gameFolder_" + type, new GameFolder(type));
		
		ResultXml resultXml = new ResultXml(0, null, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(resultXml));
		
		return mv;
	}
	
	public ModelAndView getNote(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String gameId = request.getParameter("gameId");
		Game game = gameDao.selectGame(gameId);
		
		ResultXml resultXml = new ResultXml(0, game.getNote(), null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(resultXml));
		
		return mv;
	}
}
