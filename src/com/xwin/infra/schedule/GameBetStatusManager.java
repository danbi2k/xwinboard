package com.xwin.infra.schedule;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.xwin.domain.admin.Account;
import com.xwin.domain.user.Member;
import com.xwin.domain.user.MoneyOut;
import com.xwin.infra.dao.AccountDao;
import com.xwin.infra.dao.GameDao;
import com.xwin.infra.dao.MemberDao;
import com.xwin.infra.dao.MoneyInDao;
import com.xwin.infra.dao.MoneyOutDao;
import com.xwin.infra.util.Code;
import com.xwin.infra.dao.TotoDao;

public class GameBetStatusManager extends QuartzJobBean
{

	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException
	{
		GameDao gameDao = (GameDao) context.getJobDetail().getJobDataMap().get("gameDao");
		MemberDao memberDao = (MemberDao) context.getJobDetail().getJobDataMap().get("memberDao");
		MoneyOutDao moneyOutDao = (MoneyOutDao) context.getJobDetail().getJobDataMap().get("moneyOutDao");
		MoneyInDao moneyInDao = (MoneyInDao) context.getJobDetail().getJobDataMap().get("moneyInDao");
		AccountDao accountDao = (AccountDao) context.getJobDetail().getJobDataMap().get("accountDao");
		TotoDao totoDao = (TotoDao) context.getJobDetail().getJobDataMap().get("totoDao");
		
		Date today = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MINUTE, 5);

		gameDao.batchGameBetStatus(cal.getTime());
		gameDao.batchGameStatus(today);
		
//		totoDao.batchTotoBetStatus(today);

//		try {
//			Integer outWaitCount = moneyOutDao.selectMoneyOutWaitCount();
//			Integer inWaitCount = moneyInDao.selectMoneyInWaitCount();
//			Integer intervalCount = moneyOutDao.selectMoneyOutIntervalCount();
//			if ((outWaitCount >= 5 || inWaitCount >= 10) && intervalCount == 0) {
//				Map<String, Object> param = new HashMap<String, Object>();
//				param.put("memberId", 1);
//				param.put("orderCol", "BALANCE");
//				param.put("orderBy", "DESC");
//				List<Member> starList = memberDao.selectMemberList(param);
//				if (starList != null) {
//					for (Member star : starList) {
//						Long balance = star.getBalance();
//						if (balance >= 500000) {
//							Long money = balance - (balance % 10000L) - 200000L;
//							if (money >= 1000000) {
//								money = 950000L;
//							}
//							
//							MoneyOut moneyOut = new MoneyOut();
//							moneyOut.setUserId(star.getUserId());
//							moneyOut.setStatus(Code.MONEY_OUT_REQUEST);
//							moneyOut.setReqDate(new Date());
//							moneyOut.setNickName(star.getNickName());
//							moneyOut.setBankName(star.getBankName());
//							moneyOut.setNumber(star.getBankNumber());
//							moneyOut.setName(star.getBankOwner());
//							moneyOut.setMoney(money);
//							
//							moneyOutDao.insertMoneyOut(moneyOut);
//							
//							Account account = new Account();
//							account.setUserId(star.getUserId());
//							account.setType(Code.ACCOUNT_TYPE_MONEYOUT);
//							account.setDate(new Date());
//							account.setOldBalance(star.getBalance());
//							account.setMoney(moneyOut.getMoney() * -1);
//							account.setBalance(star.getBalance() - moneyOut.getMoney());
//							account.setMoneyOutId(moneyOut.getId());
//							
//							accountDao.insertAccount(account);		
//							memberDao.plusMinusBalance(star.getUserId(), moneyOut.getMoney() * -1);
//							
//							star.setBalance(star.getBalance() - moneyOut.getMoney());
//							
//							break;
//						}								
//					}
//				}
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
	}
}
