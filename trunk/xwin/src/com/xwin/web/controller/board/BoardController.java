package com.xwin.web.controller.board;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public static final Integer ROWSIZE = 5;
	
	public ModelAndView viewUserBoard(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String pageIndex = request.getParameter("pageIndex");
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		

		Map<String, Object> param = new HashMap<String, Object>(3);
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<BoardItem> boardItemList = boardDao.selectBoardItemList(param);
		
		ModelAndView mv = new ModelAndView("board/board");
		mv.addObject("boardItemList", boardItemList);
		
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
		boardItem.setTitle("�찡��ī �찡��ī");
		boardItem.setUserId("xx");
		boardItem.setUserName("yy");
		boardItem.setType(type);
		
		String boardId = boardDao.insertBoardItem(boardItem);
		
		BoardComment boardComment = new BoardComment();
		boardComment.setBoardId(boardId);
		boardComment.setComment("������");
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