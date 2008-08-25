package com.xwin.infra.util;

import com.thoughtworks.xstream.XStream;
import com.xwin.domain.comm.KtfSmsMessage;
import com.xwin.domain.sports.League;

public class XmlUtil
{
	private static XStream xstream = new XStream();
	
	static {
		xstream.alias("ktfSmsMessage", KtfSmsMessage.class);
		xstream.alias("league", League.class);
	}
	
	public static String toXML(Object obj) {
		return xstream.toXML(obj);
	}
}
