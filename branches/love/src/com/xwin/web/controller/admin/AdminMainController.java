package com.xwin.web.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.board.BoardItem;
import com.xwin.domain.user.Member;
import com.xwin.domain.user.MoneyIn;
import com.xwin.domain.user.MoneyOut;
import com.xwin.web.controller.XwinController;

public class AdminMainController extends XwinController
{
	public ModelAndView viewAdminMain(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		List<Member> memberList = memberDao.selectRecentlyJoinMemberList();
		List<MoneyIn> moneyInList = moneyInDao.selectRecentlyRequestList();
		List<MoneyOut> moneyOutList = moneyOutDao.selectRecentlyRequestList();
		List<BoardItem> qnaList = boardDao.selectRecentlyQna();
		
		ModelAndView mv = new ModelAndView("admin/admin_main");
		
		mv.addObject("memberList", memberList);
		mv.addObject("moneyInList", moneyInList);
		mv.addObject("moneyOutList", moneyOutList);
		mv.addObject("qnaList", qnaList);
		
		return mv;
	}
}