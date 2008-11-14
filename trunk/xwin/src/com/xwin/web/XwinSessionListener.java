package com.xwin.web;

import java.util.Date;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.xwin.domain.admin.Admin;
import com.xwin.domain.user.Member;

public class XwinSessionListener implements HttpSessionListener, HttpSessionAttributeListener
{
	
	public void sessionCreated(HttpSessionEvent event)
	{
		
	}

	public void sessionDestroyed(HttpSessionEvent event)
	{
		HttpSession session = event.getSession();
		Member member = (Member) session.getAttribute("Member");
		if (member != null) {
			Admin.loginMap.remove(member.getUserId());
			System.out.println("sessionDestroyed : " + member.getUserId());
		}
	}

	public void attributeAdded(HttpSessionBindingEvent event)
	{
		String name = event.getName();
		if (name.equals("Member")) {
			Member member = (Member) event.getValue();
			Admin.loginMap.put(member.getUserId(), event.getSession());
			System.out.println("attributeAdded : " + member.getUserId());
		}
	}

	public void attributeRemoved(HttpSessionBindingEvent event)
	{
		String name = event.getName();
		if (name.equals("Member")) {
			Member member = (Member) event.getValue();
			Admin.loginMap.remove(member.getUserId());
			System.out.println("attributeRemoved : " + member.getUserId());
		}	
	}

	public void attributeReplaced(HttpSessionBindingEvent event)
	{
			
	}
}
