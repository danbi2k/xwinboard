package com.xwin.web.controller.board;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.board.BoardItem;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
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
		param.put("boardName", "user");
		
		List<BoardItem> boardItemList = boardDao.selectBoardItemList(param);
		Integer boardItemCount = boardDao.selectBoardItemCount(param);
		
		ModelAndView mv = new ModelAndView("board/board");
		mv.addObject("boardItemList", boardItemList);
		mv.addObject("boardItemCount", boardItemCount);
		
		return mv;
	}
	
	public ModelAndView viewUserBoardDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id = request.getParameter("id");
		
		BoardItem boardItem = boardDao.selectBoardItem(id);
		
		ModelAndView mv = new ModelAndView("board/boardDetail");
		mv.addObject("boardItem", boardItem);
		
		return mv;
	}
	
	public ModelAndView writeBoardItem(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{	
		String title = request.getParameter("title");
		String context = request.getParameter("context");
		
		Member member = (Member) request.getSession().getAttribute("Member");
		
		BoardItem boardItem = new BoardItem();
		boardItem.setBoardName("user");
		boardItem.setContext(context);
		boardItem.setDate(new Date());
		boardItem.setNickName(member.getNickName());
		boardItem.setUserId(member.getUserId());
		boardItem.setStatus(Code.BOARDITEM_STATUS_NORMAL);
		boardItem.setTitle(title);
		boardItem.setType(Code.BOARDITEM_TYPE_USER);
		boardDao.insertBoardItem(boardItem);
		
		ModelAndView mv = new ModelAndView("redirect:/board.aspx?mode=viewUserBoard");
		
		return mv;
	}
	
	public ModelAndView viewUserBoardWrite(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("board/boardWrite");
		
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