package com.xwin.service.admin;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.admin.Account;
import com.xwin.domain.admin.Transaction;
import com.xwin.domain.user.Member;
import com.xwin.domain.user.MoneyIn;
import com.xwin.infra.util.Code;

public class MoneyInService extends XwinService
{
	private static final int TIMEOUT  = 90 * 60 * 1000;
	
	public Integer processMoneyIn(String moneyInId)
	{
		MoneyIn moneyIn = moneyInDao.selectMoneyIn(moneyInId);		
		Member member = memberDao.selectMember(moneyIn.getUserId(), null);		
		return processMoneyIn(moneyIn, Code.MONEY_IN_SUCCESS, member);
	}
	
	public void processMoneyInAuto() throws Exception
	{
		List<MoneyIn> moneyInList = moneyInDao.selectMoneyInList(null, Code.MONEY_IN_REQUEST);
		if (moneyInList != null) {
			for (MoneyIn moneyIn : moneyInList) {
				
				//타임아웃 지난 입금신청은 자동취소
				Date now = new Date();
				long timeDiff = now.getTime() - moneyIn.getReqDate().getTime();
				if (timeDiff >= TIMEOUT) {
					moneyIn.setStatus(Code.MONEY_IN_CANCEL_TIMEOUT);
					moneyIn.setProcDate(now);
					moneyInDao.updateMoneyIn(moneyIn);
					continue;
				}
				
				String name = moneyIn.getName();
				Long money = moneyIn.getMoney();	
				
				//List<KtfSmsMessage> ktfSmsMessageList = ktfSmsDao.searchAssociateWitnMoneyIn(name, money);
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("isCharge", "N");
				param.put("userName", name);
				param.put("money", money);
				param.put("type", Code.TRAN_TYPE_MONEYIN);
				List<Transaction> tranList = transactionDao.selectTransactionList(param);
				
				if (tranList != null && tranList.size() > 0) {
					if (tranList.size() > 1) {
						for (Transaction transaction : tranList) {
							transaction.setIsCharge("C");
							transaction.setNote("동명/동액 입금발견");
							transactionDao.updateTransaction(transaction);
						}
						continue;
					}
			
					Transaction transaction = tranList.get(0);
					
					long tranDiff = now.getTime() - transaction.getDate().getTime();
					if (tranDiff >= TIMEOUT) {
						transaction.setIsCharge("C");
						transaction.setNote("시간초과");
						transactionDao.updateTransaction(transaction);
						continue;
					}
					
					if (isValidTransaction(transaction)) {

						Member member = memberDao.selectMember(moneyIn.getUserId(), null);
						int result = processMoneyIn(moneyIn, Code.MONEY_IN_SUCCESS, member);
						if (result == 0) {
							transaction.setIsCharge("Y");
							transaction.setMoneyInId(moneyIn.getId());
							transactionDao.updateTransaction(transaction);
							
							/*
							String nickName = member.getNickName();
							String mobile = member.getMobile().replaceAll("-", "");
							String message = "[" + SiteConfig.SITE_NAME + "]" + nickName + " 님께 " + money + "원이 충전 되었습니다.";
							sendSmsConnector.sendSms(message, mobile, "SiteConfig.SITE_PHONE");
							*/
						}
					}
				}
			}
		}
	}
	
	private Integer processMoneyIn(MoneyIn moneyIn, String moneyInStatus, Member member)
	{
		if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST)) {
			
			Account account = new Account();
			account.setUserId(member.getUserId());
			account.setType(Code.ACCOUNT_TYPE_MONEYIN);
			account.setDate(new Date());
			account.setOldBalance(member.getBalance());
			account.setMoney(moneyIn.getMoney());
			account.setBalance(member.getBalance() + moneyIn.getMoney());
			account.setMoneyInId(moneyIn.getId());			
			
			moneyIn.setStatus(moneyInStatus);
			moneyIn.setProcDate(new Date());
			
			//포인트 지급
//			Double point = moneyIn.getMoney() * 0.05;			
//			memberDao.plusMinusPoint(member.getUserId(), point.longValue());
//			
//			Point pointLog = new Point();
//			pointLog.setUserId(member.getUserId());
//			pointLog.setType(Code.POINT_TYPE_MONEYIN);
//			pointLog.setDate(new Date());
//			pointLog.setOldBalance(member.getPoint());
//			pointLog.setMoney(point.longValue());
//			pointLog.setBalance(member.getPoint() + point.longValue());
//			pointLog.setMoneyInId(moneyIn.getId());
//			
//			pointDao.insertPoint(pointLog);
			
			accountDao.insertAccount(account);
			moneyInDao.updateMoneyIn(moneyIn);			
			memberDao.plusMinusBalance(member.getUserId(), moneyIn.getMoney());
			
			return 0;
		}
		
		return -1;
	}
	
	private boolean isValidTransaction(Transaction transaction)
	{
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MILLISECOND, TIMEOUT * -1);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("name", transaction.getUserName());
		param.put("money", transaction.getMoney());
		param.put("status", Code.MONEY_IN_SUCCESS);
		param.put("fromProcDate", cal.getTime());
		
		Integer count = moneyInDao.selectMoneyInCount(param);
		
		if (count > 0) {
			transaction.setNote("동명/동액충전내역발견");
			transaction.setIsCharge("C");
			transactionDao.updateTransaction(transaction);
			return false;
		}
		
		param.put("status", Code.MONEY_IN_REQUEST);
		
		count = moneyInDao.selectMoneyInCount(param);
		
		if (count > 0) {
			transaction.setNote("동명/동액충전요청발견");
			transaction.setIsCharge("C");
			transactionDao.updateTransaction(transaction);
			return false;
		}
		
		return true;		
	}
}
