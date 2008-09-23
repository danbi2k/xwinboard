package com.xwin.service.sports;

import java.util.List;

import com.xwin.dao.EventDao;
import com.xwin.domain.sports.Event;

public class EventService
{
	private EventDao eventDao = null;
	
	public void createEvent(Event event)
	{
		eventDao.insertEvent(event);
	}
	
	public List<Event> getEventList()
	{
		return eventDao.selectEventList();
	}
	
	public void removeEvent(String eventId)
	{
		eventDao.deleteEvent(eventId);
	}

	public void setEventDao(EventDao eventDao) {
		this.eventDao = eventDao;
	}
}
