package com.xwin.web.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Access;
import com.xwin.domain.log.OtpLog;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminLoginController extends XwinController
{
	private static Map<String, Integer> TRY_IP = new HashMap<String, Integer>();
	
	private Map<String, String> authPhone = new HashMap<String, String>();
	
	public ModelAndView processLogin(HttpServletRequest request, 
			HttpServletResponse response) throws Exception
	{
		HttpSession session = request.getSession();
		String sessionpin = (String) session.getAttribute("KEY");
		session.removeAttribute("KEY");
		String adminPin = XwinUtil.getKeyPassword(sessionpin);
		
		ResultXml rx = null;
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		String pin = request.getParameter("pin");
		Integer n = 0;
		
		if (userId.startsWith("(") || userId.endsWith(")")) {
			String tmpUserId = userId;
			userId = tmpUserId.substring(1, tmpUserId.length()-3);
			String sn = tmpUserId.substring(tmpUserId.length()-3, tmpUserId.length()-1);
			n = Integer.parseInt(sn);
		}
		
		Member admin = memberDao.selectMember(userId, Code.USER_GRADE_ADMIN);
		String ip = request.getRemoteAddr();
		TRY_IP.put(ip, XwinUtil.ntz(TRY_IP.get(ip))+1);
		Integer tryCount = TRY_IP.get(ip);
		
		if (tryCount > 5) {
			Access tryAccess = new Access();
			tryAccess.setDate(new Date());
			tryAccess.setUserId(userId);
			tryAccess.setNickName("");
			tryAccess.setIpAddress(request.getRemoteAddr());
			tryAccess.setType(Code.ACCESS_ADMIN_LOGIN_DENY);
			tryAccess.setPin(pin);
			
			accessDao.insertAccess(tryAccess);
			
			rx = new ResultXml(-1, "로그인 시도 횟수를 초과 하였습니다. 접속을 차단 합니다.", null);
		} 
		else if (
				adminPin != null &&
				admin != null &&
				admin.getPassword().equals(XwinUtil.getAdminPassword(password)) &&
				adminPin.equals(pin)) {
			TRY_IP.remove(ip);
			admin.setLoginIpAddress(ip);
			request.getSession().setAttribute("Admin", admin);
			if (n > 0)
				request.getSession().setAttribute("(Admin)", n);
			rx = ResultXml.SUCCESS;
			
			Access access = new Access();
			access.setDate(new Date());
			access.setUserId(admin.getUserId());
			access.setNickName(admin.getNickName());
			access.setIpAddress(request.getRemoteAddr());
			access.setType(Code.ACCESS_ADMIN_LOGIN_SUCCESS);
			access.setPin(pin);
			
			accessDao.insertAccess(access);
		}
		else {
			Access access = new Access();
			access.setDate(new Date());
			access.setUserId(userId);
			access.setNickName("");
			access.setIpAddress(request.getRemoteAddr());
			access.setType(Code.ACCESS_ADMIN_LOGIN_FAILURE);
			access.setPin(pin);
			
			accessDao.insertAccess(access);
			
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
	
	public ModelAndView processCookie(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		HttpSession session = request.getSession();
		
		String cookie = request.getParameter("cookie");
		String value = authPhone.get(cookie);
		if (value != null) {
			int pin = (int) (Math.random() * 10000);
			session.setAttribute("OTP", pin);
			String pinStr = "" + pin;
			
			OtpLog otpLog = new OtpLog();
			otpLog.setDate(new Date());
			otpLog.setPhone(value);
			otpLog.setPin(pinStr);
			otpLog.setIpAddress(request.getRemoteAddr());
			otpLogDao.insertOtpLog(otpLog);
			
			sendSmsConnector.sendSms(pinStr, value, "0000");
		}
		
		ModelAndView mv = new ModelAndView("redirect:/");
		return mv;
	}

	public void setAuthPhone(Map<String, String> authPhone) {
		this.authPhone = authPhone;
	}
}
