package com.xwin.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public class IndexController extends XwinController
{

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("index");
		String localName = request.getLocalName();
		if (localName.contains("vip"))
			mv.addObject("SERVER", "vip");
		else
			mv.addObject("SERVER", "kor");
		
		return mv;
	}
}