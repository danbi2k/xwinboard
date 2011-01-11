package com.xwin.web.controller.join;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Admin;
import com.xwin.domain.join.Invitation;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class JoinController extends XwinController
{
	public ModelAndView viewJoinLoginForm(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		ModelAndView mv = new ModelAndView("join/join_login");
		
		return mv;
	}
	
	public ModelAndView processJoinLogin(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		String inviteKey = request.getParameter("inviteKey");
		String userId = request.getParameter("userId");
		
		ResultXml rx = null;
		
		Invitation invitation = invitationDao.selectInvitation(userId, inviteKey);
		if (invitation != null && invitation.getJoinId() == null) {
			HttpSession session = request.getSession();
			session.setAttribute("INVITATION", invitation);
			
			rx = ResultXml.SUCCESS;
		} else {
			rx = new ResultXml(-1, "사용할수 없는 초대장 입니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView viewJoinForm(HttpServletRequest request,
		HttpServletResponse response) throws Exception
	{
		ModelAndView mv = null;
		HttpSession session = request.getSession();
		
		if (Admin.SITE_GRADE.equals(Code.USER_GRADE_VIP)) {
			Invitation invitation = (Invitation) session.getAttribute("INVITATION");
			if (invitation != null)
				mv = new ModelAndView("join/join");
			else
				mv = new ModelAndView("dummy");
		} else if (Admin.SITE_GRADE.equals(Code.USER_GRADE_NORMAL)) {
			mv = new ModelAndView("join/join");
		}
		
		return mv;
	}
}