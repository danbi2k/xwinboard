package com.xwin.infra.util;

import com.thoughtworks.xstream.XStream;
import com.xwin.domain.game.GameWdl;
import com.xwin.web.command.GameCartItem;
import com.xwin.web.command.ResultXml;

public class XmlUtil
{
	private static XStream xstream = new XStream();
	
	static {
		xstream.alias("list", java.util.List.class);
		xstream.alias("gameWdl", GameWdl.class);
		xstream.alias("gameCartItem", GameCartItem.class);
		xstream.alias("resultXml", ResultXml.class);
	}
	
	public static String toXml(Object object)
	{
		return xstream.toXML(object);
	}
	
	public static Object fromXml(String xml)
	{
		return xstream.fromXML(xml);
	}
}
