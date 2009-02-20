package com.xwin.web.controller.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminLoginController extends XwinController
{
	public ModelAndView processLogin(HttpServletRequest request, 
			HttpServletResponse response) throws Exception
	{
		ResultXml rx = null;
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		String pin = request.getParameter("pin");
		
		Member admin = memberDao.selectMember(userId, Code.USER_GRADE_ADMIN);
		
		if (admin!= null && admin.getPassword().equals(password) && admin.getPin().equals(pin)) {
			request.getSession().setAttribute("Admin", admin);
			rx = ResultXml.SUCCESS;
		} else {
			rx = new ResultXml(-1, "관리자 정보가 잘못되었습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView processLogout(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		HttpSession session = request.getSession();
		
		session.removeAttribute("Admin");		
		
		ModelAndView mv = new ModelAndView("redirect:/");
		return mv;
	}
}
