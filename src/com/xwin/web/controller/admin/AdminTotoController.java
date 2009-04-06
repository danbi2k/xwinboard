package com.xwin.web.controller.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Account;
import com.xwin.domain.game.BetToto;
import com.xwin.domain.game.League;
import com.xwin.domain.game.Toto;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.GameCommand;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminTotoController extends XwinController
{	
	public static final int ROWSIZE = 30;
	
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
		
		String leagueId = XwinUtil.arcNvl(request.getParameter("leagueId"));
		String status = XwinUtil.arcNvl(request.getParameter("status"));
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
		if (status != null) {
			param.put("status", status);
		} else {
			List<String> statusList = new ArrayList<String>();
			statusList.add(Code.GAME_STATUS_END);
			statusList.add(Code.GAME_STATUS_CANCEL);
			param.put("statusList", statusList);
		}
		param.put("betStatus", betStatus);
		if (keyword != null) param.put(search, "%"+keyword+"%");
		param.put("fromDate", XwinUtil.toDate(fromDate));
		param.put("toDate", XwinUtil.toDateFullTime(toDate));
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<League> leagueList = leagueDao.selectLeagueList();
		List<Toto> totoList = totoDao.selectTotoList(param);
		Integer totoCount = totoDao.selectTotoCount(param);
		
		ModelAndView mv = new ModelAndView("admin/game/admin_end_toto");
		mv.addObject("leagueList", leagueList);
		mv.addObject("totoList", totoList);
		mv.addObject("totoCount", totoCount);
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
		String totoId = XwinUtil.arcNvl(request.getParameter("id"));
		String runStatus = XwinUtil.arcNvl(request.getParameter("runStatus"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();	
		param.put("totoId", totoId);
		param.put("runStatus", runStatus);
		if (keyword != null) param.put(search, "%"+keyword+"%");
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<BetToto> betTotoList =	betTotoDao.selectBetTotoList(param);
		Integer betTotoCount =	betTotoDao.selectBetTotoCount(param);
		
		param = new HashMap<String, Object>();
		param.put("id", totoId);
		Toto toto = totoDao.selectToto(param);
		
		ModelAndView mv = new ModelAndView("admin/game/reprocess_toto");
		mv.addObject("toto", toto);
		mv.addObject("betTotoList", betTotoList);
		mv.addObject("betTotoCount", betTotoCount);
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
		
		ModelAndView mv = new ModelAndView("redirect:/adminToto.aspx?mode=viewTotoList");
		return mv;
	}
	
	public ModelAndView updateToto(HttpServletRequest request,
			HttpServletResponse response, GameCommand command) throws Exception
	{

//		if (request.getSession().getAttribute("Admin") == null)
//			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String gameDate = request.getParameter("gameDate");
		String gameHour = request.getParameter("gameHour");
		String gameMinute = request.getParameter("gameMinute");
		String earnRate = request.getParameter("earnRate");
		String leagueName = request.getParameter("leagueName");
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
		toto.setId(id);
		toto.setTitle(title);
		toto.setGameDate(XwinUtil.getDate(gameDate, Integer.parseInt(gameHour), Integer.parseInt(gameMinute)));
		toto.setEarnRate(Double.parseDouble(earnRate));
		toto.setCardString(cardString);
		toto.setLeagueId(league.getId());
		toto.setLeagueName(league.getName());
		toto.setLeagueImage(league.getImage());
		toto.setMinMoney(Integer.parseInt(minMoney));
		toto.setCarryOver(Long.parseLong(carryOver));
		
		Date now = new Date();
		long timeDiff = toto.getGameDate().getTime() - now.getTime();
		if (timeDiff > 0) {
			toto.setBetStatus(Code.BETTING_STATUS_ACCEPT);
		}
		
		totoDao.updateToto(toto);
		
		ModelAndView mv = new ModelAndView("redirect:/adminToto.aspx?mode=viewTotoList");
		return mv;
	}
	
	public ModelAndView endToto(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String resultString = request.getParameter("resultString");
		String id = request.getParameter("id");
		
		Toto toto = totoDao.selectTotoById(id);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("totoId", id);
		param.put("runStatus", Code.BET_STATUS_RUN);
		
		Long totalMoney = XwinUtil.ntz(toto.getTotalMoney()) + XwinUtil.ntz(toto.getCarryOver());
		
		param.put("markingString", resultString);
		Long successMoneySum = betTotoDao.selectBetTotoMoneySum(param);
		
		param.remove("markingString");
		List<BetToto> betTotoList = betTotoDao.selectBetTotoList(param);
		Integer successCount = 0;
		Long successMoney = 0L;
		if (betTotoList != null) {
			for (BetToto betToto : betTotoList) {
				if (betToto.getMarkingString().equals(resultString)) {
					Double portion = betToto.getMoney().doubleValue() / successMoneySum.doubleValue();
					Double _expect = Math.ceil(portion * totalMoney.doubleValue());
					Long expect = _expect.longValue();
					Double rate = XwinUtil.doubleCut(expect.doubleValue() / betToto.getMoney().doubleValue()); 
					
					betToto.setRunStatus(Code.BET_STATUS_SUCCESS);
					betToto.setRate(rate);
					betToto.setExpect(expect);
					successCount++;
					successMoney += expect;
					
					Member member = memberDao.selectMember(betToto.getUserId(), null);
					
					Account account = new Account();
					account.setUserId(member.getUserId());
					account.setType(Code.ACCOUNT_TYPE_JACKPOT);
					account.setDate(new Date());
					account.setOldBalance(member.getBalance());
					account.setMoney(betToto.getExpect());
					account.setBalance(member.getBalance() + betToto.getExpect());
					account.setBettingId(betToto.getId());
					accountDao.insertAccount(account);
					
					memberDao.plusMinusBalance(member.getUserId(), betToto.getExpect());
				} else {
					betToto.setRunStatus(Code.BET_STATUS_FAILURE);
					betToto.setRate(0.0);
					betToto.setExpect(0L);
				}
				
				betTotoDao.updateBetToto(betToto);
			}
		}
		
		toto.setResultString(resultString);
		toto.setStatus(Code.GAME_STATUS_END);
		toto.setSuccessCount(successCount);
		toto.setSuccessMoney(successMoney);
		toto.setTotalMoney(totalMoney);
		toto.setTotalCount(betTotoList.size());
//		toto.setEarnMoney(earnMoney);
		totoDao.updateToto(toto);		
		
		ResultXml rx = new ResultXml(0, "결과가 처리되었습니다", null);
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
	
	public ModelAndView viewBetTotoList(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String totoId = XwinUtil.arcNvl(request.getParameter("id"));
		String runStatus = XwinUtil.arcNvl(request.getParameter("runStatus"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();	
		param.put("totoId", totoId);
		param.put("runStatus", runStatus);
		if (keyword != null) param.put(search, "%"+keyword+"%");
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<BetToto> betTotoList =	betTotoDao.selectBetTotoList(param);
		Integer betTotoCount =	betTotoDao.selectBetTotoCount(param);
		
		Toto toto = totoDao.selectTotoById(totoId);
		
		ModelAndView mv = new ModelAndView("admin/betting/admin_betting_toto");
		mv.addObject("toto", toto);
		mv.addObject("betTotoList", betTotoList);
		mv.addObject("betTotoCount", betTotoCount);
		
		return mv;
	}
	
	public ModelAndView viewBetTotoDetail(HttpServletRequest request,
			HttpServletResponse response, League command) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = XwinUtil.arcNvl(request.getParameter("id"));
	
		Map<String, Object> param = new HashMap<String, Object>();	
		param.put("id", id);		
		BetToto betToto = betTotoDao.selectBetToto(param);
		
		ModelAndView mv = new ModelAndView("admin/betting/admin_betting_toto_detail");
		mv.addObject("betToto", betToto);
		
		return mv;
	}
}