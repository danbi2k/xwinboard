package com.xwin.infra.schedule;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.xwin.domain.admin.Transaction;
import com.xwin.domain.comm.KtfSmsMessage;
import com.xwin.infra.dao.KtfSmsDao;
import com.xwin.infra.dao.TransactionDao;
import com.xwin.infra.sms.KtfSmsConnector;
import com.xwin.infra.util.Code;
import com.xwin.service.admin.MoneyInService;

public class AutoMoneyInManager extends QuartzJobBean
{
	private static final SimpleDateFormat smsDateFormat = new SimpleDateFormat("MM/dd HH:mm");
	private static final String[] bankList = {"국민","기업","농협","신한","조흥","외환","우체국",
		"SC제일","하나","한국시티","한미","우리","경남","광주","대구","도이치","부산",
		"산업","	수협","전북","제주","새마을","신협","	HSBC","상호저축"};
	
	private KtfSmsDao ktfSmsDao = null;
	private TransactionDao transactionDao = null;
	private KtfSmsConnector ktfSmsConnector = null;
	private MoneyInService moneyInService = null;
	
	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException
	{
		ktfSmsDao = (KtfSmsDao) context.getJobDetail().getJobDataMap().get("ktfSmsDao");
		transactionDao = (TransactionDao) context.getJobDetail().getJobDataMap().get("transactionDao");
		ktfSmsConnector = (KtfSmsConnector) context.getJobDetail().getJobDataMap().get("ktfSmsConnector");
		moneyInService = (MoneyInService) context.getJobDetail().getJobDataMap().get("moneyInService");
		
		List<Map<String, String>> smsList = ktfSmsConnector.parseKTF();
		
		if (smsList != null) {
			for (Map<String, String> smsMap : smsList) {
				
				KtfSmsMessage message = new KtfSmsMessage(
					null,
					smsMap.get("msg_seq"),
					smsMap.get("msg"),
					smsMap.get("call_back"),
					smsMap.get("in_date"),				
					smsMap.get("sm"));
				
				if (message.getMsg().startsWith("[KB]"))
					kbBankProcess(message);
				else if (message.getMsg().startsWith("우리은행"))
					wooriBankProcess(message);
				else {
					ktfSmsDao.insertMessage(message);
				}
			}	
		}
		
		try {
			moneyInService.processMoneyInAuto();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void kbBankProcess(KtfSmsMessage message) {		
		Transaction transaction = new Transaction();
		
		if (message.getMsg().indexOf("입금") > 0) {
			try {
				String[] msg = message.getMsg().split("\n");
				
				Date theDate = null;
				try {
					theDate = smsDateFormat.parse(msg[0].substring(4));
					Calendar cal = Calendar.getInstance();
					cal.setTime(theDate);
					Calendar now = Calendar.getInstance();
					cal.set(Calendar.YEAR, now.get(Calendar.YEAR));
					theDate = cal.getTime();
					
				} catch (ParseException e) {
					e.printStackTrace();
					theDate = new Date();
				}

				String userName = msg[2].trim();
				
				Long money = null;
				if (msg[3].startsWith("입금")) {
					String moneyStr = msg[3].replaceAll("입금", "");
					moneyStr = moneyStr.replaceAll(",", "");
					moneyStr = moneyStr.trim();
					
					money = Long.parseLong(moneyStr);
				}
				
				Long balance = null;
				if (msg[4].startsWith("잔액")) {
					String balanceStr = msg[4].replaceAll("잔액", "");
					balanceStr = balanceStr.replaceAll(",", "");
					balanceStr = balanceStr.trim();
					
					balance = Long.parseLong(balanceStr);
				}				

				transaction.setType(Code.TRAN_TYPE_MONEYIN);
				transaction.setUserName(userName);
				transaction.setDate(theDate);
				transaction.setMoney(money);
				transaction.setBalance(balance);
				transaction.setMsgSeq(message.getMsgSeq());
				transaction.setInDate(message.getInDate());
				transaction.setIsCharge("N");
			
				transactionDao.insertTransaction(transaction);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("트랜젝션을 넣지 못했습니다");
				System.out.println(message);
			}
		} else if (message.getMsg().indexOf("출금") > 0) {
			try {
				String[] msg = message.getMsg().split("\n");
				
				Date theDate = null;
				try {
					theDate = smsDateFormat.parse(msg[0].substring(4));
					Calendar cal = Calendar.getInstance();
					cal.setTime(theDate);
					Calendar now = Calendar.getInstance();
					cal.set(Calendar.YEAR, now.get(Calendar.YEAR));
					theDate = cal.getTime();
					
				} catch (ParseException e) {
					e.printStackTrace();
					theDate = new Date();
				}

				String userName = msg[2].trim();
				
				Long money = null;
				String moneyStr = msg[4].replaceAll(",", "");
				moneyStr = moneyStr.trim();
				
				money = Long.parseLong(moneyStr);
				
				Long balance = null;
				if (msg[5].startsWith("잔액")) {
					String balanceStr = msg[5].replaceAll("잔액", "");
					balanceStr = balanceStr.replaceAll(",", "");
					balanceStr = balanceStr.trim();
					
					balance = Long.parseLong(balanceStr);
				}				

				transaction.setType(Code.TRAN_TYPE_MONEYOUT);
				transaction.setUserName(userName);
				transaction.setDate(theDate);
				transaction.setMoney(money * -1);
				transaction.setBalance(balance);
				transaction.setMsgSeq(message.getMsgSeq());
				transaction.setInDate(message.getInDate());
				transaction.setIsCharge("-");
			
				transactionDao.insertTransaction(transaction);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("트랜젝션을 넣지 못했습니다");
				System.out.println(message);
			}
		}
		else {
			ktfSmsDao.insertMessage(message);
		}
	}

	private void wooriBankProcess(KtfSmsMessage message) {		
		Transaction transaction = new Transaction();
		
		if (message.getMsg().indexOf("입금") > 0) {
			try {
				String[] msg = message.getMsg().split("\n");
				
				//첫째줄
				String first[] = msg[0].split(" ");
				Date theDate = null;
				try {
					theDate = smsDateFormat.parse(first[1].substring(2) + " " + first[2]);
					Calendar cal = Calendar.getInstance();
					cal.setTime(theDate);
					Calendar now = Calendar.getInstance();
					cal.set(Calendar.YEAR, now.get(Calendar.YEAR));
					theDate = cal.getTime();
					
				} catch (ParseException e) {
					e.printStackTrace();
					theDate = new Date();
				}

				Long money = null;
				String moneyStr = first[3].replaceAll("원", "");
				moneyStr = moneyStr.replaceAll(",", "");
				moneyStr = moneyStr.trim();
				
				money = Long.parseLong(moneyStr);
				
				String userName = msg[1].trim();
				int len = userName.length();
				if (len > 3) {
					for (int i = 0 ; i < bankList.length ; i++) {
						userName = userName.replaceAll(bankList[i], "");
						if (userName.length() != len)
							break;
					}
				}
				
				Long balance = null;
				if (msg[2].startsWith("잔액")) {
					String balanceStr = msg[2].replaceAll("잔액 ", "");
					balanceStr = balanceStr.replaceAll("원", "");
					balanceStr = balanceStr.replaceAll(",", "");
					balanceStr = balanceStr.trim();
					
					balance = Long.parseLong(balanceStr);
				}				

				transaction.setType(Code.TRAN_TYPE_MONEYIN);
				transaction.setUserName(userName);
				transaction.setDate(theDate);
				transaction.setMoney(money);
				transaction.setBalance(balance);
				transaction.setMsgSeq(message.getMsgSeq());
				transaction.setInDate(message.getInDate());
				transaction.setIsCharge("N");
			
				transactionDao.insertTransaction(transaction);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("트랜젝션을 넣지 못했습니다");
				System.out.println(message);
			}
		} else if (message.getMsg().indexOf("지급") > 0) {
			try {
				String[] msg = message.getMsg().split("\n");
				
				//첫째줄
				String first[] = msg[0].split(" ");
				Date theDate = null;
				try {
					theDate = smsDateFormat.parse(first[1].substring(2) + " " + first[2]);
					Calendar cal = Calendar.getInstance();
					cal.setTime(theDate);
					Calendar now = Calendar.getInstance();
					cal.set(Calendar.YEAR, now.get(Calendar.YEAR));
					theDate = cal.getTime();
					
				} catch (ParseException e) {
					e.printStackTrace();
					theDate = new Date();
				}

				Long money = null;
				String moneyStr = first[3].replaceAll("원", "");
				moneyStr = moneyStr.replaceAll(",", "");
				moneyStr = moneyStr.trim();
				
				money = Long.parseLong(moneyStr);
				
				String userName = msg[1].trim();
				
				Long balance = null;
				if (msg[2].startsWith("잔액")) {
					String balanceStr = msg[2].replaceAll("잔액 ", "");
					balanceStr = balanceStr.replaceAll("원", "");
					balanceStr = balanceStr.replaceAll(",", "");
					balanceStr = balanceStr.trim();
					
					balance = Long.parseLong(balanceStr);
				}

				transaction.setType(Code.TRAN_TYPE_MONEYOUT);
				transaction.setUserName(userName);
				transaction.setDate(theDate);
				transaction.setMoney(money * -1);
				transaction.setBalance(balance);
				transaction.setMsgSeq(message.getMsgSeq());
				transaction.setInDate(message.getInDate());
				transaction.setIsCharge("-");
			
				transactionDao.insertTransaction(transaction);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("트랜젝션을 넣지 못했습니다");
				System.out.println(message);
			}
		}
		else {
			ktfSmsDao.insertMessage(message);
		}
	}
}