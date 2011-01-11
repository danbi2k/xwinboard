package com.xwin.web.controller.user;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;
import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.SiteConfig;
import com.xwin.domain.admin.Account;
import com.xwin.domain.admin.Admin;
import com.xwin.domain.admin.Point;
import com.xwin.domain.join.Invitation;
import com.xwin.domain.user.Member;
import com.xwin.domain.user.Memo;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.MemberCommand;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class MemberController extends XwinController implements MessageSourceAware
{
	public ModelAndView viewModifyForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ModelAndView mv = new ModelAndView("join/modify");
		mv.addObject("isModify", Boolean.TRUE);
		
		return mv;
	}

	public ModelAndView registerMember(HttpServletRequest request,
			HttpServletResponse response, MemberCommand command) throws Exception
	{
//		if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
//			return new ModelAndView("block");
		Invitation invitation = null;
		if (Admin.SITE_GRADE.equals(Code.USER_GRADE_VIP)) {
			invitation = (Invitation) request.getSession().getAttribute("INVITATION");
			if (invitation == null)
				return new ModelAndView("dummy");			 
			invitation = invitationDao.selectInvitation(invitation.getUserId(), invitation.getInviteKey());
		}
		
		String mobile = command.getPhone1() + "-" + command.getPhone2() + "-" + command.getPhone3();
		String phonePin = (String) request.getSession().getAttribute(mobile);
		String introducerId = invitation != null ? invitation.getUserId() : null;
		Member introducer = null;
		if (introducerId != null)
			introducer = memberDao.selectMember(introducerId, null);
		
		ResultXml rx = null;
		if (introducerId == null || introducerId.length() == 0 || (introducerId != null && introducer != null)) {
			if (phonePin != null) {
				if (phonePin.equals(command.getPhonePin())) {
					rx = checkExistUserId(command.getUserId());
					if (rx.getCode() == 0) {
						rx = checkExistNickName(command.getNickName(), null);
						if (rx.getCode() == 0) {
							rx = checkPassword(command.getPassword1(), command.getPassword2());
							if (rx.getCode() == 0) {
								rx = checkPhone(command.getPhone1(), command.getPhone2(), command.getPhone3());
								if (rx.getCode() == 0) {
									rx = checkEmail(command.getEmail1(), command.getEmail2());
									if (rx.getCode() == 0) {
										rx = checkPin(command.getPin());
										if (rx.getCode() == 0) {
											rx = checkExistBankBook(command.getBankName(), command.getBankNumber(), command.getBankOwner());
											if (rx.getCode() == 0) {
												Member member = new Member();
												member.setUserId(command.getUserId());
												member.setPassword(XwinUtil.getUserPassword(command.getPassword1()));
												member.setNickName(command.getNickName());
												member.setMobile(mobile);
												member.setEmail(command.getEmail1() + "@" + command.getEmail2());
												member.setPin(command.getPin());
												member.setStatus(Code.USER_STATUS_NORMAL);
												member.setGrade(Admin.SITE_GRADE);
												member.setJoinDate(new Date());
												member.setBankName(command.getBankName());
												member.setBankNumber(XwinUtil.bankTrim(command.getBankNumber()));
												member.setBankOwner(XwinUtil.bankTrim(command.getBankOwner()));
												member.setBankDate(new Date());
												member.setGetSms(command.getSmsCheck());
												member.setIntroducerId(introducerId);
												
												String WelcomeMsg = "환영합니다";
												
//												Integer cnt = memberDao.confirmGetJoinEvent(member.getMobile());
//												if (cnt == 0) {
													//memberDao.loggingGetEvent(member.getMobile());
													//member.setBalance(5000L);
													//member.setJoinBonus(5000);
													//WelcomeMsg = "가입이벤트로 5,000캐쉬가 충전 되었습니다";
													member.setBalance(0L);
													member.setJoinBonus(0);
													
//												} else {
//													member.setBalance(30000L);
//													member.setJoinBonus(30000);
//													WelcomeMsg = "가입이벤트로 30,000캐쉬가 충전 되었습니다";
//												}
												
												memberDao.insertMember(member);
												
												if (invitation != null) {
													invitation.setJoinId(member.getUserId());
													invitationDao.updateInvitation(invitation);
												}
												
//												if (introducer != null) {
//													introducer.setIntroduceCount(introducer.getIntroduceCount() + 1);
//													memberDao.updateMember(introducer);
//													
//													Long intro_bonus = 5000L;
//													
//													Account account = new Account();
//													account.setUserId(introducer.getUserId());
//													account.setType(Code.ACCOUNT_TYPE_INTRODUCE);
//													account.setDate(new Date());
//													account.setOldBalance(introducer.getBalance());
//													account.setMoney(intro_bonus);
//													account.setBalance(introducer.getBalance() + intro_bonus);
//													accountDao.insertAccount(account);
//													
//													memberDao.plusMinusBalance(introducer.getUserId(), intro_bonus);
//													memberDao.plusMinusJoinBonus(introducer.getUserId(), intro_bonus);
//												}
												
												rx = new ResultXml(0, WelcomeMsg, null);
											}
										}
									}
								}
							}
						}
					}
				} else {
					rx = new ResultXml(-1, "인증번호가 틀렸습니다", null);
				}
			} else {
				rx = new ResultXml(-1, "인증번호를 전송하십시오", null);
			}
		} else {
			rx = new ResultXml(-1, "추천인 ID를 다시 확인하십시오", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	public ModelAndView modifyMember(HttpServletRequest request,
			HttpServletResponse response, MemberCommand command) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		Member member = (Member) request.getSession().getAttribute("Member");
		String mobile = command.getPhone1() + "-" + command.getPhone2() + "-" + command.getPhone3();
		String phonePin = (String) request.getSession().getAttribute(mobile);
		request.getSession().removeAttribute(mobile);
		
		ResultXml rx = null;
		if (phonePin != null) {
			if (phonePin.equals(command.getPhonePin())) {
				rx = checkPassword(command.getPassword1(), command.getPassword2());
				if (rx.getCode() == 0) {
					rx = checkPin(command.getPin());
					if (rx.getCode() == 0) {
						member.setPassword(XwinUtil.getUserPassword(command.getPassword1()));
						member.setPin(command.getPin());
						member.setGetSms(command.getSmsCheck());
						member.setPasswordExpire("C");
						//member.setNickName(command.getNickName());
						//member.setMobile(command.getPhone1() + "-" + command.getPhone2() + "-" + command.getPhone3());
						//member.setEmail(command.getEmail1() + "@" + command.getEmail2());
						if ((member.getBankName() == null || member.getBankName().length() == 0) && command.getBankName() != null) {
							member.setBankName(command.getBankName());
							member.setBankNumber(command.getBankNumber());
							member.setBankOwner(command.getBankOwner());
						}
						
						memberDao.updateMember(member);
							
						rx = ResultXml.SUCCESS;
					} 		
				}
			} else {
				rx = new ResultXml(-1, "인증번호가 틀렸습니다. 인증번호를 재전송 하십시오", null);
			}
		} else {
			rx = new ResultXml(-1, "인증번호를 전송하십시오", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		return mv;
	}
	
	private ResultXml checkPhone(String phone1, String phone2, String phone3) throws Exception
	{
		ResultXml rx = null;
		
		String phone = phone1 + "-" + phone2 + "-" + phone3;
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("mobile", phone);
		Integer count = memberDao.selectMemberCount(param);
		
		if ((phone1 == null || phone1.length() < 3) ||
				(phone2 == null || phone2.length() < 3) ||
				(phone3 == null || phone3.length() < 4))
			rx = new ResultXml(-1, "핸드폰 번호를 정확히 입력하세요", null);
		else if (count > 0) {
			rx = new ResultXml(-1, "등록된 핸드폰 번호 입니다.", null);
		} else {
			rx = ResultXml.SUCCESS;
		}
		
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
		
		if ((pin == null || StringUtils.isNumeric(pin) == false || pin.length() != 6))
			rx = new ResultXml(-1, "모바일PIN번호는 숫자 6자리 입니다", null);
		else
			rx = ResultXml.SUCCESS;
		
		return rx;
	}
	
	private ResultXml checkPassword(String password1, String password2) throws Exception
	{
		ResultXml rx = null;
		
		if ((password1 == null || password1.length() < 4)
				|| (password2 == null || password2.length() < 4))
			rx = new ResultXml(-1, "패스워드를 4자 이상 입력하세요", null);
		else if (password1.equals(password2) == false)
			rx = new ResultXml(-1, "패스워드가 일치하지 않습니다", null);
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
	
	private ResultXml checkExistBankBook(String bankName, String bankNumber, String bankOwner) throws Exception
	{
		ResultXml rx = ResultXml.SUCCESS;
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("bankName", bankName);
		param.put("bankNumber", bankNumber);
		param.put("bankOwner", bankOwner);
		
		if (bankName == null || bankName.length() < 2)
			rx = new ResultXml(-1, "은행명을 2자 이상 입력 하세요", null);
		else if (bankNumber == null || bankNumber.length() < 5)
			rx = new ResultXml(-1, "계좌번호를 5자 이상 입력 하세요", null);
		else if (bankOwner == null || bankOwner.length() < 2)
			rx = new ResultXml(-1, "예금주를 2자 이상 입력 하세요", null);
		else if (memberDao.selectMemberCount(param) > 0)			
			rx = new ResultXml(-1, "이미 등록된 환전계좌번호 입니다", null);
		
		return rx;
	}
	
	public ModelAndView requestSecede(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
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
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
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
		ResultXml rx = null;
		
		String phone = request.getParameter("phone");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("mobile", phone);
		Integer count = memberDao.selectMemberCount(param);
		Member member = (Member) request.getSession().getAttribute("Member");
		
		if ((member == null && count > 0) || (member != null && member.getMobile().equals(phone) == false)) {
			rx = new ResultXml(0, msgSrc.getMessage("JOIN_PHONE_DUP", null, SiteConfig.SITE_LOCALE), null);
		}
		else {
			String phonePin = RandomStringUtils.randomNumeric(5);
			request.getSession().setAttribute(phone, phonePin);	
			
			try {
				String message = msgSrc.getMessage("SMS_JOIN_AUTH", new Object[]{SiteConfig.SITE_NAME, phonePin}, SiteConfig.SITE_LOCALE);
				sendSmsConnector.sendSms(message, phone, SiteConfig.SITE_PHONE);
				rx = new ResultXml(0, msgSrc.getMessage("JOIN_AUTH_SUCCESS", null, SiteConfig.SITE_LOCALE), null);
			} catch (Exception e) {
				rx = new ResultXml(0, msgSrc.getMessage("JOIN_AUTH_FAILURE", null, SiteConfig.SITE_LOCALE), null);
			}
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public synchronized ModelAndView exchangePoint(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
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
			
			Point pointLog = new Point();
			pointLog.setUserId(member.getUserId());
			pointLog.setType(Code.POINT_TYPE_CASHCHARGE);
			pointLog.setDate(new Date());
			pointLog.setOldBalance(point);
			pointLog.setMoney(balance * -1);
			pointLog.setBalance(member.getPoint() - balance);
			pointLog.setNote("캐쉬전환");
			
			pointDao.insertPoint(pointLog);
			
			message = XwinUtil.comma3(balance) + "원이 충전되었습니다";
		}
		
		ResultXml rx = new ResultXml(0, message, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView receiveMemo(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", member.getUserId());
		param.put("isReaded", "N");
		
		List<Memo> memoList = memoDao.selectMemoList(param);
		Memo memo = null;
		if (memoList != null && memoList.size() > 0)
			memo = memoList.get(0);
		
		ResultXml rx = new ResultXml(0, null, memo);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView readMemo(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		Member member = (Member) request.getSession().getAttribute("Member");
		if (member == null)
			return new ModelAndView("dummy");
		
		String id = request.getParameter("id");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", id);
		param.put("isReaded", "Y");
		
		memoDao.updateMemo(param);
				
		ResultXml rx = new ResultXml(0, null, null);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	private MessageSource msgSrc = null;

	public void setMessageSource(MessageSource messageSource)
	{
		msgSrc = messageSource;
	}
}