package com.xwin.web.controller.wap;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.user.Member;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultWap;
import com.xwin.web.controller.XwinController;

public class WapLoginController extends XwinController
{

	public ModelAndView processPinLogin(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member adhocMember = (Member) request.getAttribute("adhocMember");
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		String pin = request.getParameter("pin");
		
		ModelAndView mv = null;
		if (StringUtils.isNumeric(pin) && pin.length() == 6 && adhocMember.getPin().equals(pin)) {
	    	String token = Long.toString(new Date().getTime());
			
			mv = new ModelAndView("redirect:/main.wap?token=" + token);
		}
		else {
			mv = new ModelAndView("wap/" + LANG_TYPE + "/message");
			mv.addObject("resultWap", new ResultWap(-1, "PIN번호를 잘못 입력하셨습니다", "index.wap", null));
		}	
				
		return mv;
	}
	
	public ModelAndView processUserLogin(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member adhocMember = (Member) request.getAttribute("adhocMember");
		String LANG_TYPE = (String) request.getAttribute("LANG_TYPE");
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		
		ModelAndView mv = null;
		if (adhocMember.getUserId().equals(userId) == false) {
			mv = new ModelAndView("wap/" + LANG_TYPE + "/message");
			mv.addObject("resultWap", new ResultWap(-1, "접속하신 휴대전화로 등록된 아이디가 아닙니다.\n아이디를 확인해 주세요", "index.wap", null));
		} else if (comparePassword(adhocMember.getPassword(), password) == false) {
			mv = new ModelAndView("wap/" + LANG_TYPE + "/message");
			mv.addObject("resultWap", new ResultWap(-1, "패스워드를 정확히 입력해주세요", "index.wap", null));
		}
		else {
	    	String token = Long.toString(new Date().getTime());
			
			mv = new ModelAndView("redirect:/main.wap?token=" + token);
		}	
				
		return mv;
	}

	private boolean comparePassword(String dbPass, String uiPass) {
		String encodedPass = XwinUtil.getUserPassword(uiPass);
		return dbPass.equals(encodedPass);
	}
}