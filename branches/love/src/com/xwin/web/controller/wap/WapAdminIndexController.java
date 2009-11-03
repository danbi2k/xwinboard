package com.xwin.web.controller.wap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.web.command.ResultWap;
import com.xwin.web.controller.XwinController;

public class WapAdminIndexController extends XwinController
{
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = null;
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		
		if (LANG_TYPE != null) {
				mv = new ModelAndView("wap/" + LANG_TYPE + "/admin_index");
		} else {
			mv = new ModelAndView("wap/message");
			mv.addObject("resultWap", new ResultWap(-1, "폰정보를 읽지 못하였습니다", "index.wap", null));
		}
				
		return mv;
	}
}