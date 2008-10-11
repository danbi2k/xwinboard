package com.xwin.web.controller.user;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Account;
import com.xwin.domain.user.Member;
import com.xwin.domain.user.MoneyOut;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class MoneyOutController extends XwinController
{
	public ModelAndView viewMoneyOutRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("user/money_out_req");
		return mv;
	}
	
	public ModelAndView viewMoneyOutRequestList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member = (Member) request.getSession().getAttribute("Member");
		
		List<MoneyOut> moneyOutList =
			moneyOutDao.selectMoneyOutList(member.getUserId(), Code.MONEY_OUT_REQUEST);
		
		ModelAndView mv = new ModelAndView("user/money_out_req_list");
		mv.addObject("moneyOutList", moneyOutList);
		return mv;
	}
	
	public ModelAndView moneyOutRequest(HttpServletRequest request,
			HttpServletResponse response, MoneyOut moneyOut) throws Exception
	{
		Member member =
			(Member) request.getSession().getAttribute("Member");
		
		ResultXml rx = null;
		String pin = request.getParameter("pin");
		if (member.getPin().equals(pin) == false) {
			rx = new ResultXml(-1, "환전비밀번호가 틀렸습니다", null);
		} else if (member.getBalance() < moneyOut.getMoney()) {
			rx = new ResultXml(-1, "잔액이 부족합니다", null);
		} else {
			moneyOut.setUserId(member.getUserId());
			moneyOut.setStatus(Code.MONEY_OUT_REQUEST);
			moneyOut.setReqDate(new Date());
			moneyOut.setNickName(member.getNickName());
			moneyOutDao.insertMoneyOut(moneyOut);
			
			Account account = new Account();
			account.setUserId(member.getUserId());
			account.setType(Code.ACCOUNT_TYPE_MONEYOUT);
			account.setDate(new Date());
			account.setOldBalance(member.getBalance());
			account.setMoney(moneyOut.getMoney() * -1);
			account.setBalance(member.getBalance() - moneyOut.getMoney());
			account.setMoneyOutId(moneyOut.getId());
			
			accountDao.insertAccount(account);		
			memberDao.plusMinusBalance(member.getUserId(), moneyOut.getMoney() * -1);
			
			member.setBalance(member.getBalance() - moneyOut.getMoney());
			
			rx = new ResultXml(0, "환전신청이 등록되었습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
}
