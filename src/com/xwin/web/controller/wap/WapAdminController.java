package com.xwin.web.controller.wap;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.statistics.BetMoneyStat;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.controller.XwinController;

public class WapAdminController extends XwinController
{

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = null;
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		
		Date[] todayPair = XwinUtil.getDatePair(new Date());
		BetMoneyStat betMoneyStatToday = bettingDao.selectTodayBettingMoneyStatistics(todayPair[0], todayPair[1]);
		
		mv = new ModelAndView("wap/" + LANG_TYPE + "/admin_today_stat");
		mv.addObject("betMoneyStatToday", betMoneyStatToday);
				
		return mv;
	}
}