package com.xwin.web.controller.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Account;
import com.xwin.domain.user.Member;
import com.xwin.web.controller.XwinController;

public class MyMoneyController extends XwinController
{
	public ModelAndView viewMyMoneyList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member = (Member) request.getSession().getAttribute("Member");
		
		List<Account> accountList = accountDao.selectAccountList(member.getUserId(), null);
		ModelAndView mv = new ModelAndView("user/my_money");
		mv.addObject("accountList", accountList);
		return mv;
	}
}
