package com.xwin.web.controller.test;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.xwin.domain.user.Member;
import com.xwin.infra.dao.MemberDao;

public class TestController implements Controller
{

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		
		ModelAndView mv = new ModelAndView("xmlTest");
		Member member = memberDao.selectMember("xx");
		request.getSession().setAttribute("Member", member);
		
		return mv;
	}
	
	private MemberDao memberDao = null;

	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}
}
