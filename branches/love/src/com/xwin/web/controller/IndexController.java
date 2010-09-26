package com.xwin.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public class IndexController extends XwinController
{

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = null;
//		if (SiteConfig.SITE_GRADE.equals(Code.USER_GRADE_VIP))
			mv = new ModelAndView("vip_login");
//		else
//			mv = new ModelAndView("nom_login");
		return mv;
	}
}