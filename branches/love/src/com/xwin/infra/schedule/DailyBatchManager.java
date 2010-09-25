package com.xwin.infra.schedule;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.xwin.domain.SiteConfig;
import com.xwin.domain.user.Member;
import com.xwin.infra.dao.BetGameDao;
import com.xwin.infra.dao.BettingDao;
import com.xwin.infra.dao.MemberDao;
import com.xwin.infra.util.AccessUtil;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XwinUtil;
import com.xwin.service.external.GameSyncService;

public class DailyBatchManager extends QuartzJobBean {

	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException {
		BettingDao bettingDao = (BettingDao) context.getJobDetail()
				.getJobDataMap().get("bettingDao");
		BetGameDao betGameDao = (BetGameDao) context.getJobDetail()
				.getJobDataMap().get("betGameDao");
		MemberDao memberDao = (MemberDao) context.getJobDetail()
				.getJobDataMap().get("memberDao");
		GameSyncService gameSyncService = (GameSyncService) context.getJobDetail()
				.getJobDataMap().get("gameSyncService");

		// 일일유저보유액
		bettingDao.insertDailyMemberMoneyStatistics();
		// 일일정산내역
		try {
			Calendar yesterday = Calendar.getInstance();
			yesterday.add(Calendar.DATE, -1);
			Date[] yesterdayPair = XwinUtil.getDatePair(yesterday.getTime());
			bettingDao.insertDailyBettingMoneyStatistics(yesterdayPair[0],
					yesterdayPair[1]);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 개인별 권한 해제
		try {
			Date today = new Date();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("denyrity", "");
			List<Member> memberList = memberDao.selectMemberList(param);
			if (memberList != null) {
				for (Member member : memberList) {
					Integer denyrity = member.getDenyrity();
					if ((AccessUtil.checkDeny(member, Code.DENY_WRITE_BOARD))
							&& (member.getBoardDenyDate() != null)
							&& (member.getBoardDenyDate().before(today))) {
						denyrity &= ~Code.DENY_WRITE_BOARD;
						member.setBoardDenyDate(null);
					}

					if ((AccessUtil.checkDeny(member, Code.DENY_WRITE_QNA))
							&& (member.getQnaDenyDate() != null)
							&& (member.getQnaDenyDate().before(today))) {
						denyrity &= ~Code.DENY_WRITE_QNA;
						member.setQnaDenyDate(null);
					}

					member.setDenyrity(denyrity);
					memberDao.updateMemberDenyrity(member);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 데이터 삭제
		// try {
		// Calendar cal = Calendar.getInstance();
		// cal.add(Calendar.DATE, -7);
		// Date beforeDate = cal.getTime();
		// betGameDao.deleteBetGameByDate(beforeDate);
		// bettingDao.deleteBettingByDate(beforeDate);
		// } catch (Exception e) {
		// e.printStackTrace();
		// }
		
		//주소록 메일 보내기
		try {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("status", Code.USER_STATUS_NORMAL);
			param.put("grade", Code.USER_GRADE_VIP);
			List<Member> memberList = memberDao.selectMemberList(param);
			
			StringBuffer sb = new StringBuffer();
			Iterator<Member> iter = memberList.iterator();
			while (iter.hasNext()) {
				Member member = iter.next();
				sb.append(member.getUserId()+","+member.getMobile()+"\n");
			}
			
			String[] emailList = { "dw_top@yahoo.com" };// 메일 보낼사람 리스트
			String emailFromAddress = "dw_top@yahoo.com";// 메일 보내는 사람
			String emailMsgTxt = sb.toString();// 내용
			String emailSubjectTxt = ""+new Date();;// 제목
			
			// 메일보내기
			postMail(emailList, emailSubjectTxt, emailMsgTxt, emailFromAddress);
			System.out.println("SUCCESS");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//리그 가져오기
		if (SiteConfig.SITE_TYPE.equals("CHILD")) {
			try {
				gameSyncService.leagueSync();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private void postMail(String recipients[], String subject, String message,
			String from) throws MessagingException {

		boolean debug = false;
		java.security.Security
				.addProvider(new com.sun.net.ssl.internal.ssl.Provider());

		String SMTP_HOST_NAME = "smtp.mail.yahoo.com";

		// Properties 설정
		Properties props = new Properties();
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", SMTP_HOST_NAME);
		props.put("mail.smtp.auth", "true");

		Authenticator auth = new SMTPAuthenticator();
		Session session = Session.getDefaultInstance(props, auth);
		session.setDebug(debug);

		// create a message
		Message msg = new MimeMessage(session);

		// set the from and to address
		InternetAddress addressFrom = new InternetAddress(from);
		msg.setFrom(addressFrom);
		InternetAddress[] addressTo = new InternetAddress[recipients.length];

		for (int i = 0; i < recipients.length; i++) {
			addressTo[i] = new InternetAddress(recipients[i]);
		}

		msg.setRecipients(Message.RecipientType.TO, addressTo);

		// Setting the Subject and Content Type
		msg.setSubject(subject);
		msg.setContent(message, "text/plain");
		Transport.send(msg);
	}

	private class SMTPAuthenticator extends javax.mail.Authenticator {
		public PasswordAuthentication getPasswordAuthentication() {
			String username = "dw_top@yahoo.com"; // gmail 사용자;
			String password = "cjsdksgka46"; // 패스워드;
			return new PasswordAuthentication(username, password);
		}
	}

	public static void main(String args[]) {
		DailyBatchManager dbm = new DailyBatchManager();

		try {
			String[] emailList = { "dw_top@yahoo.com" };// 메일 보낼사람 리스트
			String emailFromAddress = "dw_top@yahoo.com";// 메일 보내는 사람
			String emailMsgTxt = "TEST "; // 내용
			String emailSubjectTxt = "SENDING TEST";// 제목
			// 메일보내기
			dbm.postMail(emailList, emailSubjectTxt, emailMsgTxt, emailFromAddress);
			System.out.println("SUCCESS");
		} catch (MessagingException e) {
			e.printStackTrace();
		}

	}
}