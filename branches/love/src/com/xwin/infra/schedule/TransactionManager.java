package com.xwin.infra.schedule;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.xwin.service.external.TransactionService;

public class TransactionManager extends QuartzJobBean
{
	private static final SimpleDateFormat smsDateFormat = new SimpleDateFormat("MM/dd HH:mm");
	private static final SimpleDateFormat hanaDateFormat = new SimpleDateFormat("MM/dd,HH:mm");
	private static final SimpleDateFormat nhDateFormat = new SimpleDateFormat("yyyy/MM/dd");
	private static final SimpleDateFormat smsTimeFormat = new SimpleDateFormat("HH:mm");
	private static final SimpleDateFormat smsInDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
	
	private static final String MONEY_REG_EXP = "[[,][원][잔액][입금][출금]]";
	
	private static final String BANK_LIST = "[[국민][기업][농협][신한][조흥][외환][우체]"
		+ "[SC제일][하나][한국시티][한미][우리][경남][광주][대구][도이치][부산]"
		+ "[산업][수협][전북][제주][새마을][신협][HSBC][상호저축]]";
	
	private KtfSmsDao ktfSmsDao = null;
	private TransactionDao transactionDao = null;
	private KtfSmsConnector ktfSmsConnector = null;
	private TransactionService transactionService = null;
	
	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException
	{
		ktfSmsDao = (KtfSmsDao) context.getJobDetail().getJobDataMap().get("ktfSmsDao");
		transactionDao = (TransactionDao) context.getJobDetail().getJobDataMap().get("transactionDao");
		ktfSmsConnector = (KtfSmsConnector) context.getJobDetail().getJobDataMap().get("ktfSmsConnector");
		transactionService = (TransactionService) context.getJobDetail().getJobDataMap().get("transactionService");
		
		List<Map<String, String>> smsList = ktfSmsConnector.parseKTF();
		List<Transaction> transactionList = new ArrayList<Transaction>();
		if (smsList != null) {
			for (Map<String, String> smsMap : smsList) {
				Transaction transaction = null;
				KtfSmsMessage message = new KtfSmsMessage(
					null,
					smsMap.get("msg_seq"),
					smsMap.get("msg"),
					smsMap.get("call_back"),
					smsMap.get("in_date"),				
					smsMap.get("sm"));
				
				try {
					if (message.getMsg().startsWith("[KB]"))
						transaction = kbBankProcess(message);
					else if (message.getMsg().startsWith("우리은행"))
						transaction = wooriBankProcess(message);
					else if (message.getMsg().startsWith("신한"))
						transaction = shinhanBankProcess(message);
					else if (message.getMsg().startsWith("우체국"))
						transaction = postOfficeProcess(message);
					else if (message.getMsg().endsWith("기업은행"))
						transaction = ibkProcess(message);
					else if (message.getMsg().startsWith("하나"))
						transaction = hanaBankProcess(message);
					else if (message.getMsg().startsWith("농협"))
						transaction = nhBankProcess(message);
					
					if (transaction != null)
						transactionDao.insertTransaction(transaction);
					else {
						ktfSmsDao.insertMessage(message);
					}
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("트랜젝션을 넣지 못했습니다");
					System.out.println(message);
				}
				
//				if (transaction != null) {
//					transactionList.add(transaction);
//				}
			}	
		}
		
//		try {
//			transactionService.sendTransaction(transactionList);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
	}
	
	private Transaction shinhanBankProcess(KtfSmsMessage message) throws Exception {
		Transaction transaction = new Transaction();
		
		if (message.getMsg().indexOf("입금") > 0) {
			String[] msg = message.getMsg().split("\\s+");
			
			Date theDate = null;
			try {
				String strDate = msg[1] + " " + msg[2].substring(0, 5);
				theDate = smsDateFormat.parse(strDate);
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
			if (msg[3].endsWith("잔액")) {
				String moneyStr = msg[3].replaceAll(MONEY_REG_EXP, "").trim();					
				money = Long.parseLong(moneyStr);
			}
			
			Long balance = null;
			String xtr = msg[4].replaceAll(MONEY_REG_EXP, "");
			int x = 0;
			char[] xchar = xtr.toCharArray();
			for (x = 0 ; x < xchar.length ; x++) {
				if (xchar[x] < '0' || xchar[x] > '9')
					break;
			}
			String userName = xtr.substring(x).trim();
			int colon = userName.indexOf(":");
			if (colon >= 0) {
				userName = userName.substring(colon+1);
			}
			if (msg.length > 5)
				userName += msg[5];
			
			String balanceStr = xtr.substring(0, x).trim();
			
			balance = Long.parseLong(balanceStr);						

			transaction.setType(Code.TRAN_TYPE_MONEYIN);
			transaction.setUserName(userName);
			transaction.setDate(theDate);
			transaction.setMoney(money);
			transaction.setBalance(balance);
			transaction.setMsgSeq(message.getMsgSeq());
			transaction.setInDate(message.getInDate());
			transaction.setIsCharge("N");
			transaction.setBankName("SHINHAN");
		} else if (message.getMsg().indexOf("지급") > 0) {
			String[] msg = message.getMsg().split("\\s+");
			
			Date theDate = null;
			try {
				String strDate = msg[1] + " " + msg[2].substring(0, 5);
				theDate = smsDateFormat.parse(strDate);
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
			if (msg[3].endsWith("잔액")) {
				String moneyStr = msg[3].replaceAll(MONEY_REG_EXP, "").trim();					
				money = Long.parseLong(moneyStr);
			}
			
			Long balance = null;
			String balanceStr = "0";
			String userName = "-";
			int pos = msg[4].lastIndexOf(",");
			if (pos > 0) {
				try {
					balanceStr = msg[4].substring(0, pos+4);
					userName = msg[4].substring(pos+4);
				} catch (Exception e) {
					System.out.println(message.getMsg());
					e.printStackTrace();
				}
			}
			balanceStr = balanceStr.replaceAll(MONEY_REG_EXP, "").trim();
			balance = Long.parseLong(balanceStr);	

			transaction.setType(Code.TRAN_TYPE_MONEYOUT);
			transaction.setUserName(userName);
			transaction.setDate(theDate);
			transaction.setMoney(money * -1);
			transaction.setBalance(balance);
			transaction.setMsgSeq(message.getMsgSeq());
			transaction.setInDate(message.getInDate());
			transaction.setIsCharge("-");
			transaction.setBankName("SHINHAN");
		}
			
		return transaction;
	}

	private Transaction kbBankProcess(KtfSmsMessage message) throws Exception {		
		Transaction transaction = new Transaction();
		
		if (message.getMsg().indexOf("입금") > 0) {
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
				String moneyStr = msg[3].replaceAll(MONEY_REG_EXP, "").trim();					
				money = Long.parseLong(moneyStr);
			}
			
			Long balance = null;
			if (msg[4].startsWith("잔액")) {
				String balanceStr = msg[4].replaceAll(MONEY_REG_EXP, "").trim();					
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
			transaction.setBankName("KB");
		} else if (message.getMsg().indexOf("출금") > 0) {
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
			String moneyStr = msg[4].replaceAll(MONEY_REG_EXP, "").trim();				
			money = Long.parseLong(moneyStr);
			
			Long balance = null;
			if (msg[5].startsWith("잔액")) {
				String balanceStr = msg[5].replaceAll(MONEY_REG_EXP, "").trim();					
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
			transaction.setBankName("KB");
		}				

		return transaction;
	}

	private Transaction wooriBankProcess(KtfSmsMessage message) throws Exception {		
		Transaction transaction = new Transaction();
		
		if (message.getMsg().indexOf("입금") > 0) {
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
			String moneyStr = first[3].replaceAll(MONEY_REG_EXP, "").trim();
			money = Long.parseLong(moneyStr);
			
			String userName = msg[1].trim();
			
			Long balance = null;
			if (msg[2].startsWith("잔액")) {
				String balanceStr = msg[2].replaceAll(MONEY_REG_EXP, "").trim();					
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
			transaction.setBankName("WOORI");
		} else if (message.getMsg().indexOf("지급") > 0) {
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
			String moneyStr = first[3].replaceAll(MONEY_REG_EXP, "").trim();				
			money = Long.parseLong(moneyStr);
			
			String userName = msg[1].trim();
			
			Long balance = null;
			if (msg[2].startsWith("잔액")) {
				String balanceStr = msg[2].replaceAll(MONEY_REG_EXP, "").trim();					
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
			transaction.setBankName("WOORI");
		}
				
		return transaction;
	}
	
	private Transaction postOfficeProcess(KtfSmsMessage message) throws Exception {		
		Transaction transaction = new Transaction();
		
		if (message.getMsg().indexOf("입금") > 0) {
			String[] msg = message.getMsg().split("\n");
			
			//첫째줄
			String first[] = msg[0].trim().split(",");
			Date theDate = null;
			try {
				theDate = smsTimeFormat.parse(first[1]);
				Calendar cal = Calendar.getInstance();
				cal.setTime(theDate);
				Calendar now = Calendar.getInstance();
				now.setTime(smsInDateFormat.parse(message.getInDate()));
				cal.set(Calendar.YEAR, now.get(Calendar.YEAR));
				cal.set(Calendar.MONTH, now.get(Calendar.MONTH));
				cal.set(Calendar.DATE, now.get(Calendar.DATE));
				
				theDate = cal.getTime();
				
			} catch (ParseException e) {
				e.printStackTrace();
				theDate = new Date();
			}

			Long money = null;
			if (msg[2].startsWith("입금")) {
				String moneyStr = msg[2].replaceAll(MONEY_REG_EXP, "").trim();					
				money = Long.parseLong(moneyStr);
			}
			
			Long balance = null;
			if (msg[3].startsWith("잔액")) {
				String balanceStr = msg[3].replaceAll(MONEY_REG_EXP, "").trim();					
				balance = Long.parseLong(balanceStr);
			}		
			
			String userName = msg[4].trim();

			transaction.setType(Code.TRAN_TYPE_MONEYIN);
			transaction.setUserName(userName);
			transaction.setDate(theDate);
			transaction.setMoney(money);
			transaction.setBalance(balance);
			transaction.setMsgSeq(message.getMsgSeq());
			transaction.setInDate(message.getInDate());
			transaction.setIsCharge("N");
			transaction.setBankName("POST");
		} else if (message.getMsg().indexOf("출금") > 0) {
			String[] msg = message.getMsg().split("\n");
			
			//첫째줄
			String first[] = msg[0].trim().split(",");
			Date theDate = null;
			try {
				theDate = smsTimeFormat.parse(first[1]);
				Calendar cal = Calendar.getInstance();
				cal.setTime(theDate);
				Calendar now = Calendar.getInstance();
				now.setTime(smsInDateFormat.parse(message.getInDate()));
				cal.set(Calendar.YEAR, now.get(Calendar.YEAR));
				cal.set(Calendar.MONTH, now.get(Calendar.MONTH));
				cal.set(Calendar.DATE, now.get(Calendar.DATE));
				
				theDate = cal.getTime();
				
			} catch (ParseException e) {
				e.printStackTrace();
				theDate = new Date();
			}

			Long money = null;
			if (msg[2].startsWith("출금")) {
				String moneyStr = msg[2].replaceAll(MONEY_REG_EXP, "").trim();
				money = Long.parseLong(moneyStr);
			}
			
			Long balance = null;
			if (msg[3].startsWith("잔액")) {
				String balanceStr = msg[3].replaceAll(MONEY_REG_EXP, "").trim();
				balance = Long.parseLong(balanceStr);
			}		
			
			String userName = msg[4].trim();

			transaction.setType(Code.TRAN_TYPE_MONEYOUT);
			transaction.setUserName(userName);
			transaction.setDate(theDate);
			transaction.setMoney(money * -1);
			transaction.setBalance(balance);
			transaction.setMsgSeq(message.getMsgSeq());
			transaction.setInDate(message.getInDate());
			transaction.setIsCharge("-");
			transaction.setBankName("POST");
		}	
		
		return transaction;
	}
	
	private Transaction ibkProcess(KtfSmsMessage message) throws Exception {		
		Transaction transaction = new Transaction();
		
		if (message.getMsg().indexOf("입금") > 0) {
			String[] msg = message.getMsg().split("\n");
			
			//첫째줄
			String time = msg[0].substring(4, 9);
			Date theDate = null;
			try {
				theDate = smsTimeFormat.parse(time);
				Calendar cal = Calendar.getInstance();
				cal.setTime(theDate);
				Calendar now = Calendar.getInstance();
				now.setTime(smsInDateFormat.parse(message.getInDate()));
				cal.set(Calendar.YEAR, now.get(Calendar.YEAR));
				cal.set(Calendar.MONTH, now.get(Calendar.MONTH));
				cal.set(Calendar.DATE, now.get(Calendar.DATE));
				
				theDate = cal.getTime();
				
			} catch (ParseException e) {
				e.printStackTrace();
				theDate = new Date();
			}

			//둘째줄
			Long money = null;
			String moneyStr = msg[1].replaceAll(MONEY_REG_EXP, "").trim();
			money = Long.parseLong(moneyStr);
			
			//세째줄
			String userName = msg[2].replaceAll("[<][>]", "").trim();
			
			//네째줄
			Long balance = null;
			if (msg[3].startsWith("잔액")) {
				String balanceStr = msg[3].replaceAll(MONEY_REG_EXP, "").trim();
				
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
			transaction.setBankName("IBK");
		} else if (message.getMsg().indexOf("출금") > 0) {
			String[] msg = message.getMsg().split("\n");
			
			//첫째줄
			String time = msg[0].substring(4, 9);
			Date theDate = null;
			try {
				theDate = smsTimeFormat.parse(time);
				Calendar cal = Calendar.getInstance();
				cal.setTime(theDate);
				Calendar now = Calendar.getInstance();
				now.setTime(smsInDateFormat.parse(message.getInDate()));
				cal.set(Calendar.YEAR, now.get(Calendar.YEAR));
				cal.set(Calendar.MONTH, now.get(Calendar.MONTH));
				cal.set(Calendar.DATE, now.get(Calendar.DATE));
				
				theDate = cal.getTime();
				
			} catch (ParseException e) {
				e.printStackTrace();
				theDate = new Date();
			}

			//둘째줄
			Long money = null;
			String moneyStr = msg[1].replaceAll(MONEY_REG_EXP, "").trim();				
			money = Long.parseLong(moneyStr);
			
			//세째줄
			 String userName = msg[2].replaceAll("[[<][>]]", "").trim();
			
			//네째줄
			Long balance = null;
			if (msg[3].startsWith("잔액")) {
				String balanceStr = msg[3].replaceAll(MONEY_REG_EXP, "").trim();
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
			transaction.setBankName("IBK");
		}
		
		return transaction;
	}
	
	private Transaction hanaBankProcess(KtfSmsMessage message) throws Exception {		
		Transaction transaction = new Transaction();
		
		if (message.getMsg().indexOf("입금") > 0) {
			String[] msg = message.getMsg().split("\n");
			
			//첫째줄
			String date = msg[0].replaceAll("하나,", "").trim();
			Date theDate = null;
			try {
				theDate = hanaDateFormat.parse(date);
				Calendar cal = Calendar.getInstance();
				cal.setTime(theDate);
				Calendar now = Calendar.getInstance();
				now.setTime(smsInDateFormat.parse(message.getInDate()));
				cal.set(Calendar.YEAR, now.get(Calendar.YEAR));
				
				theDate = cal.getTime();
				
			} catch (ParseException e) {
				e.printStackTrace();
				theDate = new Date();
			}

			//세째줄
			Long money = null;
			if (msg[2].startsWith("입금") || msg[2].startsWith("출금")) {
				String moneyStr = msg[2].replaceAll(MONEY_REG_EXP, "").trim();
				money = Long.parseLong(moneyStr);
			}
			
			//네째줄
			String userName = msg[3].trim();
			
			//다섯째줄
			Long balance = null;
			if (msg[4].startsWith("잔액")) {
				String balanceStr = msg[4].replaceAll(MONEY_REG_EXP, "").trim();
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
			transaction.setBankName("HANA");
		} else if (message.getMsg().indexOf("출금") > 0) {
			String[] msg = message.getMsg().split("\n");
			
			//첫째줄
			String date = msg[0].replaceAll("하나,", "").trim();
			Date theDate = null;
			try {
				theDate = hanaDateFormat.parse(date);
				Calendar cal = Calendar.getInstance();
				cal.setTime(theDate);
				Calendar now = Calendar.getInstance();
				now.setTime(smsInDateFormat.parse(message.getInDate()));
				cal.set(Calendar.YEAR, now.get(Calendar.YEAR));
				
				theDate = cal.getTime();
				
			} catch (ParseException e) {
				e.printStackTrace();
				theDate = new Date();
			}

			//세째줄
			Long money = null;
			if (msg[2].startsWith("입금") || msg[2].startsWith("출금")) {
				String moneyStr = msg[2].replaceAll(MONEY_REG_EXP, "").trim();
				money = Long.parseLong(moneyStr);
			}
			
			//네째줄
			String userName = msg[3].trim();
			
			//다섯째줄
			Long balance = null;
			if (msg[4].startsWith("잔액")) {
				String balanceStr = msg[4].replaceAll(MONEY_REG_EXP, "").trim();
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
			transaction.setBankName("HANA");
		}
				
		return transaction;
	}
	
	private Transaction nhBankProcess(KtfSmsMessage message) throws Exception {
		Transaction transaction = new Transaction();
		
		if (message.getMsg().indexOf("입금") > 0) {
			String[] msg = message.getMsg().split("[().\\s]");
			
			//둘째
			Date theDate = null;
			try {
				String strDate = msg[1].trim();
				theDate = nhDateFormat.parse(strDate);
				Calendar cal = Calendar.getInstance();
				cal.setTime(theDate);
				Calendar now = Calendar.getInstance();
				now.setTime(smsInDateFormat.parse(message.getInDate()));
				cal.set(Calendar.HOUR, now.get(Calendar.HOUR));
				cal.set(Calendar.MINUTE, now.get(Calendar.MINUTE));
				cal.set(Calendar.SECOND, now.get(Calendar.SECOND));
				theDate = cal.getTime();					
			} catch (ParseException e) {
				e.printStackTrace();
				theDate = new Date();
			}
				
			//넷째
			Long money = null;
			String moneyStr = msg[3].replaceAll(MONEY_REG_EXP, "").trim();
			money = Long.parseLong(moneyStr);
			
			//다섯째
			String userName = msg[4].trim();
			
			//일곱째
			Long balance = null;
			String balanceStr = msg[6].replaceAll(MONEY_REG_EXP, "").trim();				
			balance = Long.parseLong(balanceStr);						

			transaction.setType(Code.TRAN_TYPE_MONEYIN);
			transaction.setUserName(userName);
			transaction.setDate(theDate);
			transaction.setMoney(money);
			transaction.setBalance(balance);
			transaction.setMsgSeq(message.getMsgSeq());
			transaction.setInDate(message.getInDate());
			transaction.setIsCharge("N");
			transaction.setBankName("NH");
		} else if (message.getMsg().indexOf("출금") > 0) {
			String[] msg = message.getMsg().split("[().\\s]");
			
			//둘째
			Date theDate = null;
			try {
				String strDate = msg[1].trim();
				theDate = nhDateFormat.parse(strDate);
				Calendar cal = Calendar.getInstance();
				cal.setTime(theDate);
				Calendar now = Calendar.getInstance();
				now.setTime(smsInDateFormat.parse(message.getInDate()));
				cal.set(Calendar.HOUR, now.get(Calendar.HOUR));
				cal.set(Calendar.MINUTE, now.get(Calendar.MINUTE));
				cal.set(Calendar.SECOND, now.get(Calendar.SECOND));
				theDate = cal.getTime();					
			} catch (ParseException e) {
				e.printStackTrace();
				theDate = new Date();
			}
				
			//넷째
			Long money = null;
			String moneyStr = msg[3].replaceAll(MONEY_REG_EXP, "").trim();
			money = Long.parseLong(moneyStr);
			
			//다섯째
			String userName = msg[4].trim();
			
			//일곱째
			Long balance = null;
			String balanceStr = msg[6].replaceAll(MONEY_REG_EXP, "").trim();				
			balance = Long.parseLong(balanceStr);						

			transaction.setType(Code.TRAN_TYPE_MONEYOUT);
			transaction.setUserName(userName);
			transaction.setDate(theDate);
			transaction.setMoney(money * -1);
			transaction.setBalance(balance);
			transaction.setMsgSeq(message.getMsgSeq());
			transaction.setInDate(message.getInDate());
			transaction.setIsCharge("-");
			transaction.setBankName("NH");
		}
		
		return transaction;
	}
	
	public static void main(String args[]) {
		KtfSmsMessage message = new KtfSmsMessage();
		TransactionManager tm = new TransactionManager();
		Transaction transaction = null;
		//message.setMsg("신한 12/23 16:32[110-257-306***]입금      19,000잔액   6,121,400안민강");
		//message.setMsg("신한 12/23 16:31[110-257-306***]지급         100잔액   6,102,40002480104300750");
		//message.setMsg("신한 12/23 18:22[110-257-306***]입금     100,000잔액  21,840,368 이훈희");
		//message.setMsg("신한 12/23 17:01[110-257-306***]입금     250,000잔액  14,326,400제주:진경훈");
		//message.setMsg("우체국,23:47\n610********249\n입금39,000원\n잔액74,495,645원\n고정복");	
		//message.setMsg("우체국,23:44\n610********249\n출금1,250,000원\n잔액74,456,645원\n이성호");
		//message.setMsg("신한 02/11 08:09[110-290-795***]지급      10,000잔액      15,600004.김미경");
		//message.setMsg("신한 02/11 07:59[110-290-795***]입금      10,000잔액      25,600김미경");
		//message.setMsg("농협 2010/02/17 302-0080-1997-** 1,000원(성시원)입금.잔액1,000원");
		//message.setMsg("농협 2010/02/17 302-0080-1997-** 1,000원(성시원)출금.잔액0원");		
		message.setInDate("20100216084431");
		
		try {
			if (message.getMsg().startsWith("[KB]"))
				transaction = tm.kbBankProcess(message);
			else if (message.getMsg().startsWith("우리은행"))
				transaction = tm.wooriBankProcess(message);
			else if (message.getMsg().startsWith("신한"))
				transaction = tm.shinhanBankProcess(message);
			else if (message.getMsg().startsWith("우체국"))
				transaction = tm.postOfficeProcess(message);
			else if (message.getMsg().endsWith("기업은행"))
				transaction = tm.ibkProcess(message);
			else if (message.getMsg().startsWith("하나"))
				transaction = tm.hanaBankProcess(message);
			else if (message.getMsg().startsWith("농협"))
				transaction = tm.nhBankProcess(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println(transaction);
	}
}
