package com.xwin.web.controller.sports;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.BeanUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.xwin.domain.sports.Event;
import com.xwin.service.sports.EventService;
import com.xwin.web.command.EventCommand;

public class EventController extends MultiActionController
{
	public ModelAndView createEvent(HttpServletRequest request,
			HttpServletResponse response, EventCommand command) throws Exception
	{
		Event event = new Event();
		BeanUtils.copyProperties(command, event);
		eventService.createEvent(event);
		
		ModelAndView mv = new ModelAndView("/manageEvent.jsp");
		mv.addObject("eventList", eventService.getEventList());
		return mv;
	}
	
	public ModelAndView getEventList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		List<Event> eventList = eventService.getEventList();
		
		ModelAndView mv = new ModelAndView("game_wdl");
		mv.addObject("eventList", eventList);

		return mv; 
	}


	private EventService eventService = null;
	
	public void setEventService(EventService eventService) {
		this.eventService = eventService;
	}
}
