package com.xwin.infra.util;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.xwin.domain.admin.Transaction;
import com.xwin.domain.board.BoardComment;
import com.xwin.domain.board.BoardItem;
import com.xwin.domain.game.BetGame;
import com.xwin.domain.game.Betting;
import com.xwin.domain.game.Game;
import com.xwin.domain.game.GameFolderItem;
import com.xwin.domain.game.League;
import com.xwin.domain.user.Member;
import com.xwin.domain.user.MoneyIn;
import com.xwin.web.command.FolderCalc;
import com.xwin.web.command.Indicator;
import com.xwin.web.command.ResultXml;

public class XmlUtil
{
	private static XStream xstream = new XStream(new DomDriver());
	
	static {
		xstream.alias("list", java.util.List.class);
		xstream.alias("game", Game.class);
		xstream.alias("league", League.class);
		xstream.alias("betGame", BetGame.class);
		xstream.alias("betting", Betting.class);
		xstream.alias("account", MoneyIn.class);
		xstream.alias("gameFolderItem", GameFolderItem.class);
		xstream.alias("boardItem", BoardItem.class);
		xstream.alias("boardComment", BoardComment.class);
		xstream.alias("folderCalc", FolderCalc.class);
		xstream.alias("resultXml", ResultXml.class);
		xstream.alias("indicator", Indicator.class);
		xstream.alias("transaction", Transaction.class);
		xstream.alias("smsWait", Transaction.class);
		xstream.alias("member", Member.class);
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
