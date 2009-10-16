package com.xwin.web.controller.wap;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.user.Member;
import com.xwin.web.command.ResultWap;
import com.xwin.web.controller.XwinController;

public class WapLoginController extends XwinController
{

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member adhocMember = (Member) request.getAttribute("adhocMember");
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		String pin = request.getParameter("pin");
		
		ModelAndView mv = null;
		if (adhocMember != null && StringUtils.isNumeric(pin) && pin.length() == 6 && adhocMember.getPin().equals(pin)) {
	    	String token = Long.toString(new Date().getTime());
			
			mv = new ModelAndView("redirect:/main.wap?token=" + token);
		}
		else {
			mv = new ModelAndView("wap/" + LANG_TYPE + "/message");
			mv.addObject("resultWap", new ResultWap(-1, "PIN번호를 잘못 입력하셨습니다", "index.wap", null));
		}	
				
		return mv;
	}
}