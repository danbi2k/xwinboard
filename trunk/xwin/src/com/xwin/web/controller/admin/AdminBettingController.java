package com.xwin.web.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Account;
import com.xwin.domain.game.Betting;
import com.xwin.domain.game.Game;
import com.xwin.domain.game.League;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminBettingController extends XwinController
{
	public static final int ROWSIZE = 40;
	
	public ModelAndView viewBettingList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String gameType = XwinUtil.arcNvl(request.getParameter("gameType"));
		String status = XwinUtil.arcNvl(request.getParameter("status"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("gameType", gameType);
		param.put("status", status);

		if (keyword != null) param.put(search+"Like", "%"+keyword+"%");
		param.put("fromDate", XwinUtil.toDate(fromDate));
		param.put("toDate", XwinUtil.toDateFullTime(toDate));
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<Betting> bettingList = bettingDao.selectBettingList(param);
		Integer bettingCount = bettingDao.selectBettingCount(param);
		
		ModelAndView mv = new ModelAndView("admin/betting/admin_betting_list");
		mv.addObject("bettingList", bettingList);
		mv.addObject("bettingCount", bettingCount);
		
		return mv;
	}
	
	public ModelAndView viewBettingDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		
		Betting betting = bettingDao.selectBetting(id);
		
		ModelAndView mv = new ModelAndView("admin/betting/admin_betting_detail");
		mv.addObject("betting", betting);
		
		return mv;
	}
	
	public ModelAndView viewBettingMoneyList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String type = XwinUtil.arcNvl(request.getParameter("type"));
		String leagueId = XwinUtil.arcNvl(request.getParameter("leagueId"));
		String status = XwinUtil.arcNvl(request.getParameter("status"));
		String betStatus = XwinUtil.arcNvl(request.getParameter("betStatus"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		if (status == null)
			status = Code.GAME_STATUS_RUN;
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("type", type);
		param.put("leagueId", leagueId);
		param.put("status", status);
		param.put("betStatus", betStatus);
		param.put("betGameCount", 0);
		if (keyword != null) param.put(search, "%"+keyword+"%");
		param.put("fromDate", XwinUtil.toDate(fromDate));
		param.put("toDate", XwinUtil.toDateFullTime(toDate));
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		if (status != null && status.equals(Code.GAME_STATUS_RUN))
			param.put("ORDERBY", "ASC");
		else
			param.put("ORDERBY", "DESC");
		
		List<League> leagueList = leagueDao.selectLeagueList();
		Integer gameCount = gameDao.selectGameCount(param);
		List<Game> gameList = gameDao.selectGameList(param);
		
		Long[] moneySummary = getMoneySummary();
		
		ModelAndView mv = new ModelAndView("admin/betting/admin_betting_game");
		mv.addObject("leagueList", leagueList);
		mv.addObject("gameList", gameList);
		mv.addObject("gameCount", gameCount);
		mv.addObject("moneySummary", moneySummary);
		return mv;
	}
	
	public ModelAndView viewBettingMoneyDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String status = XwinUtil.arcNvl(request.getParameter("status"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("gameId", id);
		if (keyword != null) param.put(search+"Like", "%"+keyword+"%");
		param.put("status", status);
		param.put("fromDate", XwinUtil.toDate(fromDate));
		param.put("toDate", XwinUtil.toDateFullTime(toDate));
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<Betting> bettingList = bettingDao.selectBettingList(param);
		Integer bettingCount = bettingDao.selectBettingCount(param);
		
		ModelAndView mv = new ModelAndView("admin/betting/admin_betting_game_detail");
		mv.addObject("bettingList", bettingList);
		mv.addObject("bettingCount", bettingCount);
		
		return mv;
	}
	
	public ModelAndView calculateBetting(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		Betting betting = bettingDao.selectBetting(id);
		
		ResultXml rx = bettingService.calcuateBettingCommon(betting);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView cancelBetting(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String message = "";
		Integer code = 0;
		
		String id = request.getParameter("id");
		Betting betting = bettingDao.selectBetting(id);
		
		if (betting.getStatus().equals(Code.BET_STATUS_RUN) == false) {
			code = -1;
			message = "배팅이 취소 가능 상태가 아닙니다";
		} else {
			String userId = betting.getUserId();
			Member member = memberDao.selectMember(userId, null);
			
			Account account = new Account();
			account.setUserId(userId);
			account.setType(Code.ACCOUNT_TYPE_BETCANCEL);
			account.setDate(new Date());
			account.setOldBalance(member.getBalance());
			account.setMoney(betting.getMoney());
			account.setBalance(member.getBalance() + betting.getMoney());
			account.setBettingId(betting.getId());
			accountDao.insertAccount(account);
			
			betting.setStatus(Code.BET_STATUS_CANCEL);
			betting.setCalcStatus(Code.BET_CALC_COMMIT);
			bettingDao.updateBetting(betting);			

			memberDao.plusMinusBalance(userId, betting.getMoney());			
			message = "취소 되었습니다";
		}
		
		ResultXml rx = new ResultXml(code, message, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView getBettingList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String _pageIndex = request.getParameter("pageIndex");
		Integer pageIndex = null;
		try {
			pageIndex = Integer.parseInt(_pageIndex);
		} catch (Exception e) {
			pageIndex = 0;
		}
		List<Betting> bettingList =	bettingDao.selectBettingList();
		
		ResultXml resultXml = new ResultXml(0, null, bettingList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(resultXml));		
		return mv;
	}
	
	private Long[] getMoneySummary()
	{
		Long moneySummary[] = new Long[2];
		moneySummary[0] = memberDao.selectTotalBalance();
		moneySummary[1] = bettingDao.selectRunningBettingMoney();
		
		if (moneySummary[0] == null)
			moneySummary[0] = 0L;
		
		if (moneySummary[1] == null)
			moneySummary[1] = 0L;			
		
		return moneySummary;
	}
}
