package com.xwin.web.controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.user.Member;
import com.xwin.web.command.MemberCommand;
import com.xwin.web.controller.XwinController;

public class MemberController extends XwinController
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
			HttpServletResponse response, MemberCommand command) throws Exception
	{
		Member member = new Member();
		member.setUserId(command.getId());
		member.setPassword(command.getPw());
		member.setNickName(command.getNick());
		member.setMobile(command.getPhone());
		member.setEmail(command.getEmail());
		member.setPin(command.getOut_pw());		
		memberDao.insertMember(member);
		
		ModelAndView mv = new ModelAndView("index");
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
}
