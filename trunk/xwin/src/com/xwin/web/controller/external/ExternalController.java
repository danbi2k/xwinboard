package com.xwin.web.controller.external;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Transaction;
import com.xwin.domain.comm.SmsWait;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class ExternalController extends XwinController
{
	public ModelAndView setTransaction(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String xml = request.getParameter("transactionList");
		
		List<Transaction> transactionList = (List<Transaction>) XmlUtil.fromXml(xml);
		
		if (transactionList != null) {
			for (Transaction transaction : transactionList) {
				try {
					transactionDao.insertTransaction(transaction);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(ResultXml.SUCCESS));
		
		return mv;
	}
	
	public ModelAndView getSmsWaitList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		List<SmsWait> smsWaitList = smsWaitDao.selectSmsWaitList();
		
		if (smsWaitList != null && smsWaitList.size() > 0) {
			SmsWait smsWait = smsWaitList.get(0);
			smsWaitDao.deleteSmsWaitList(smsWait.getId());
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(smsWaitList));
		
		return mv;
	}
}