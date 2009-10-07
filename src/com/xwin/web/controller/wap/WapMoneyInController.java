package com.xwin.web.controller.wap;

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
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultWap;
import com.xwin.web.controller.XwinController;

public class WapMoneyInController extends XwinController
{
	public ModelAndView viewMoneyInRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member =	(Member) request.getSession().getAttribute("Member");		
		if (member == null)
			return new ModelAndView("redirect:/index.wap");
		
		List<BankBook> bankBookList =
			bankBookDao.selectBankBookList(Code.BANKBOOK_STATUS_NORMAL, member.getGrade());
		
		ModelAndView mv = new ModelAndView("wap/money_in_request");
		mv.addObject("bankBookList", bankBookList);
		return mv;
	}

	public ModelAndView moneyInRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member =	(Member) request.getSession().getAttribute("Member");		
		if (member == null)
			return new ModelAndView("redirect:/index.wap");
		
		member = memberDao.selectMember(member.getUserId(), null);
		
		String _money = request.getParameter("money");
		String _name = request.getParameter("name");
		String _bankBookId = request.getParameter("bankBookId");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", member.getUserId());
		param.put("status", Code.MONEY_IN_REQUEST);
		Integer existCnt = moneyInDao.selectMoneyInCount(param);
		
		ResultWap rw = null;
		try {
			Long money = Long.parseLong(_money);
			
			if (money <= 0)
				rw = new ResultWap(-1, "충전 신청액을 다시 확인해 주세요", "earncache.wap?mode=viewMoneyInRequest", null);
			else if (_name == null || _name.length() == 0)
				rw = new ResultWap(-1, "예금주를 입력하세요", "earncache.wap?mode=viewMoneyInRequest", null);
			else if (existCnt > 0) {
				rw = new ResultWap(-1, "충전신청은 1건씩 가능합니다.", "earncache.wap?mode=viewMoneyInRequest", null);
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
		
				rw = new ResultWap(0, "캐쉬충전이 접수 되었습니다", "earncache.wap?mode=viewMoneyInRequestList", null);
			}
		} catch (NumberFormatException e) {
			rw = new ResultWap(-1, "충전 신청액을 다시 확인해 주세요", "earncache.wap?mode=viewMoneyInRequest", null);
		}
		ModelAndView mv = new ModelAndView("wap/error");		
		mv.addObject("resultWap", rw);
		return mv;
	}
	
	public ModelAndView viewMoneyInRequestList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{		
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", member.getUserId());
		param.put("notStatus", Code.MONEY_IN_DIRECT);
		param.put("isRemoved", "N");
		param.put("fromRow", 0);
		param.put("rowSize", 5);
		
		List<MoneyIn> moneyInList =	moneyInDao.selectMoneyInList(param);
		Integer moneyInCount = moneyInDao.selectMoneyInCount(param);
		
		ModelAndView mv = new ModelAndView("wap/money_in_request_list");
		mv.addObject("moneyInList", moneyInList);
		mv.addObject("moneyInCount", moneyInCount);
		return mv;
	}
}