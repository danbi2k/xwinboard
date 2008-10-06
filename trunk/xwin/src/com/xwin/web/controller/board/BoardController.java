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
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class BoardController extends XwinController
{
	public static final Integer ROWSIZE = 20;
	
	public ModelAndView viewUserBoard(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String pageIndex = request.getParameter("pageIndex");
		String boardName = request.getParameter("boardName");
		
		ModelAndView mv = viewBoard(pageIndex, boardName, null);
		
		return mv;
	}
	
	public ModelAndView viewQnaBoard(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String pageIndex = request.getParameter("pageIndex");
		String boardName = request.getParameter("boardName");
		
		Member member = (Member) request.getSession().getAttribute("Member");
		ModelAndView mv = viewBoard(pageIndex, boardName, member.getUserId());
		
		return mv;
	}

	private ModelAndView viewBoard(String pageIndex, String boardName, String userId)
	{
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		

		Map<String, Object> param = new HashMap<String, Object>(3);
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		param.put("boardName", boardName);
		param.put("userId", userId);
		
		List<BoardItem> boardItemList = boardDao.selectBoardItemList(param);
		Integer boardItemCount = boardDao.selectBoardItemCount(param);
		
		ModelAndView mv = new ModelAndView("board/board");
		mv.addObject("boardItemList", boardItemList);
		mv.addObject("boardItemCount", boardItemCount);
		
		return mv;
	}
	
	public ModelAndView viewBoardDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id = request.getParameter("id");
		String boardName = request.getParameter("boardName");
		String addComment = request.getParameter("addComment");
		
		if (addComment == null)
			boardDao.plusBoardItemReadCout(id);
		BoardItem boardItem = boardDao.selectBoardItem(id, boardName);
		
		ModelAndView mv = new ModelAndView("board/boardDetail");
		mv.addObject("boardItem", boardItem);
		
		return mv;
	}
	
	public ModelAndView viewBoardWriteForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String boardName = request.getParameter("boardName");
		ModelAndView mv = new ModelAndView("board/boardWrite");
		
		return mv;
	}
	
	public ModelAndView writeBoardComment(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{	
		String boardId = request.getParameter("boardId");
		String comment = request.getParameter("comment");
		String boardName = request.getParameter("boardName");
		
		Member member = (Member) request.getSession().getAttribute("Member");
		
		BoardComment boardComment = new BoardComment();
		boardComment.setBoardId(boardId);
		boardComment.setComment(comment);
		boardComment.setDate(new Date());
		boardComment.setNickName(member.getNickName());
		boardComment.setUserId(member.getUserId());
		boardDao.insertBoardComment(boardComment);
		
		ModelAndView mv = new ModelAndView("redirect:/board.aspx?mode=viewBoardDetail&boardName="+boardName+"&addComment=true&id=" + boardId);
		
		return mv;
	}
	
	public ModelAndView writeBoardItem(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{	
		String title = request.getParameter("title");
		String context = request.getParameter("context");
		String boardName = request.getParameter("boardName");
		
		Member member = (Member) request.getSession().getAttribute("Member");
		
		BoardItem boardItem = new BoardItem();
		boardItem.setBoardName(boardName);
		boardItem.setContext(context);
		boardItem.setDate(new Date());
		boardItem.setNickName(member.getNickName());
		boardItem.setUserId(member.getUserId());
		boardItem.setStatus(Code.BOARDITEM_STATUS_NORMAL);
		boardItem.setTitle(title);
		boardItem.setType(Code.BOARDITEM_TYPE_USER);
		boardDao.insertBoardItem(boardItem);
	
		ModelAndView mv = null;
		if (boardName.equals("user"))
			mv = new ModelAndView("redirect:/board.aspx?mode=viewUserBoard&boardName=" + boardName);
		else if (boardName.equals("qna"))
			mv = new ModelAndView("redirect:/board.aspx?mode=viewQnaBoard&boardName=" + boardName);
		
		return mv;
	}
	
	public ModelAndView getBoardItem(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id = request.getParameter("id");
		
		BoardItem boardItem = boardDao.selectBoardItem(id, "user");
		
		ResultXml rx = new ResultXml(0, null, boardItem);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;		
	}
}