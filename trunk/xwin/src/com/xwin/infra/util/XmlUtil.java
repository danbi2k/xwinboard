package com.xwin.infra.util;

import com.thoughtworks.xstream.XStream;
import com.xwin.domain.board.BoardComment;
import com.xwin.domain.board.BoardItem;
import com.xwin.domain.game.Game;
import com.xwin.web.command.CartCalc;
import com.xwin.web.command.GameCartItem;
import com.xwin.web.command.ResultXml;

public class XmlUtil
{
	private static XStream xstream = new XStream();
	
	static {
		xstream.alias("list", java.util.List.class);
		xstream.alias("game", Game.class);
		xstream.alias("gameCartItem", GameCartItem.class);
		xstream.alias("boardItem", BoardItem.class);
		xstream.alias("boardComment", BoardComment.class);
		xstream.alias("cartCalc", CartCalc.class);
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
