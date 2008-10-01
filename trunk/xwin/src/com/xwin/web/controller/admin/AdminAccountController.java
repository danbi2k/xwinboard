package com.xwin.web.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.user.MoneyIn;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.controller.XwinController;

public class AdminAccountController extends XwinController
{
	public ModelAndView viewMoneyIn(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String search = XwinUtil.aNvl(request.getParameter("search"));
		String keyword = request.getParameter("keyword");
		
		String searchDate = XwinUtil.aNvl(request.getParameter("searchDate"));
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		
		List<MoneyIn> moneyInList = null;
		
		if (searchDate != null && searchDate.equals("reqDate"))
			moneyInList = moneyInDao.selectMoneyInList(search, keyword, XwinUtil.toDate(fromDate), XwinUtil.toDate(toDate), null, null);
		else if (searchDate != null && searchDate.equals("procDate"))
			moneyInList = moneyInDao.selectMoneyInList(search, keyword, null, null, XwinUtil.toDate(fromDate), XwinUtil.toDate(toDate));
		else
			moneyInList = moneyInDao.selectMoneyInList(search, keyword, null, null, null, null);
		
		ModelAndView mv = new ModelAndView("admin/account/money_in");
		mv.addObject("moneyInList", moneyInList);
		
		return mv;
	}
	
	public ModelAndView viewMoneyInDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("admin/account/money_in_detail");
		return mv;
	}
	
	public ModelAndView viewMoneyOut(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("admin/account/money_out");
		return mv;
	}
	
	public ModelAndView viewMoneyOutDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("admin/account/money_out_detail");
		return mv;
	}
	
	public ModelAndView viewMoneySummary(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("admin/account/money_summary");
		return mv;
	}
	
	public ModelAndView viewMoneyCalculation(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("admin/account/money_calculation");
		return mv;
	}
}
