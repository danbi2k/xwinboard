package com.xwin.web.controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.xwin.domain.user.Member;
import com.xwin.infra.dao.MemberDao;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;

public class LoginController extends MultiActionController
{
	public ModelAndView processLogin(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		
		Member member = memberDao.selectMember(userId);	
		
		ResultXml rx = new ResultXml();
		
		if (member == null) {
			rx.setCode(-1);
			rx.setMessage("존재하지 않는 사용자 입니다.");
		} else if (comparePassword(member.getPassword(), password)) {
			rx.setCode(0);
		} else {
			rx.setCode(-1);
			rx.setMessage("비밀번호가 틀렸습니다.");
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		HttpSession session = request.getSession();		
		session.setAttribute("Member", member);
		
		return mv;
	}
	
	private boolean comparePassword(String dbPass, String uiPass) {
		return dbPass.equals(uiPass);
	}

	public ModelAndView processLogout(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		HttpSession session = request.getSession();
		
		session.removeAttribute("Member");		
		
		ModelAndView mv = new ModelAndView("redirect:/index.aspx");
		return mv;
	}
	
	private MemberDao memberDao = null;

	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}	
}
