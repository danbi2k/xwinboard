package com.xwin.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public class IndexController extends XwinController
{

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("user_login");
		
		return mv;
	}
}