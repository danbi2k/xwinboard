package com.xwin.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public class MainController extends XwinController
{

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String url = request.getRequestURL().toString();
		String retView = "";
		
		if (url.contains("bravolife") || url.contains("localhost"))
			retView = "main";
		else
			retView = "main";
		
		ModelAndView mv = new ModelAndView(retView);
		
		return mv;
	}
}