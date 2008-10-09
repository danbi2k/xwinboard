package com.xwin.web.controller.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.Indicator;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminController extends XwinController
{
	public ModelAndView getIndicator(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Indicator indicator = new Indicator();
		indicator.setCenterIndi(boardDao.selectUnAnsweredQna().toString());
		
		Map<String, Object> param = new HashMap<String, Object>(1);
		param.put("status", Code.MONEY_IN_REQUEST);
		indicator.setChargingIndi(moneyInDao.selectMoneyInCount(param).toString());
		
		param = new HashMap<String, Object>(1);
		param.put("status", Code.MONEY_OUT_REQUEST);
		indicator.setExchangeIndi(moneyOutDao.selectMoneyOutCount(param).toString());

		ResultXml rx = new ResultXml(0, null, indicator);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
}
