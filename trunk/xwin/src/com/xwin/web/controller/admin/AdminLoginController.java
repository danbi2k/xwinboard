package com.xwin.web.controller.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		
		Member admin = memberDao.selectMember(userId, Code.USER_GRADE_ADMIN);
		
		if (admin!= null && admin.getPassword().equals(password)) {
			request.getSession().setAttribute("Admin", admin);
			rx = ResultXml.SUCCESS;
		} else {
			rx = new ResultXml(-1, "관리자 정보가 잘못되었습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
}
