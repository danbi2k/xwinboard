package com.xwin.web.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Access;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.controller.XwinController;

public class AdminMemberController extends XwinController
{
	public ModelAndView viewAdminMember(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String grade = XwinUtil.arcNvl(request.getParameter("grade"));
		String search = request.getParameter("search");
		String keyword = request.getParameter("keyword");
						
		List<Member> memberList = memberDao.selectMemberList(grade, search, keyword);
		
		ModelAndView mv = new ModelAndView("admin/member/admin_member");
		mv.addObject("memberList", memberList);
		return mv;
	}
	
	public ModelAndView viewMemberDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String userId = request.getParameter("userId");
				
		Member member = memberDao.selectMember(userId, null);
		
		ModelAndView mv = new ModelAndView("admin/member/admin_member_detail");
		mv.addObject("member", member);
		return mv;
	}
	
	public ModelAndView viewAccessList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		List<Access> accessList = accessDao.selectAccessList();
		ModelAndView mv = new ModelAndView("admin/member/member_access");
		mv.addObject("accessList", accessList);
		return mv;
	}
}
