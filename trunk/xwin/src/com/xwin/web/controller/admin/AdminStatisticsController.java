package com.xwin.web.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.statistics.BetMoneyStat;
import com.xwin.domain.statistics.MemMoneyStat;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.controller.XwinController;

public class AdminStatisticsController extends XwinController
{
	int ROWSIZE = 20;
	
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
}
