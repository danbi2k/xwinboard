package com.xwin.web.controller.dealer;

import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Access;
import com.xwin.domain.user.Dealer;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class DealerLoginController extends XwinController
{
	public ModelAndView processLogin(HttpServletRequest request, 
			HttpServletResponse response) throws Exception
	{
		HttpSession session = request.getSession();
		
		ResultXml rx = null;
		String dealerId = request.getParameter("dealerId");
		String password = request.getParameter("password");

		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("dealerId", dealerId);
		Dealer dealer = dealerDao.selectDealer(param);
		
		if (dealer != null && dealer.getPassword().equals(XwinUtil.getUserPassword(password))) {
			session.setAttribute("Dealer", dealer);
			
			rx = ResultXml.SUCCESS;
			
			Access access = new Access();
			access.setDate(new Date());
			access.setUserId(dealer.getDealerId());
			access.setNickName(dealer.getDealerId());
			access.setIpAddress(request.getRemoteAddr());
			access.setType(Code.ACCESS_DEALER_LOGIN);
			access.setPin("");
			
			accessDao.insertAccess(access);
		}
		else {
			rx = new ResultXml(-1, "로그인 정보가 잘못되었습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView processLogout(HttpServletRequest request,
			HttpServletResponse reponse) throws Exception
	{
		HttpSession session = request.getSession();
		
		session.removeAttribute("Dealer");		
		
		ModelAndView mv = new ModelAndView("redirect:/");
		return mv;
	}
}
