package com.xwin.web.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Access;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminLoginController extends XwinController
{
	private static Map<String, Integer> TRY_IP = new HashMap<String, Integer>();
	
	public ModelAndView processLogin(HttpServletRequest request, 
			HttpServletResponse response) throws Exception
	{
		ResultXml rx = null;
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		String pin = request.getParameter("pin");
		
		Member admin = memberDao.selectMember(userId, Code.USER_GRADE_ADMIN);
		String ip = request.getRemoteAddr();
		TRY_IP.put(ip, XwinUtil.ntz(TRY_IP.get(ip))+1);			
		Integer tryCount = TRY_IP.get(ip);
		if (tryCount > 5) {
			rx = new ResultXml(-1, "로그인 시도 횟수를 초과 하였습니다. 접속을 차단 합니다.", null);
		} 
		else if (admin!= null && admin.getPassword().equals(password) && admin.getPin().equals(pin)) {
				TRY_IP.remove(ip);
				request.getSession().setAttribute("Admin", admin);
				rx = ResultXml.SUCCESS;
				
				Access access = new Access();
				access.setDate(new Date());
				access.setUserId(admin.getUserId());
				access.setNickName(admin.getNickName());
				access.setIpAddress(request.getRemoteAddr());
				access.setType(Code.ACCESS_ADMIN_LOGIN);
				
				accessDao.insertAccess(access);
		}
		else {
			rx = new ResultXml(-1, "관리자 정보가 잘못되었습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView processLogout(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		HttpSession session = request.getSession();
		
		session.removeAttribute("Admin");		
		
		ModelAndView mv = new ModelAndView("redirect:/");
		return mv;
	}
}
