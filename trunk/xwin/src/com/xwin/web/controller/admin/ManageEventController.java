package com.xwin.web.controller.admin;

import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.xwin.service.sports.EventService;
import com.xwin.service.sports.GameWdlService;

public class ManageEventController extends MultiActionController
{
	private EventService eventService = null;

	public void setEventService(EventService eventService) {
		this.eventService = eventService;
	}
}
