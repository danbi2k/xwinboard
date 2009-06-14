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
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminQnaController extends XwinController
{
	int ROWSIZE = 30;
	
	public ModelAndView viewQnaList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		
		String grade = XwinUtil.nvl(request.getParameter("grade"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("boardName", "qna");
		param.put("ISDELETED", "N");
		if (keyword != null) param.put(search+"Like", "%"+keyword+"%");
		param.put("fromDate", XwinUtil.toDate(fromDate));
		param.put("toDate", XwinUtil.toDateFullTime(toDate));
		param.put("grade", grade);
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<BoardItem> qnaList = boardDao.selectBoardItemList(param);
		Integer qnaCount = boardDao.selectBoardItemCount(param);
		
		ModelAndView mv = new ModelAndView("admin/qna/admin_qna_list");
		mv.addObject("qnaList", qnaList);
		mv.addObject("qnaCount", qnaCount);
		
		return mv;
	}
	
	public ModelAndView viewQnaDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		String grade = request.getParameter("grade");
		BoardItem boardItem = boardDao.selectBoardItem(id, "qna", grade);
		
		ModelAndView mv = new ModelAndView("admin/qna/admin_qna_detail");
		mv.addObject("boardItem", boardItem);
		
		return mv;
	}
	
	public ModelAndView answerQna(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
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
		
		BoardItem boardItem = new BoardItem();
		boardItem.setId(id);
		boardItem.setIsChecked("Y");
		boardDao.updateBoardItem(boardItem);
		
		ResultXml rx = new ResultXml(0, "저장되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView deleteQnaItem(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String[] id = request.getParameterValues("id");

		for (int i = 0 ; i < id.length ; i++)
			boardDao.deleteBoardItem(id[i]);
		
		ResultXml rx = new ResultXml(0, "삭제되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView saveQnaIsChecked(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String ip = request.getRemoteAddr();
		Member admin = (Member) request.getSession().getAttribute("Admin");		
		if (admin == null || admin.getLoginIpAddress().equals(ip) == false)
			return new ModelAndView("admin_dummy");
		
		String id = request.getParameter("id");
		String isChecked = request.getParameter("isChecked");

		BoardItem boardItem = new BoardItem();
		boardItem.setId(id);
		boardItem.setIsChecked(isChecked);
		
		boardDao.updateBoardItem(boardItem);
		
		ResultXml rx = new ResultXml(0, null, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
}
