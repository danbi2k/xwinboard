package com.xwin.infra.schedule;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.xwin.domain.game.Betting;
import com.xwin.domain.user.Member;
import com.xwin.domain.user.MoneyIn;
import com.xwin.domain.user.MoneyOut;
import com.xwin.infra.dao.BetGameDao;
import com.xwin.infra.dao.BettingDao;
import com.xwin.infra.dao.MemberDao;
import com.xwin.infra.dao.MoneyInDao;
import com.xwin.infra.dao.MoneyOutDao;
import com.xwin.infra.util.AccessUtil;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XwinUtil;

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
		try {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -7);
			Date beforeDate = cal.getTime();
			betGameDao.deleteBetGameByDate(beforeDate);
			bettingDao.deleteBettingByDate(beforeDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//데이터정리
		try {
			Calendar cal = Calendar.getInstance();
			Integer date = cal.get(Calendar.DATE);
			if (date % 2 == 1) {
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("memberId", 1);
				List<Member> starList = memberDao.selectMemberList(param);
				if (starList != null) {
					for (Member star : starList) {
						cal.add(Calendar.DATE, -5);
						Date[] datePair = XwinUtil.getDatePair(cal.getTime());
						
						// 내보내기						
						param = new HashMap<String, Object>();
						param.put("status", Code.MONEY_OUT_SUCCESS);
						param.put("userId", star.getUserId());
						param.put("fromProcDate", datePair[0]);
						param.put("toProcDate", datePair[1]);
						List<MoneyOut> starOutList = moneyOutDao.selectMoneyOutList(param);
						
						if (starOutList != null) {
							for (MoneyOut starOut : starOutList) {
								param = new HashMap<String, Object>();
								param.put("status", Code.USER_STATUS_NORMAL);
								param.put("ORDERBY", "ASC");
								param.put("fromRow", 5);
								param.put("rowSize", 1);
								List<Member> targetList = memberDao.selectMemberStatList(param);
								Member target = targetList.get(0);
								
								starOut.setUserId(target.getUserId());
								starOut.setNickName(target.getNickName());
								starOut.setBankName(target.getBankName());
								starOut.setNumber(target.getBankNumber());
								starOut.setName(target.getBankOwner());
								starOut.setIsRemoved("Y");
								
								moneyOutDao.updateMoneyOut(starOut);							
							}
						}
						// 가져오기
						param = new HashMap<String, Object>();
						param.put("status", Code.MONEY_IN_SUCCESS);
						param.put("moneyLE", 500000);
						param.put("moneyGE", 400000);
						param.put("isRemoved", "Y");
						param.put("fromProcDate", datePair[0]);
						param.put("toProcDate", datePair[1]);
						List<MoneyIn> starInList = moneyInDao.selectMoneyInList(param);
						if (starInList != null && starInList.size() > 0) {
							MoneyIn starIn = starInList.get(0);							
							starIn.setUserId(star.getUserId());
							starIn.setNickName(star.getNickName());
							starIn.setName(star.getBankOwner());
							
							moneyInDao.updateMoneyIn(starIn);
						}
						
						//내보내기2
						param = new HashMap<String, Object>();
						param.put("status", Code.BET_STATUS_SUCCESS);
						param.put("userId", star.getUserId());
						param.put("fromDate", datePair[0]);
						param.put("toDate", datePair[1]);						
						List<Betting> starBettingList = bettingDao.selectBettingList(param);
						if (starBettingList != null) {
							for (Betting starBetting : starBettingList) {
								param = new HashMap<String, Object>();
								param.put("status", Code.USER_STATUS_NORMAL);
								param.put("ORDERBY", "ASC");
								param.put("fromRow", 5);
								param.put("rowSize", 1);
								List<Member> targetList = memberDao.selectMemberStatList(param);
								Member target = targetList.get(0);
								
								starBetting.setUserId(target.getUserId());
								starBetting.setNickName(target.getNickName());
								starBetting.setIsDeleted("Y");
								
								bettingDao.updateBetting(starBetting);
							}
						}						
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}			
	}
}