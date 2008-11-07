package com.xwin.web.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.statistics.BetMoneyStat;
import com.xwin.domain.statistics.MemMoneyStat;
import com.xwin.domain.statistics.MoneyOutStat;
import com.xwin.domain.user.MoneyOut;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.controller.XwinController;

public class AdminStatisticsController extends XwinController
{
	int ROWSIZE = 30;
	
	public ModelAndView viewDailyBettingMoneySummary(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
			
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<BetMoneyStat> betMoneyStatList = bettingDao.selectDailyBettingMoneyStatList(param);
		Integer betMoneyStatCount = bettingDao.selectDailyBettingMoneyStatCount(param);
		
		ModelAndView mv = new ModelAndView("admin/statistics/admin_daily_betting_money");
		mv.addObject("betMoneyStatList", betMoneyStatList);
		mv.addObject("betMoneyStatCount", betMoneyStatCount);
		
		return mv;
	}
	
	public ModelAndView viewDailyMemberMoneySummary(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
			
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<MemMoneyStat> memMoneyStatList = bettingDao.selectDailyMemberMoneyStatList(param);
		Integer memMoneyStatCount = bettingDao.selectDailyMemberMoneyStatCount(param);
		
		ModelAndView mv = new ModelAndView("admin/statistics/admin_daily_member_money");
		mv.addObject("memMoneyStatList", memMoneyStatList);
		mv.addObject("memMoneyStatCount", memMoneyStatCount);
		
		return mv;
	}
	
	public ModelAndView viewMoneyOutStat(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
			
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<MoneyOutStat> moneyOutList = moneyOutDao.selectMoneyOutGroupByBankList(param);
		Integer moneyOutCount = moneyOutDao.selectMoneyOutGroupByBankCount(param);
		
		ModelAndView mv = new ModelAndView("admin/statistics/admin_money_out_stat");
		mv.addObject("moneyOutList", moneyOutList);
		mv.addObject("moneyOutCount", moneyOutCount);
		
		return mv;
	}
	
	public ModelAndView viewMoneyOutList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		
		String dateType = XwinUtil.nvl(request.getParameter("dateType"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		
		String bankNumber = XwinUtil.nvl(request.getParameter("bankNumber"));		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (keyword != null)
			param.put(search + "Like", "%"+keyword+"%");
		
		param.put("status", Code.MONEY_OUT_SUCCESS);
		
		if (dateType.equals("req")) {
			param.put("fromReqDate", XwinUtil.toDate(fromDate));
			param.put("toReqDate", XwinUtil.toDateFullTime(toDate));
		} else if (dateType.equals("proc")) {
			param.put("fromProcDate", XwinUtil.toDate(fromDate));
			param.put("toProcDate", XwinUtil.toDateFullTime(toDate));
		}
		
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		param.put("number", bankNumber);
		
		List<MoneyOut> moneyOutList = moneyOutDao.selectMoneyOutList(param);
		Integer moneyOutCount = moneyOutDao.selectMoneyOutCount(param);
		Integer totalSum = moneyOutDao.selectMoneyOutSum(param);
		
		if (totalSum == null)
			totalSum = 0;
		
		ModelAndView mv = new ModelAndView("admin/account/money_out");
		mv.addObject("moneyOutList", moneyOutList);
		mv.addObject("totalCount", moneyOutCount);
		mv.addObject("totalSum", totalSum);
		
		return mv;
	}
}
