package com.xwin.web.controller.user;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.user.Account;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AccountController extends XwinController
{
	public ModelAndView moneyInRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member =
			(Member) request.getSession().getAttribute("Member");
		String _money = request.getParameter("money");		
		Integer money = Integer.parseInt(_money);
		
		Account account = new Account();
		account.setUserId(member.getUserId());
		account.setMoney(money);
		account.setType("IN_REQ");
		account.setDate(new Date());
		
		accountDao.insertAccount(account);

		List<Account> accountList =
			accountDao.selectAccountListByUserId(member.getUserId());
		
		ResultXml rx = new ResultXml(0, null, accountList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView moneyOutRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member =
			(Member) request.getSession().getAttribute("Member");
		String _money = request.getParameter("money");		
		Integer money = Integer.parseInt(_money);
		
		Account account = new Account();
		account.setUserId(member.getUserId());
		account.setMoney(money);
		account.setType("OUT_REQ");
		account.setDate(new Date());
		
		accountDao.insertAccount(account);
		memberDao.plusMinusBalance(member.getUserId(), money);
		
		List<Account> accountList =
			accountDao.selectAccountListByUserId(member.getUserId());
		
		ResultXml rx = new ResultXml(0, null, accountList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView getAccountInfo(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member =
			(Member) request.getSession().getAttribute("Member");
		
		List<Account> accountList =
			accountDao.selectAccountListByUserId(member.getUserId());
		
		ResultXml rx = new ResultXml(0, null, accountList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
}
