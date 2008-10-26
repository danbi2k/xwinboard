package com.xwin.web.controller.user;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Account;
import com.xwin.domain.admin.Admin;
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
		if (Admin.DENY_EXCHANGE.equals("Y") == false)
			return new ModelAndView("illegal");
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ModelAndView mv = new ModelAndView("user/money_out_req");
		return mv;
	}
	
	public ModelAndView viewMoneyOutRequestList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (Admin.DENY_EXCHANGE.equals("Y") == false)
			return new ModelAndView("illegal");
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		Member member = (Member) request.getSession().getAttribute("Member");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", member.getUserId());
		param.put("notStatus", Code.MONEY_OUT_DIRECT);
		
		List<MoneyOut> moneyOutList = moneyOutDao.selectMoneyOutList(param);
		
		ModelAndView mv = new ModelAndView("user/money_out_req_list");
		mv.addObject("moneyOutList", moneyOutList);
		return mv;
	}
	
	public synchronized ModelAndView moneyOutRequest(HttpServletRequest request,
			HttpServletResponse response, MoneyOut moneyOut) throws Exception
	{
		if (Admin.DENY_EXCHANGE.equals("Y") == false)
			return new ModelAndView("illegal");
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		Member member =
			(Member) request.getSession().getAttribute("Member");
		
		member = memberDao.selectMember(member.getUserId(), null);
		
		ResultXml rx = null;
		String pin = request.getParameter("pin");
		if ((moneyOut.getMoney() % 10000) > 0) {
			rx = new ResultXml(-1, "10,000원 단위로 신청하세요", null);
		}
		else if (member.getPin().equals(pin) == false) {
			rx = new ResultXml(-1, "환전비밀번호가 틀렸습니다", null);
		}
		else if (member.getBalance() < moneyOut.getMoney()) {
			rx = new ResultXml(-1, "잔액이 부족합니다", null);
		}
		else {
			moneyOut.setUserId(member.getUserId());
			moneyOut.setStatus(Code.MONEY_OUT_REQUEST);
			moneyOut.setReqDate(new Date());
			moneyOut.setNickName(member.getNickName());
			moneyOut.setBankName(member.getBankName());
			moneyOut.setNumber(member.getBankNumber());
			moneyOut.setName(member.getBankOwner());
			
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
