package com.xwin.web.controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.xwin.domain.user.Member;
import com.xwin.infra.dao.MemberDao;

public class JoinMemberController extends MultiActionController
{
	public ModelAndView joinForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("user/join");
		
		return mv;
	}
	
	public ModelAndView checkExistUserId(HttpServletRequest request, 
			HttpServletResponse response) throws Exception
	{
		String userId = request.getParameter("id");
		
		ModelAndView mv = new ModelAndView("user/checkIdDup");
		if (userId == null || userId.length() == 0) {
			mv.addObject("status", "empty");
		}
		
		else {
			Integer count = memberDao.countMemberByUserId(userId);
		
			if (count > 0) {
				mv.addObject("status", "dup");
			} else {
				mv.addObject("status", "ok");
			}
		}
		
		return mv;
	}
	
	public ModelAndView checkExistNickName(HttpServletRequest request, 
			HttpServletResponse response) throws Exception
	{
		String nickName = request.getParameter("nick");
		
		ModelAndView mv = new ModelAndView("user/checkNickDup");
		if (nickName == null || nickName.length() == 0) {
			mv.addObject("status", "empty");
		}
		
		else {
			Integer count = memberDao.countMemberByNickName(nickName);
		
			if (count > 0) {
				mv.addObject("status", "dup");
			} else {
				mv.addObject("status", "ok");
			}
		}
		
		return mv;
	}
	
	public ModelAndView createMember(HttpServletRequest request,
			HttpServletResponse response, Member command) throws Exception
	{
		Member member = (Member) command;
		ModelAndView mv = new ModelAndView("");
		
		memberDao.insertMember(member);
		
		return mv;
	}
	
	public ModelAndView removeMember(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id = request.getParameter("id");
		memberDao.deleteMember(id);
		
		ModelAndView mv = new ModelAndView("");
		return mv;
	}
	
	private MemberDao memberDao = null;

	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}	
}
