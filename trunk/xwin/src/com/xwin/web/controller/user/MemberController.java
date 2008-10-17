package com.xwin.web.controller.user;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.admin.Account;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.MemberCommand;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class MemberController extends XwinController
{
	public ModelAndView viewJoinForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		ModelAndView mv = new ModelAndView("user/join");
		
		return mv;
	}
	
	public ModelAndView viewModifyForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ModelAndView mv = new ModelAndView("user/modify");
		
		return mv;
	}

	public ModelAndView registerMember(HttpServletRequest request,
			HttpServletResponse response, MemberCommand command) throws Exception
	{
		String phonePin = (String) request.getSession().getAttribute("phonePin");
		
		ResultXml rx = null;
		if (phonePin.equals(command.getPhonePin())) {
			rx = checkExistUserId(command.getUserId());
			if (rx.getCode() == 0) {
				rx = checkExistNickName(command.getNickName(), "");
				if (rx.getCode() == 0) {
					rx = checkPassword(command.getPassword1(), command.getPassword2());
					if (rx.getCode() == 0) {
						rx = checkPhone(command.getPhone1(), command.getPhone2(), command.getPhone3());
						if (rx.getCode() == 0) {
							rx = checkEmail(command.getEmail1(), command.getEmail2());
							if (rx.getCode() == 0) {
								rx = checkPin(command.getPin());
								if (rx.getCode() == 0) {
									Member member = new Member();
									member.setUserId(command.getUserId());
									member.setPassword(command.getPassword1());
									member.setNickName(command.getNickName());
									member.setMobile(command.getPhone1() + "-" + command.getPhone2() + "-" + command.getPhone3());
									member.setEmail(command.getEmail1() + "@" + command.getEmail2());
									member.setPin(command.getPin());
									member.setStatus(Code.USER_STATUS_NORMAL);
									member.setGrade(Code.USER_GRADE_NORMAL);
									member.setJoinDate(new Date());
									
									String WelcomeMsg = "환영합니다";
									
									Integer cnt = memberDao.confirmGetJoinEvent(member.getMobile());
									if (cnt == 0) {
										memberDao.loggingGetEvent(member.getMobile());
										member.setBalance(5000L);
										WelcomeMsg = "가입축하머니 5,000원이 지급되었습니다";
										
									} else {
										member.setBalance(0L);
									}
									
									memberDao.insertMember(member);
									
									rx = new ResultXml(0, WelcomeMsg, null);
								}
							}
						}
					}
				}
			}
		} else {
			rx = new ResultXml(-1, "인증번호가 틀렸습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView modifyMember(HttpServletRequest request,
			HttpServletResponse response, MemberCommand command) throws Exception
	{
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		Member member = (Member) request.getSession().getAttribute("Member");
		ResultXml rx = null;
		rx = checkExistNickName(command.getNickName(), member.getNickName());
		if (rx.getCode() == 0) {
			rx = checkPassword(command.getPassword1(), command.getPassword2());
			if (rx.getCode() == 0) {
				rx = checkPhone(command.getPhone1(), command.getPhone2(), command.getPhone3());
				if (rx.getCode() == 0) {
					rx = checkEmail(command.getEmail1(), command.getEmail2());
					if (rx.getCode() == 0) {
						member.setPassword(command.getPassword1());
						member.setNickName(command.getNickName());
						member.setMobile(command.getPhone1() + "-" + command.getPhone2() + "-" + command.getPhone3());
						member.setEmail(command.getEmail1() + "@" + command.getEmail2());
						
						memberDao.updateMember(member);
							
						rx = ResultXml.SUCCESS;
					}
				}
			}
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	private ResultXml checkPhone(String phone1, String phone2, String phone3) throws Exception
	{
		ResultXml rx = null;
		
		if ((phone1 == null || phone1.length() < 3) ||
				(phone2 == null || phone2.length() < 3) ||
				(phone3 == null || phone3.length() < 4))
			rx = new ResultXml(-1, "휴대폰 번호를 정확히 입력하세요", null);
		else
			rx = ResultXml.SUCCESS;
		
		return rx;
	}
	
	private ResultXml checkEmail(String email1, String email2) throws Exception
	{
		ResultXml rx = null;
		
		if ((email1 == null || email1.length() == 0) ||
				(email2 == null || email2.length() == 0))
			rx = new ResultXml(-1, "이메일 주소를 정확히 입력하세요", null);
		else
			rx = ResultXml.SUCCESS;
		
		return rx;
	}
	
	private ResultXml checkPin(String pin) throws Exception
	{
		ResultXml rx = null;
		
		if ((pin == null || pin.length() < 4))
			rx = new ResultXml(-1, "출금비밀번호는 4자 이상 입력하세요", null);
		else
			rx = ResultXml.SUCCESS;
		
		return rx;
	}
	
	private ResultXml checkPassword(String password1, String password2) throws Exception
	{
		ResultXml rx = null;
		
		if ((password1 == null || password1.length() < 4)
				|| (password2 == null || password2.length() < 4))
			rx = new ResultXml(-1, "비밀번호를 4자 이상 입력하세요", null);
		else if (password1.equals(password2) == false)
			rx = new ResultXml(-1, "비밀번호가 일치하지 않습니다", null);
		else
			rx = ResultXml.SUCCESS;
		
		return rx;
	}
	
	private ResultXml checkExistUserId(String userId) throws Exception
	{
		ResultXml rx = null;
		
		if (userId == null || userId.length() < 2)
			rx = new ResultXml(-1, "아이디를 2자 이상 입력 하세요", null);
		else if (memberDao.countMemberByUserId(userId) > 0)
			rx = new ResultXml(-1, "등록된 아이디 입니다", null);
		else
			rx = ResultXml.SUCCESS;
		
		return rx;
	}
	
	private ResultXml checkExistNickName(String nickName, String orgNickName) throws Exception
	{
		ResultXml rx = ResultXml.SUCCESS;
		
		if (nickName.equals(orgNickName))
			return rx;
		
		if (nickName == null || nickName.length() < 2)
			rx = new ResultXml(-1, "닉네잉을 2자 이상 입력 하세요", null);
		else if (memberDao.countMemberByNickName(nickName) > 0)			
			rx = new ResultXml(-1, "등록된 닉네임 입니다", null);
		
		return rx;
	}
	
	public ModelAndView requestSecede(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("Member");
		
		memberDao.updateMemberStatus(member.getUserId(), Code.USER_STATUS_SECEDE_REQ);
		
		ResultXml rx = new ResultXml(0, "탈퇴가 요청되었습니다", null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		session.removeAttribute("Member");
		
		return mv;
	}
	
	public ModelAndView removeMember(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String id = request.getParameter("id");
		memberDao.deleteMember(id);
		
		ModelAndView mv = new ModelAndView("");
		return mv;
	}
	
	public ModelAndView sendAuthNumber(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String phone = request.getParameter("phone");
		
		String phonePin = "" + ((int)(Math.random() * 10000));
		request.getSession().setAttribute("phonePin", phonePin);		
		

		ResultXml rx = null;
		try {
			sendSmsConnector.sendSms("Bwin-Kor 가입 인증번호  [ " + phonePin + " ]", phone, "00000000000");
			rx = new ResultXml(0, "인증번호를 발송하였습니다", null);
		} catch (Exception e) {
			rx = new ResultXml(0, "인증번호 발송에 실패하였습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView exchangePoint(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		member = memberDao.selectMember(member.getUserId(), null);
		String message = "";
		
		Long point = member.getPoint();
		Long balance = point - (point % 10000);
		
		if (balance < 10000L) {
			message = "포인트는 10,000원 단위로 충전이 가능합니다";
		} else {
			memberDao.plusMinusBalance(member.getUserId(), balance);
			memberDao.plusMinusPoint(member.getUserId(), balance * -1);
			
			Account account = new Account();
			account.setUserId(member.getUserId());
			account.setType(Code.ACCOUNT_TYPE_POINTCHARGE);
			account.setDate(new Date());
			account.setOldBalance(member.getBalance());
			account.setMoney(balance);
			account.setBalance(member.getBalance() + balance);
			accountDao.insertAccount(account);
			
			message = XwinUtil.comma3(balance) + "원이 충전되었습니다";
		}
		
		ResultXml rx = new ResultXml(0, message, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
}
