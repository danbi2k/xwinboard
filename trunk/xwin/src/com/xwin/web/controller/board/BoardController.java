package com.xwin.web.controller.board;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.board.BoardComment;
import com.xwin.domain.board.BoardItem;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class BoardController extends XwinController
{
	public ModelAndView getBoardItemList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String _pageIndex = request.getParameter("pageIndex");
		Integer pageIndex = null;
		try {
			pageIndex = Integer.parseInt(_pageIndex);
		} catch (Exception e) {
			pageIndex = 0;
		}
		
		String _boardType = request.getParameter("type");
		List<BoardItem> boardItemList = boardDao.selectBoardItemList(pageIndex, _boardType);
		
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
		boardItem.setTitle("¿ì°¡Â÷Ä« ¿ì°¡Â÷Ä«");
		boardItem.setUserId("xx");
		boardItem.setUserName("yy");
		boardItem.setType(type);
		
		String boardId = boardDao.insertBoardItem(boardItem);
		
		BoardComment boardComment = new BoardComment();
		boardComment.setBoardId(boardId);
		boardComment.setComment("ÄìÄìÄì");
		boardComment.setDate(new Date());
		boardComment.setPassword("1234");
		boardComment.setUserId("xx");
		boardComment.setUserName("yy");
		
		boardDao.insertBoardComment(boardComment);
		
		BoardItem dbItem = boardDao.selectBoardItem(boardId);
		
		ResultXml rx = new ResultXml(0, null, dbItem);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView getBoardItem(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id = request.getParameter("id");
		
		BoardItem boardItem = boardDao.selectBoardItem(id);
		
		ResultXml rx = new ResultXml(0, null, boardItem);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;		
	}
}