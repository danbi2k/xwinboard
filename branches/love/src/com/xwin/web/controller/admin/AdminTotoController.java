package com.xwin.web.controller.admin;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.League;
import com.xwin.domain.game.Toto;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.GameCommand;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminTotoController extends XwinController
{	
	public static final int ROWSIZE = 30;
	public static final long FIVEMINUTE = 5 * 60 * 1000;
	
	public ModelAndView viewTotoList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String leagueId = XwinUtil.arcNvl(request.getParameter("leagueId"));
		String betStatus = XwinUtil.arcNvl(request.getParameter("betStatus"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("leagueId", leagueId);
		param.put("status", Code.GAME_STATUS_RUN);
		param.put("betStatus", betStatus);
		if (keyword != null) param.put(search, "%"+keyword+"%");
		param.put("fromDate", XwinUtil.toDate(fromDate));
		param.put("toDate", XwinUtil.toDateFullTime(toDate));
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<League> leagueList = leagueDao.selectLeagueList();
		List<Toto> totoList = totoDao.selectTotoList(param);
		Integer totoCount = totoDao.selectTotoCount(param);
		
		ModelAndView mv = new ModelAndView("admin/game/admin_toto");
		mv.addObject("leagueList", leagueList);
		mv.addObject("totoList", totoList);
		mv.addObject("totoCount", totoCount);
		return mv;
	}
	
	public ModelAndView viewEndTotoList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		ModelAndView mv = new ModelAndView("admin/game/admin_end_toto");
		return mv;
	}
	
	public ModelAndView viewRegisterTotoForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
//		if (request.getSession().getAttribute("Admin") == null)
//			return new ModelAndView("admin_dummy");
		
		List<League> leagueList = leagueDao.selectLeagueList();
		
		ModelAndView mv = new ModelAndView("admin/game/register_toto");
		mv.addObject("leagueList", leagueList);
		return mv;
	}
	
	public ModelAndView viewUpdateTotoForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		List<League> leagueList = leagueDao.selectLeagueList();
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", id);
		Toto toto = totoDao.selectToto(param);
		
		ModelAndView mv = new ModelAndView("admin/game/update_toto");
		mv.addObject("leagueList", leagueList);
		mv.addObject("toto", toto);
		
		return mv;
	}
	
	public ModelAndView viewReprocessToto(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		ModelAndView mv = new ModelAndView("admin/game/reprocess_toto");
		return mv;
	}
	
	public ModelAndView registerToto(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
//		if (request.getSession().getAttribute("Admin") == null)
//			return new ModelAndView("admin_dummy");
		
		String title = request.getParameter("title");
		String gameDate = request.getParameter("gameDate");
		String gameHour = request.getParameter("gameHour");
		String gameMinute = request.getParameter("gameMinute");
		String earnRate = request.getParameter("earnRate");
		String leagueName = request.getParameter("leagueName");
		String rowNum = request.getParameter("rowNum");
		String colNum = request.getParameter("colNum");
		String minMoney = request.getParameter("minMoney");
		String carryOver = request.getParameter("carryOver");
		
		League league = leagueDao.selectLeagueByName(leagueName);
		
		Enumeration paramNames = request.getParameterNames();
		StringBuffer sb = new StringBuffer();
		while (paramNames.hasMoreElements()) {
			String key = paramNames.nextElement().toString();
			if (key.startsWith("T") || key.startsWith("I") || key.startsWith("C")) {
				String value = request.getParameter(key);
				value = value.replaceAll("=", "");
				value = value.replaceAll("|", "");
				sb.append(key + "=" + value + "|");
			}
		}
		
		String cardString = sb.toString();
		System.out.println(cardString);
		
		Toto toto = new Toto();
		toto.setTitle(title);
		toto.setGameDate(XwinUtil.getDate(gameDate, Integer.parseInt(gameHour), Integer.parseInt(gameMinute)));
		toto.setEarnRate(Double.parseDouble(earnRate));
		toto.setCardString(cardString);
		toto.setLeagueId(league.getId());
		toto.setLeagueName(league.getName());
		toto.setLeagueImage(league.getImage());
		toto.setRowNum(Integer.parseInt(rowNum));
		toto.setColNum(Integer.parseInt(colNum));
		toto.setStatus(Code.GAME_STATUS_RUN);
		toto.setDisplayStatus(Code.GAME_DISPLAY_CLOSE);
		toto.setBetStatus(Code.BETTING_STATUS_ACCEPT);
		toto.setMinMoney(Integer.parseInt(minMoney));
		toto.setCarryOver(Long.parseLong(carryOver));
		
		totoDao.insertToto(toto);
		
//		ResultXml rx = new ResultXml(0, "등록되었습니다", null);
		ModelAndView mv = new ModelAndView("redirect:/adminToto.aspx?mode=viewTotoList");
//		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView updateToto(HttpServletRequest request,
			HttpServletResponse response, GameCommand command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		ResultXml rx = null;
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView endGame(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		ResultXml rx = null;
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}	
	
	public ModelAndView reprocessGame(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		ResultXml rx = null;
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
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("status", Code.GAME_STATUS_RUN);
		param.put("displayStatus", Code.GAME_DISPLAY_OPEN);
		Integer existCount = totoDao.selectTotoCount(param);
		
		ResultXml rx = null;
		if (existCount > 0 && displayStatus.equals(Code.GAME_DISPLAY_OPEN)) {
			rx = new ResultXml(-1, "이미 진행중인 토토가 있습니다", null);
		}
		else {		
			Toto toto = new Toto();
			toto.setId(id);
			toto.setDisplayStatus(displayStatus);			
			totoDao.updateToto(toto);
			
			rx = new ResultXml(0, "변경되었습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
}