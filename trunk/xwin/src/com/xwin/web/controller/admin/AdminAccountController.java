package com.xwin.web.controller.admin;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Account;
import com.xwin.domain.user.Member;
import com.xwin.domain.user.MoneyIn;
import com.xwin.domain.user.MoneyOut;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminAccountController extends XwinController
{
	public ModelAndView viewMoneyIn(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = request.getParameter("keyword");
		
		String searchDate = XwinUtil.arcNvl(request.getParameter("searchDate"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		
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
		String id = request.getParameter("id");
		MoneyIn moneyIn = moneyInDao.selectMoneyIn(id);
		
		ModelAndView mv = new ModelAndView("admin/account/money_in_detail");
		mv.addObject("moneyIn", moneyIn);
		return mv;
	}
	
	public ModelAndView viewMoneyOut(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = request.getParameter("keyword");
		
		String searchDate = XwinUtil.arcNvl(request.getParameter("searchDate"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		
		List<MoneyOut> moneyOutList = null;
		
		if (searchDate != null && searchDate.equals("reqDate"))
			moneyOutList = moneyOutDao.selectMoneyOutList(search, keyword, XwinUtil.toDate(fromDate), XwinUtil.toDate(toDate), null, null);
		else if (searchDate != null && searchDate.equals("procDate"))
			moneyOutList = moneyOutDao.selectMoneyOutList(search, keyword, null, null, XwinUtil.toDate(fromDate), XwinUtil.toDate(toDate));
		else
			moneyOutList = moneyOutDao.selectMoneyOutList(search, keyword, null, null, null, null);
		
		ModelAndView mv = new ModelAndView("admin/account/money_out");
		mv.addObject("moneyOutList", moneyOutList);
		
		return mv;
	}
	
	public ModelAndView viewMoneyOutDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id = request.getParameter("id");
		MoneyOut moneyOut = moneyOutDao.selectMoneyOut(id);
		
		ModelAndView mv = new ModelAndView("admin/account/money_out_detail");
		mv.addObject("moneyOut", moneyOut);
		return mv;
	}
	
	public ModelAndView viewMoneySummary(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = request.getParameter("keyword");
		
		String searchDate = XwinUtil.arcNvl(request.getParameter("searchDate"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		
		List<Account> accountList = null;
		
		if (searchDate != null && searchDate.equals("reqDate"))
			accountList = accountDao.selectAccountList(search, keyword, XwinUtil.toDate(fromDate), XwinUtil.toDate(toDate), null, null);
		else if (searchDate != null && searchDate.equals("procDate"))
			accountList = accountDao.selectAccountList(search, keyword, null, null, XwinUtil.toDate(fromDate), XwinUtil.toDate(toDate));
		else
			accountList = accountDao.selectAccountList(search, keyword, null, null, null, null);
		
		ModelAndView mv = new ModelAndView("admin/account/money_summary");
		mv.addObject("accountList", accountList);
		
		return mv;
	}
	
	public ModelAndView viewMoneyCalculation(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("admin/account/money_calculation");
		return mv;
	}
	

	public ModelAndView acceptMoneyInRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ResultXml rx = null;
		String id = request.getParameter("id");
		
		MoneyIn moneyIn = moneyInDao.selectMoneyIn(id);
		if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST)) {
			Member member = memberDao.selectMember(moneyIn.getUserId(), null);
			
			Account account = new Account();
			account.setUserId(member.getUserId());
			account.setType(Code.ACCOUNT_TYPE_MONEYIN);
			account.setDate(new Date());
			account.setOldBalance(member.getBalance());
			account.setMoney(moneyIn.getMoney());
			account.setBalance(member.getBalance() + moneyIn.getMoney());
			account.setMoneyInId(moneyIn.getId());
			
			moneyIn.setStatus(Code.MONEY_IN_SUCCESS);
			moneyIn.setProcDate(new Date());
			
			accountDao.insertAccount(account);		
			memberDao.plusMinusBalance(member.getUserId(), moneyIn.getMoney());
			moneyInDao.updateMoneyIn(moneyIn);
		
			rx = new ResultXml(0, "충전되었습니다", null);
		} else {
			rx = new ResultXml(0, "충전요청 상태가 아닙니다", null);
		}
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;		
	}
	
	public ModelAndView acceptMoneyOutRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ResultXml rx = null;
		String id = request.getParameter("id");
		
		MoneyOut moneyOut = moneyOutDao.selectMoneyOut(id);
		if (moneyOut.getStatus().equals(Code.MONEY_OUT_REQUEST)) {			
			moneyOut.setStatus(Code.MONEY_OUT_SUCCESS);
			moneyOut.setProcDate(new Date());
			moneyOutDao.updateMoneyOut(moneyOut);
		
			rx = new ResultXml(0, "환전되었습니다", null);
		} else {
			rx = new ResultXml(0, "환전요청 상태가 아닙니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;	
	}
}
