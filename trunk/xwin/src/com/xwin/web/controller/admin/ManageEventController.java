package com.xwin.web.controller.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.xwin.service.sports.EventService;

public class ManageEventController implements Controller
{
	public ModelAndView handleRequest(HttpServletRequest httpServletRequest,
			HttpServletResponse httpServletResponse) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	private EventService eventService = null;

	public void setEventService(EventService eventService) {
		this.eventService = eventService;
	}
}
