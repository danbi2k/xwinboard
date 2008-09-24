package com.xwin.web.controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.xwin.domain.user.Member;
import com.xwin.infra.dao.MemberDao;

public class LoginController extends MultiActionController
{
	public ModelAndView processLogin(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		
		Member member = memberDao.selectMember(userId);
	
		ModelAndView mv = new ModelAndView("");
		return mv;
		
		if (member == null) {
			
		} else if (comparePassword(member.getPassword(), password)) {
			
		} else {
			
		}
	}
	
	private boolean comparePassword(String dbPass, String uiPass) {
		return dbPass.equals(uiPass);
	}

	public ModelAndView processLogout(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		
		
		
		ModelAndView mv = new ModelAndView("");
		return mv;
	}
	
	private MemberDao memberDao = null;

	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}	
}
