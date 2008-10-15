package com.xwin.web.controller.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Account;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.controller.XwinController;

public class MyMoneyController extends XwinController
{
	int ROWSIZE = 15;
	
	public ModelAndView viewMyMoneyList(HttpServletRequest request,
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
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		param.put("userId", member.getUserId());
		
		List<Account> accountList = accountDao.selectAccountList(param);
		Integer accountCount = accountDao.selectAccountCount(param);
		
		ModelAndView mv = new ModelAndView("user/my_money");
		mv.addObject("accountList", accountList);
		mv.addObject("accountCount", accountCount);
		return mv;
	}
}
