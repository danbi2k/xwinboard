package com.xwin.web.controller.user;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

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
			moneyOutDao.selectMoneyOutList(member.getUserId(), null);//Code.MONEY_OUT_REQUEST);
		
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
		if (member.getPin().equals(pin)) {
			moneyOut.setUserId(member.getUserId());
			moneyOut.setStatus(Code.MONEY_OUT_REQUEST);
			moneyOut.setReqDate(new Date());
			
			moneyOutDao.insertMoneyOut(moneyOut);
			
			rx = new ResultXml(0, "출금신청이 등록되었습니다", null);
		} else {
			rx = new ResultXml(-1, "출금비밀번호가 틀렸습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
}
