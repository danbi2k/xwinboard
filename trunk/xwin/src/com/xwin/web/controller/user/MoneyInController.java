package com.xwin.web.controller.user;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.BankBook;
import com.xwin.domain.user.Member;
import com.xwin.domain.user.MoneyIn;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class MoneyInController extends XwinController
{
	int ROWSIZE = 15;
	
	public ModelAndView viewMoneyInRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		List<BankBook> bankBookList =
			bankBookDao.selectBankBookList(Code.BANKBOOK_STATUS_NORMAL);
		
		ModelAndView mv = new ModelAndView("user/money_in_req");
		mv.addObject("bankBookList", bankBookList);
		return mv;
	}
	
	public ModelAndView viewMoneyInRequestList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		Member member = (Member) request.getSession().getAttribute("Member");
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", member.getUserId());
		param.put("notStatus", Code.MONEY_IN_DIRECT);
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<MoneyIn> moneyInList =	moneyInDao.selectMoneyInList(param);
		Integer moneyInCount = moneyInDao.selectMoneyInCount(param);
		
		ModelAndView mv = new ModelAndView("user/money_in_req_list");
		mv.addObject("moneyInList", moneyInList);
		mv.addObject("moneyInCount", moneyInCount);
		return mv;
	}
	
	public ModelAndView moneyInRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		Member member =
			(Member) request.getSession().getAttribute("Member");
		String _money = request.getParameter("money");
		String _name = request.getParameter("name");
		String _bankBookId = request.getParameter("bankBookId");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", member.getUserId());
		param.put("status", Code.MONEY_IN_REQUEST);
		Integer existCnt = moneyInDao.selectMoneyInCount(param);
		
		ResultXml rx = null;
		try {
			Long money = Long.parseLong(_money);
			
			
			if (_name == null || _name.length() == 0)
				rx = new ResultXml(-1, "입금자를 입력하세요", null);
			else if (existCnt > 0) {
				rx = new ResultXml(-1, "이미 신청하신 충전요청이 있습니다", null);
			}
			else {			
				MoneyIn moneyIn = new MoneyIn();
				moneyIn.setUserId(member.getUserId());
				moneyIn.setMoney(money);
				moneyIn.setName(_name);
				moneyIn.setStatus(Code.MONEY_IN_REQUEST);
				moneyIn.setBankBookId(_bankBookId);
				moneyIn.setReqDate(new Date());
				moneyIn.setNickName(member.getNickName());
				moneyInDao.insertMoneyIn(moneyIn);
		
				rx = new ResultXml(0, "머니충전이 요청되었습니다", null);
			}
		} catch (NumberFormatException e) {
			rx = new ResultXml(-1, "입금 예정액을 입력하세요", null);
		}
		ModelAndView mv = new ModelAndView("xmlFacade");		
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView cancelMoneyInRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ResultXml rx = null;
		
		String id = request.getParameter("id");		
		MoneyIn moneyIn = moneyInDao.selectMoneyIn(id);		
		if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST) == false)
			rx = new ResultXml(0, "충전요청 상태가 아닙니다", null);
		else {
			moneyIn.setStatus(Code.MONEY_IN_CANCEL);
			moneyIn.setProcDate(new Date());
			moneyInDao.updateMoneyIn(moneyIn);			
			rx = new ResultXml(0, "충전 신청이 취소되었습니다", null);
		}
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;	
	}
}
