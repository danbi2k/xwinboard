package com.xwin.web.controller.wap;

import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.statistics.BetMoneyStat;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultWap;
import com.xwin.web.controller.XwinController;

public class WapAdminController extends XwinController
{
	public ModelAndView viewIndex(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = null;
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		
		if (LANG_TYPE != null) {
				mv = new ModelAndView("wap/" + LANG_TYPE + "/admin_index");
		} else {
			mv = new ModelAndView("wap/message");
			mv.addObject("resultWap", new ResultWap(-1, "폰정보를 읽지 못하였습니다", "index.wap", null));
		}
				
		return mv;
	}
	
	public ModelAndView processPinLogin(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		String pin = request.getParameter("pin");
		
		ModelAndView mv = null;
		Calendar today = Calendar.getInstance();
		Integer month = today.get(Calendar.MONTH) + 1;
		Integer day = today.get(Calendar.DATE);
		
		if (pin.equals("97" + day + month)) {
	    	String token = Long.toString(new Date().getTime());
			
			mv = new ModelAndView("redirect:/adminCommon.wap?mode=viewAdminMain&token=" + token);
		}
		else {
			mv = new ModelAndView("wap/" + LANG_TYPE + "/message");
			mv.addObject("resultWap", new ResultWap(-1, "PIN번호를 잘못 입력하셨습니다", "admin.wap", null));
		}	
				
		return mv;
	}
	
	public ModelAndView viewAdminMain(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = null;
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		
		mv = new ModelAndView("wap/" + LANG_TYPE + "/admin_main");
				
		return mv;
	}
	
	public ModelAndView viewDailyBettingMoneySummary(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = null;
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		
		String _bias = request.getParameter("bias");
		Integer bias = 0;
		if (_bias != null)
			bias = Integer.parseInt(_bias);
		
		Calendar today = Calendar.getInstance();
		today.add(Calendar.DATE, bias);
		
		Date[] todayPair = XwinUtil.getDatePair(today.getTime());
		BetMoneyStat betMoneyStatToday = bettingDao.selectTodayBettingMoneyStatistics(Code.USER_GRADE_VIP, todayPair[0], todayPair[1]);
		
		mv = new ModelAndView("wap/" + LANG_TYPE + "/today_money_stat");
		mv.addObject("betMoneyStatToday", betMoneyStatToday);
				
		return mv;
	}
}