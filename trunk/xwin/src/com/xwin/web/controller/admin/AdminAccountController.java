package com.xwin.web.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	int ROWSIZE = 20;
	
	public ModelAndView viewMoneyInList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = request.getParameter("keyword");
		String status = request.getParameter("status");
		
		String searchDate = XwinUtil.arcNvl(request.getParameter("searchDate"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (keyword != null) param.put(search + "Like", "%" + keyword + "%");
		param.put("status", status);
		
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		param.put("isDeleted", "N");
		
		List<MoneyIn> moneyInList = moneyInDao.selectMoneyInList(param);
		Integer moneyInCount = moneyInDao.selectMoneyInCount(param);
		
		ModelAndView mv = null;
		if (status.equals(Code.MONEY_IN_REQUEST))
			mv = new ModelAndView("admin/account/money_in_req");
		else if (status.equals(Code.MONEY_IN_SUCCESS))
			mv = new ModelAndView("admin/account/money_in");
		else if (status.equals(Code.MONEY_IN_DIRECT))
			mv = new ModelAndView("admin/account/money_direct");
		mv.addObject("moneyInOutList", moneyInList);
		mv.addObject("totalCount", moneyInCount);
		
		return mv;
	}
	
	public ModelAndView viewMoneyOutList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = request.getParameter("keyword");
		String status = request.getParameter("status");
		
		String searchDate = XwinUtil.arcNvl(request.getParameter("searchDate"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (keyword != null) param.put(search + "Like", "%" + keyword + "%");
		param.put("status", status);
		
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		param.put("isDeleted", "N");
		
		List<MoneyOut> moneyOutList = moneyOutDao.selectMoneyOutList(param);
		Integer moneyOutCount = moneyOutDao.selectMoneyOutCount(param);
		
		ModelAndView mv = null;
		if (status.equals(Code.MONEY_OUT_REQUEST))
			mv = new ModelAndView("admin/account/money_out_req");
		else if (status.equals(Code.MONEY_OUT_SUCCESS))
			mv = new ModelAndView("admin/account/money_out");
		else if (status.equals(Code.MONEY_OUT_DIRECT))
			mv = new ModelAndView("admin/account/money_direct");
		mv.addObject("moneyInOutList", moneyOutList);
		mv.addObject("totalCount", moneyOutCount);
		
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
	
	public ModelAndView directCharging(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ResultXml rx = null;
		String userId = request.getParameter("userId");
		String _money = request.getParameter("money");
		
		Long money = null;
		try {
			money = Long.parseLong(_money);
		} catch (Exception e) {
			rx = new ResultXml(-1, "숫자를 입력하세요", null);
		}
		
		if (money != null) {
			Member member = memberDao.selectMember(userId, null);
			
			MoneyIn moneyIn = new MoneyIn();
			moneyIn.setMoney(money);
			moneyIn.setProcDate(new Date());
			moneyIn.setStatus(Code.MONEY_IN_DIRECT);
			moneyIn.setUserId(userId);
			moneyIn.setNickName(member.getNickName());
			moneyInDao.insertMoneyIn(moneyIn);
			
			Account account = new Account();
			account.setUserId(member.getUserId());
			account.setType(Code.ACCOUNT_TYPE_MONEYIN_DIRECT);
			account.setDate(new Date());
			account.setOldBalance(member.getBalance());
			account.setMoney(moneyIn.getMoney());
			account.setBalance(member.getBalance() + moneyIn.getMoney());
			account.setMoneyInId(moneyIn.getId());
			
			accountDao.insertAccount(account);
			
			memberDao.plusMinusBalance(userId, money);
			rx = new ResultXml(0, "직충전 되었습니다", null);
		}
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;		
	}
	
	public ModelAndView directMinusCharging(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ResultXml rx = null;
		String userId = request.getParameter("userId");
		String _money = request.getParameter("money");
		
		Long money = null;
		try {
			money = Long.parseLong(_money);
		} catch (Exception e) {
			rx = new ResultXml(-1, "숫자를 입력하세요", null);
		}
		
		if (money != null) {
			Member member = memberDao.selectMember(userId, null);
			
			if (member.getBalance() < money) {
				rx = new ResultXml(-1, "잔액을 초과하였습니다", null);
			} 
			else {
				MoneyOut moneyOut = new MoneyOut();
				moneyOut.setMoney(money);
				moneyOut.setProcDate(new Date());
				moneyOut.setStatus(Code.MONEY_OUT_DIRECT);
				moneyOut.setUserId(userId);
				moneyOut.setNickName(member.getNickName());
				moneyOutDao.insertMoneyOut(moneyOut);
				
				Account account = new Account();
				account.setUserId(member.getUserId());
				account.setType(Code.ACCOUNT_TYPE_MONEYOUT_DIRECT);
				account.setDate(new Date());
				account.setOldBalance(member.getBalance());
				account.setMoney(moneyOut.getMoney());
				account.setBalance(member.getBalance() + moneyOut.getMoney());
				account.setMoneyInId(moneyOut.getId());
				
				accountDao.insertAccount(account);
				
				memberDao.plusMinusBalance(userId, money * -1);
				rx = new ResultXml(0, "직차감 되었습니다", null);
			}
		}	
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;		
	}
	
	public ModelAndView deleteMoneyIn(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id = request.getParameter("id");
		
		moneyInDao.deleteMoneyIn(id);
		
		ResultXml rx = ResultXml.SUCCESS;
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;	
	}
	
	public ModelAndView deleteMoneyOut(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id = request.getParameter("id");
		
		moneyInDao.deleteMoneyIn(id);
		
		ResultXml rx = ResultXml.SUCCESS;
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;	
	}
}
