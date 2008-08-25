package com.xwin.web.controller;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.xwin.infra.sms.KtfSmsConnector;


public class KtfSmsController implements Controller {

	private KtfSmsConnector ktfSmsConnector = null;
	
	public ModelAndView handleRequest(HttpServletRequest arg0,
			HttpServletResponse arg1) throws Exception {
		
		ktfSmsConnector.processDbTranscation();
		
		ModelAndView mv = new ModelAndView("ktfsms");
		mv.addObject("smsList", ktfSmsConnector.getMessageList());
		
		return mv;
	}
	
	public void setKtfSmsConnector(KtfSmsConnector ktfSmsConnector) {
		this.ktfSmsConnector = ktfSmsConnector;
	}
}
