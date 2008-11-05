package com.xwin.web.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Access;
import com.xwin.domain.admin.Account;
import com.xwin.domain.user.Member;
import com.xwin.domain.user.Memo;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class AdminMemberController extends XwinController
{
	public static final int ROWSIZE = 30;
	
	public ModelAndView viewAdminMember(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String grade = XwinUtil.arcNvl(request.getParameter("grade"));
		String status = XwinUtil.arcNvl(request.getParameter("status"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("status", Code.USER_STATUS_NORMAL);
		Integer normalCount = memberDao.selectMemberCount(param);
		param.put("status", Code.USER_STATUS_SECEDE_REQ);		
		Integer secedeReqCount = memberDao.selectMemberCount(param);
		param.put("status", Code.USER_STATUS_SECEDE);		
		Integer secedeCount = memberDao.selectMemberCount(param);
		
		param.clear();		
		
		param.put("grade", grade);
		param.put("status", status);
		if (keyword != null) param.put(search, "%" + keyword + "%");
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		Integer memberCount = memberDao.selectMemberCount(param);
		List<Member> memberList = memberDao.selectMemberList(param);
		
		ModelAndView mv = new ModelAndView("admin/member/admin_member");
		mv.addObject("memberList", memberList);
		mv.addObject("memberCount", memberCount);
		mv.addObject("normalCount", normalCount);
		mv.addObject("secedeReqCount", secedeReqCount);
		mv.addObject("secedeCount", secedeCount);
		return mv;
	}
	
	public ModelAndView viewMemberDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String userId = request.getParameter("userId");
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", userId);
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		
		List<Account> accountList = accountDao.selectAccountList(param);
		Integer accountCount = accountDao.selectAccountCount(param);			
		Member member = memberDao.selectMember(userId, null);
		
		param = new HashMap<String, Object>();
		param.put("userId", userId);
		param.put("status", Code.MONEY_IN_SUCCESS);		
		Integer chargeSum = XwinUtil.ntz(moneyInDao.selectMoneyInSum(param));
		
		param = new HashMap<String, Object>();
		param.put("userId", userId);
		param.put("status", Code.MONEY_OUT_SUCCESS);		
		Integer exchangeSum = XwinUtil.ntz(moneyOutDao.selectMoneyOutSum(param));
		
		ModelAndView mv = new ModelAndView("admin/member/admin_member_detail");
		mv.addObject("member", member);
		mv.addObject("accountList", accountList);
		mv.addObject("accountCount", accountCount);
		mv.addObject("chargeSum", chargeSum);
		mv.addObject("exchangeSum", exchangeSum);
		
		return mv;
	}
	
	public ModelAndView viewAccessList(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
		String search = XwinUtil.arcNvl(request.getParameter("search"));
		String keyword = XwinUtil.arcNvl(request.getParameter("keyword"));
		String fromDate = XwinUtil.arcNvl(request.getParameter("fromDate"));
		String toDate = XwinUtil.arcNvl(request.getParameter("toDate"));
		String block = XwinUtil.arcNvl(request.getParameter("block"));
		
		int pIdx = 0;
		if (pageIndex != null)
			pIdx = Integer.parseInt(pageIndex);
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (keyword != null) param.put(search+"Like", "%"+keyword+"%");
		param.put("fromRow", pIdx * ROWSIZE);
		param.put("rowSize", ROWSIZE);
		param.put("fromDate", XwinUtil.toDate(fromDate));
		param.put("toDate", XwinUtil.toDateFullTime(toDate));
		if (block != null && block.length() > 0)
			param.put(block, "");
		
		List<Access> accessList = accessDao.selectAccessList(param);
		Integer accessCount = accessDao.selectAccessCount(param);
		ModelAndView mv = new ModelAndView("admin/member/member_access");
		mv.addObject("accessList", accessList);
		mv.addObject("accessCount", accessCount);
		
		return mv;
	}
	
	public ModelAndView secedeMember(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String userId = request.getParameter("userId");
		
		Member member = memberDao.selectMember(userId, null);
		member.setStatus(Code.USER_STATUS_SECEDE);
		
		memberDao.updateMember(member);
		
		ResultXml rx = new ResultXml(0, "탈퇴시켰습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView recorverMember(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String userId = request.getParameter("userId");
		
		Member member = memberDao.selectMember(userId, null);
		member.setStatus(Code.USER_STATUS_NORMAL);
		
		memberDao.updateMember(member);
		
		ResultXml rx = new ResultXml(0, "복구시켰습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView updateMember(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String userId = request.getParameter("userId");
		String status = request.getParameter("status");
		String grade = request.getParameter("grade");
		
		Member member = memberDao.selectMember(userId, null);
		member.setStatus(status);
		member.setGrade(grade);
		
		memberDao.updateMember(member);
		
		ResultXml rx = new ResultXml(0, "변경되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView changeBankInfo(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String bankName = request.getParameter("bankName");
		String bankNumber = request.getParameter("bankNumber");
		String bankOwner = request.getParameter("bankOwner");
		String userId = request.getParameter("userId");
		
		Member member = new Member();
		member.setBankName(bankName);
		member.setBankNumber(bankNumber);
		member.setBankOwner(bankOwner);
		member.setUserId(userId);
		
		memberDao.updateMember(member);		
	
		ResultXml rx = new ResultXml(0, "변경되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView changeGrade(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String grade = request.getParameter("grade");
		String userId = request.getParameter("userId");
		
		Member member = new Member();
		member.setGrade(grade);
		member.setUserId(userId);
		
		memberDao.updateMember(member);		
	
		ResultXml rx = new ResultXml(0, "변경되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView changeEmail(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String email = request.getParameter("email");
		String userId = request.getParameter("userId");
		
		Member member = new Member();
		member.setEmail(email);
		member.setUserId(userId);
		
		memberDao.updateMember(member);		
	
		ResultXml rx = new ResultXml(0, "변경되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView changeMobile(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String mobile = request.getParameter("mobile");
		String userId = request.getParameter("userId");
		
		Member member = new Member();
		member.setMobile(mobile);
		member.setUserId(userId);
		
		memberDao.updateMember(member);		
	
		ResultXml rx = new ResultXml(0, "변경되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView changeDenyrity(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String deny_board = request.getParameter("deny_board");
		String deny_qna = request.getParameter("deny_qna");
		String userId = request.getParameter("userId");
		
		Integer denyrity = 0;
		if (deny_board != null)
			denyrity |= Code.DENY_WRITE_BOARD;
		if (deny_qna != null)
			denyrity |= Code.DENY_WRITE_QNA;
		
		Member member = new Member();
		member.setUserId(userId);
		member.setDenyrity(denyrity);
		
		memberDao.updateMember(member);		
	
		ResultXml rx = new ResultXml(0, "변경되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView blockIp(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String ip = request.getParameter("ip");
		
		ResultXml rx = null;
		
		if (accessDao.selectBlockIpCount(ip) > 0) {
			rx = new ResultXml(0, "이미 차단된 IP 입니다", null);
		} else {
			accessDao.insertBlockIp(ip);		
			rx = new ResultXml(0, "차단 되었습니다", null);
		}
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView releaseIp(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String ip = request.getParameter("ip");
		accessDao.deleteBlockIp(ip);
		
		ResultXml rx = new ResultXml(0, "해제 되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView sendMemo(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Admin") == null)
			return new ModelAndView("admin_dummy");
		
		String userId = request.getParameter("userId");
		String memoContent = request.getParameter("memo");
		
		Memo memo = new Memo();
		memo.setUserId(userId);
		memo.setMemo(memoContent);
		memo.setDate(new Date());
		
		memoDao.insertMemo(memo);
		
		ResultXml rx = new ResultXml(0, "발송되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
}
