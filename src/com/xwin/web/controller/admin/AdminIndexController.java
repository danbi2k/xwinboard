package com.xwin.web.controller.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.web.servlet.ModelAndView;

import com.xwin.web.controller.XwinController;

public class AdminIndexController extends XwinController
{

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("admin/admin_login");
		String randomString = RandomStringUtils.randomAlphabetic(5).toLowerCase();
		HttpSession session = request.getSession();
		session.setAttribute("KEY", randomString);
		
		return mv;
	}
}