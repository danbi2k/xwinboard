package com.xwin.web.controller.wap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.statistics.BetMoneyStat;
import com.xwin.web.controller.XwinController;

public class WapAdminController extends XwinController
{

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = null;
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		
		BetMoneyStat betMoneyStatToday = bettingDao.selectTodayBettingMoneyStatistics();
		
		mv = new ModelAndView("wap/" + LANG_TYPE + "/admin_today_stat");
		mv.addObject("betMoneyStatToday", betMoneyStatToday);
				
		return mv;
	}
}