package com.xwin.web.controller.admin;

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
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminBoardController extends XwinController
{
public static final int ROWSIZE = 20;
	
	public ModelAndView viewBoardList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();

		if (keyword != null) param.put(search+"LIKE", "%"+keyword+"%");
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		param.put("boardName", "user");
		
		List<BoardItem> boardItemList = boardDao.selectBoardItemList(param);
		Integer boardItemCount = boardDao.selectBoardItemCount(param);
		
		ModelAndView mv = new ModelAndView("admin/board/admin_board_list");
		mv.addObject("boardItemList", boardItemList);
		mv.addObject("boardItemCount", boardItemCount);
		
		return mv;
	}
	
	public ModelAndView viewBoardDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		
		BoardItem boardItem = boardDao.selectBoardItem(id, "user");
		
		ModelAndView mv = new ModelAndView("admin/board/admin_board_detail");
		mv.addObject("boardItem", boardItem);
		
		return mv;
	}
	
	public ModelAndView viewWriteNotice(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		ModelAndView mv = new ModelAndView("admin/board/admin_board_write");
		
		return mv;
	}
	
	public ModelAndView writeNotice(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		Member admin = (Member) request.getSession().getAttribute("Admin");
		
		String context = request.getParameter("context");
		String title = request.getParameter("title");
		
		BoardItem boardItem = new BoardItem();
		boardItem.setBoardName("user");
		boardItem.setContext(context);
		boardItem.setDate(new Date());
		boardItem.setNickName(admin.getNickName());
		boardItem.setUserId(admin.getUserId());
		boardItem.setTitle(title);
		boardItem.setStatus(Code.BOARDITEM_STATUS_NORMAL);
		boardItem.setType(Code.BOARDITEM_TYPE_NOTICE);
		
		boardDao.insertBoardItem(boardItem);
		
		ModelAndView mv = new ModelAndView("redirect:/adminBoard.aspx?mode=viewBoardList");
		
		return mv;
	}
	
	public ModelAndView deleteBoardItem(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		
		boardDao.deleteBoardItem(id);
		
		ModelAndView mv = new ModelAndView("redirect:/adminBoard.aspx?mode=viewBoardList");
		return mv;
	}
	
	public ModelAndView writeBoardComment(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		String comment = request.getParameter("comment");
		
		BoardComment boardComment = new BoardComment();
		boardComment.setBoardId(id);
		boardComment.setComment(comment);
		boardComment.setDate(new Date());
		boardComment.setNickName("관리자");
		boardComment.setUserId("secadmin");
		boardDao.insertBoardComment(boardComment);
		
		ResultXml rx = new ResultXml(0, "저장되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView deleteBoardComment(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		
		boardDao.deleteBoardComment(id);
		
		ResultXml rx = new ResultXml(0, "삭제되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
}