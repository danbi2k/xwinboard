package com.xwin.web.controller.wap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.user.Member;
import com.xwin.web.controller.XwinController;

public class WapMainController extends XwinController
{

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("redirect:/index.wap");
		
		member = memberDao.selectMember(member.getUserId(), member.getGrade());
		ModelAndView mv = new ModelAndView("wap/main");
		mv.addObject("Member", member);
				
		return mv;
	}
}