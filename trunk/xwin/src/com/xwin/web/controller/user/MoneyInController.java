package com.xwin.web.controller.user;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.BankBook;
import com.xwin.domain.user.Member;
import com.xwin.domain.user.MoneyIn;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class MoneyInController extends XwinController
{
	public ModelAndView viewMoneyInRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		List<BankBook> bankBookList =
			bankBookDao.selectBankBookList(Code.BANKBOOK_STATUS_NORMAL);
		
		ModelAndView mv = new ModelAndView("user/money_in_req");
		mv.addObject("bankBookList", bankBookList);
		return mv;
	}
	
	public ModelAndView viewMoneyInRequestList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member = (Member) request.getSession().getAttribute("Member");
		
		List<MoneyIn> moneyInList =
			moneyInDao.selectMoneyInList(member.getUserId(), null);//Code.MONEY_IN_REQUEST);
		
		ModelAndView mv = new ModelAndView("user/money_in_req_list");
		mv.addObject("moneyInList", moneyInList);
		return mv;
	}
	
	public ModelAndView moneyInRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member =
			(Member) request.getSession().getAttribute("Member");
		String _money = request.getParameter("money");
		String _name = request.getParameter("name");
		String _bankBookId = request.getParameter("bankBookId");
		
		ResultXml rx = null;
		try {
			Long money = Long.parseLong(_money);
			
			if (_name == null || _name.length() == 0)
				rx = new ResultXml(-1, "입금자를 입력하세요", null);
			else {			
				MoneyIn moneyIn = new MoneyIn();
				moneyIn.setUserId(member.getUserId());
				moneyIn.setMoney(money);
				moneyIn.setName(_name);
				moneyIn.setStatus(Code.MONEY_IN_REQUEST);
				moneyIn.setBankBookId(_bankBookId);
				moneyIn.setReqDate(new Date());
				
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
}
