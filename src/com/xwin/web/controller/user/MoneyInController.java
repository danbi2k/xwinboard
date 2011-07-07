package com.xwin.web.controller.user;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Admin;
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
		if (Admin.DENY_CHARGE.equals("Y") == false)
			return new ModelAndView("illegal");
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		List<BankBook> bankBookList =
			bankBookDao.selectBankBookList(Code.BANKBOOK_STATUS_NORMAL, member.getGrade());
		
		ModelAndView mv = new ModelAndView("user/money_in_req");
		mv.addObject("bankBookList", bankBookList);
		return mv;
	}
	
	public ModelAndView viewMoneyInRequestList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (Admin.DENY_CHARGE.equals("Y") == false)
			return new ModelAndView("illegal");
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
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
		param.put("isRemoved", "N");
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
		if (Admin.DENY_CHARGE.equals("Y") == false)
			return new ModelAndView("illegal");
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
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
			
			if (money <= 0)
				rx = new ResultXml(-1, "충전 신청액을 다시 확인해 주세요", null);
			else if (_name == null || _name.length() == 0)
				rx = new ResultXml(-1, "예금주를 입력하세요", null);
			else if (existCnt > 0) {
				rx = new ResultXml(-1, "충전신청은 1건씩 가능합니다.", null);
			}
			else {			
				MoneyIn moneyIn = new MoneyIn();
				moneyIn.setUserId(member.getUserId());
				moneyIn.setGrade(member.getGrade());
				moneyIn.setMoney(money);
				moneyIn.setName(_name);
				moneyIn.setStatus(Code.MONEY_IN_REQUEST);
				moneyIn.setBankBookId(_bankBookId);
				moneyIn.setReqDate(new Date());
				moneyIn.setNickName(member.getNickName());
				moneyIn.setSource(Code.SOURCE_WEB);
				moneyInDao.insertMoneyIn(moneyIn);
		
				rx = new ResultXml(0, "캐쉬충전이 접수 되었습니다", null);
			}
		} catch (NumberFormatException e) {
			rx = new ResultXml(-1, "충전 신청액을 다시 확인해 주세요", null);
		}
		ModelAndView mv = new ModelAndView("xmlFacade");		
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView cancelMoneyInRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (Admin.DENY_CHARGE.equals("Y") == false)
			return new ModelAndView("illegal");
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ResultXml rx = null;
		
		String id = request.getParameter("id");		
		MoneyIn moneyIn = moneyInDao.selectMoneyIn(id);		
		if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST) == false)
			rx = new ResultXml(0, "취소할수 없는 충전 신청 입니다", null);
		else {
			moneyIn.setStatus(Code.MONEY_IN_CANCEL);
			moneyIn.setProcDate(new Date());
			moneyInDao.updateMoneyIn(moneyIn);			
			rx = new ResultXml(0, "충전 신청이 정상적으로 취소되었습니다", null);
		}
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;	
	}
	
	public ModelAndView removeMoneyInRequestLog(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (Admin.DENY_CHARGE.equals("Y") == false)
			return new ModelAndView("illegal");
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ResultXml rx = null;
		
		String id = request.getParameter("id");		
		MoneyIn moneyIn = moneyInDao.selectMoneyIn(id);		
		if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST))
			rx = new ResultXml(0, "진행중인 내역은 삭제 하실 수 없습니다", null);
		else {
			moneyIn.setIsRemoved("Y");
			moneyInDao.updateMoneyIn(moneyIn);			
			rx = new ResultXml(0, "충전신청 내역이 정상적으로 삭제되었습니다", null);
		}
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;	
	}
}
