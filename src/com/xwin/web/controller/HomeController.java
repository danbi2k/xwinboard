package com.xwin.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.board.BoardItem;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;

public class HomeController extends XwinController
{

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		Map<String, Object> param = new HashMap<String, Object>(3);
		param.put("fromRow", 0);
		param.put("rowSize", 7);
		param.put("boardName", "user");
		//if (member != null)
		//	param.put("grade", member.getGrade());
		
		param.put("type", Code.BOARDITEM_TYPE_NOTICE);
		List<BoardItem> noticeList = boardDao.selectBoardItemList(param);
		
		param.put("type", Code.BOARDITEM_TYPE_USER);
		List<BoardItem> userList = boardDao.selectBoardItemList(param);
		
		ModelAndView mv = new ModelAndView("home");
		mv.addObject("noticeList", noticeList);
		mv.addObject("userList", userList);
		
		return mv;
	}
}