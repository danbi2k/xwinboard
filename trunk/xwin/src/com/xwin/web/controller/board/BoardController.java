package com.xwin.web.controller.board;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.board.BoardItem;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class BoardController extends XwinController
{
	public ModelAndView viewBoardList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		List<BoardItem> boardItemList = boardDao.selectBoardItemList();
		
		ResultXml rx = new ResultXml(0, null, boardItemList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView createBoardItem(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String type = request.getParameter("type");
		
		BoardItem boardItem = new BoardItem();
		
		boardItem.setContext("fjkdfjakfjdf");
		boardItem.setDate(new Date());
		boardItem.setReadCount(55);
		boardItem.setTitle("우가차카 우가차카");
		boardItem.setUserId("xx");
		boardItem.setUserName("yy");
		boardItem.setType(type);
		
		boardDao.insertBoardItem(boardItem);
		
		ResultXml rx = new ResultXml(0, null, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
}