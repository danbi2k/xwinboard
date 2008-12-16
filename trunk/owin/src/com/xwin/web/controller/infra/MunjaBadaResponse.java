package com.xwin.web.controller.infra;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Admin;
import com.xwin.web.controller.XwinController;

public class MunjaBadaResponse extends XwinController
{
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String cols = request.getParameter("cols");
		
		adminDao.updateAdmin("SMS_REMAIN", cols);
		Admin.SMS_REMAIN = cols;
		
		ModelAndView mv = new ModelAndView("null");
		return mv;
	}	
}
