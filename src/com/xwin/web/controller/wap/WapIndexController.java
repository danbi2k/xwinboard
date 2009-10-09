package com.xwin.web.controller.wap;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.web.command.ResultWap;
import com.xwin.web.controller.XwinController;

public class WapIndexController extends XwinController
{

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = null;
		//String http_phone_number = request.getHeader("http_phone_number");
		String http_phone_number = "8201073317594";
		if (http_phone_number != null) {
			String connectedMobile = adjustMobileFormat(http_phone_number);
			
			Member member = selectValidMemberByMobile(connectedMobile);
			if (member != null) {
				mv = new ModelAndView("wap/index");
				mv.addObject("member", member);
			}
			else {
				mv = new ModelAndView("wap/error");
				mv.addObject("resultWap", new ResultWap(-1, "등록된 사용자가 아닙니다", "index.wap", null));
			}			
		} else {
			mv = new ModelAndView("wap/error");
			mv.addObject("resultWap", new ResultWap(-1, "폰정보를 읽지 못하였습니다", "index.wap", null));
		}
				
		return mv;
	}

	private String adjustMobileFormat(String mobile) {
		String connectedMobile = mobile.substring(2);
		if (connectedMobile.length() == 11) {
			connectedMobile = connectedMobile.substring(0, 3) + "-" + connectedMobile.substring(3, 7) + "-" + connectedMobile.substring(7);
		} else if (connectedMobile.length() == 10) {
			connectedMobile = connectedMobile.substring(0, 3) + "-" + connectedMobile.substring(3, 6) + "-" + connectedMobile.substring(6);
		}
		
		return connectedMobile;
	}
	
	private Member selectValidMemberByMobile(String mobile) {
		Map<String, Object> param = new HashMap<String, Object>(3);
		param.put("mobile", mobile);
		param.put("status", Code.USER_STATUS_NORMAL);
		param.put("grade", Code.USER_GRADE_VIP);
		
		return memberDao.selectMember(param);
	}
}