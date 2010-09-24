package com.xwin.web.controller.wap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.user.Member;
import com.xwin.web.command.ResultWap;
import com.xwin.web.controller.XwinController;

public class WapIndexController extends XwinController
{

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = null;
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		Member adhocMember = (Member) request.getAttribute("adhocMember");
		
		if (LANG_TYPE != null) {
			if (adhocMember != null) {
				mv = new ModelAndView("wap/" + LANG_TYPE + "/user_index");
			}
			else {
				mv = new ModelAndView("wap/" + LANG_TYPE + "/message");
				mv.addObject("resultWap", new ResultWap(-1, "등록된 사용자가 아닙니다", "index.wap", null));
			}			
		} else {
			mv = new ModelAndView("wap/message");
			mv.addObject("resultWap", new ResultWap(-1, "폰정보를 읽지 못하였습니다", "index.wap", null));
		}
				
		return mv;
	}
}