package com.xwin.web.controller.board;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Admin;
import com.xwin.domain.board.BoardComment;
import com.xwin.domain.board.BoardItem;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.AccessUtil;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class BoardController extends XwinController
{
	public static final Integer ROWSIZE = 25;
	
	public ModelAndView viewBoard(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String pageIndex = request.getParameter("pageIndex");
		String boardName = request.getParameter("boardName");
		
		String userId = null;
		if (boardName.equals("qna")) {
			Member member = (Member) request.getSession().getAttribute("Member");
			userId = member.getUserId();
		}			
		
		ModelAndView mv = viewBoard(pageIndex, boardName, userId);
		
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
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
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
		
		if ((boardName.equals("user") && Admin.DENY_BOARD.equals("Y") == false) ||
				(boardName.equals("qna") && Admin.DENY_QNA.equals("Y") == false))
			return new ModelAndView("illegal");
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		Member member = null;
		if ((member = (Member) request.getSession().getAttribute("Member")) == null)
			return new ModelAndView("dummy");
		
		member = memberDao.selectMember(member.getUserId(), null);
		if (AccessUtil.checkDeny(member, boardName.equals("user")?Code.DENY_WRITE_BOARD:Code.DENY_WRITE_QNA))
			return new ModelAndView("illegal");
		
		ModelAndView mv = new ModelAndView("board/boardWrite");
		
		return mv;
	}
	
	public ModelAndView writeBoardComment(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String boardName = request.getParameter("boardName");
		
		if ((boardName.equals("user") && Admin.DENY_BOARD.equals("Y") == false) ||
				(boardName.equals("qna") && Admin.DENY_QNA.equals("Y") == false))
			return new ModelAndView("illegal");
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		Member member = null;
		if ((member = (Member) request.getSession().getAttribute("Member")) == null)
			return new ModelAndView("dummy");
		
		String boardId = request.getParameter("boardId");
		String comment = request.getParameter("comment");
		
		member = memberDao.selectMember(member.getUserId(), null);
		if (AccessUtil.checkDeny(member, boardName.equals("user")?Code.DENY_WRITE_BOARD:Code.DENY_WRITE_QNA))
			return new ModelAndView("illegal");
		
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
		String boardName = request.getParameter("boardName");
		
		if ((boardName.equals("user") && Admin.DENY_BOARD.equals("Y") == false) ||
				(boardName.equals("qna") && Admin.DENY_QNA.equals("Y") == false))
			return new ModelAndView("illegal");
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		Member member = null;
		if ((member = (Member) request.getSession().getAttribute("Member")) == null)
			return new ModelAndView("dummy");
		
		String title = request.getParameter("title");
		String context = request.getParameter("context");
		
		member = memberDao.selectMember(member.getUserId(), null);
		if (AccessUtil.checkDeny(member, boardName.equals("user")?Code.DENY_WRITE_BOARD:Code.DENY_WRITE_QNA))
			return new ModelAndView("illegal");
		
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
		mv = new ModelAndView("redirect:/board.aspx?mode=viewBoard&boardName=" + boardName);
		
		return mv;
	}
	
	public ModelAndView deleteBoardItem(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String id = request.getParameter("id");
		String boardName = request.getParameter("boardName");
		
		BoardItem boardItem = boardDao.selectBoardItem(id, boardName);
		Member member = (Member) request.getSession().getAttribute("Member");
		
		ResultXml rx = null;
		if (boardItem.getUserId().equals(member.getUserId())) {
			//boardDao.deleteBoardCommentList(id);
			boardDao.deleteBoardItem(id);
			
			rx = new ResultXml(0, "삭제되었습니다", null);
		}
		else {
			rx = new ResultXml(-1, "권한이 없습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView deleteBoardComment(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String id = request.getParameter("id");
		
		BoardComment boardComment = boardDao.selectBoardComment(id);
		Member member = (Member) request.getSession().getAttribute("Member");
		
		ResultXml rx = null;
		if (boardComment.getUserId().equals(member.getUserId())) {
			//boardDao.deleteBoardCommentList(id);
			boardDao.deleteBoardComment(id);
			
			rx = new ResultXml(0, "삭제되었습니다", null);
		}
		else {
			rx = new ResultXml(-1, "권한이 없습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView getBoardItem(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String id = request.getParameter("id");
		
		BoardItem boardItem = boardDao.selectBoardItem(id, "user");
		
		ResultXml rx = new ResultXml(0, null, boardItem);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;		
	}
}