package com.xwin.infra.schedule;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.xwin.domain.user.Member;
import com.xwin.infra.dao.BetGameDao;
import com.xwin.infra.dao.BettingDao;
import com.xwin.infra.dao.MemberDao;
import com.xwin.infra.dao.MoneyInDao;
import com.xwin.infra.dao.MoneyOutDao;
import com.xwin.infra.util.AccessUtil;
import com.xwin.infra.util.Code;

public class DailyBatchManager extends QuartzJobBean
{

	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException
	{
		BettingDao bettingDao = (BettingDao) context.getJobDetail().getJobDataMap().get("bettingDao");
		BetGameDao betGameDao = (BetGameDao) context.getJobDetail().getJobDataMap().get("betGameDao");
		MemberDao memberDao = (MemberDao) context.getJobDetail().getJobDataMap().get("memberDao");
		MoneyInDao moneyInDao = (MoneyInDao) context.getJobDetail().getJobDataMap().get("moneyInDao");
		MoneyOutDao moneyOutDao = (MoneyOutDao) context.getJobDetail().getJobDataMap().get("moneyOutDao");
		
		
		// 일일유저보유액
		bettingDao.insertDailyMemberMoneyStatistics();
		// 일일정산내역
		bettingDao.insertDailyBettingMoneyStatistics();
		// 개인별 권한 해제
		try {
			Date today = new Date();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("denyrity", "");
			List<Member> memberList = memberDao.selectMemberList(param);
			if (memberList != null) {
				for (Member member : memberList) {
					Integer denyrity = member.getDenyrity();
					if (
							(AccessUtil.checkDeny(member, Code.DENY_WRITE_BOARD)) &&
							(member.getBoardDenyDate() != null) &&
							(member.getBoardDenyDate().before(today))
						)
					{
						denyrity &= ~Code.DENY_WRITE_BOARD;
						member.setBoardDenyDate(null);
					}
					
					if (
							(AccessUtil.checkDeny(member, Code.DENY_WRITE_QNA)) &&
							(member.getQnaDenyDate() != null) &&
							(member.getQnaDenyDate().before(today))
						)
					{
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
		
		//데이터 삭제
//		try {
//			Calendar cal = Calendar.getInstance();
//			cal.add(Calendar.DATE, -6);
//			Date beforeDate = cal.getTime();
//			betGameDao.deleteBetGameByDate(beforeDate);
//			bettingDao.deleteBettingByDate(beforeDate);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
	}
}