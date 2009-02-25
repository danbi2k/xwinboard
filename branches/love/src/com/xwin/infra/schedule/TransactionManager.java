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
	private static final String[] bankList = {"국민","기업","농협","신한","조흥","외환","우체국",
		"SC제일","하나","한국시티","한미","우리","경남","광주","대구","도이치","부산",
		"산업","	수협","전북","제주","새마을","신협","	HSBC","상호저축"};
	
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
				
				if (message.getMsg().startsWith("[KB]"))
					transaction = kbBankProcess(message);
				else if (message.getMsg().startsWith("우리은행"))
					transaction = wooriBankProcess(message);
				else if (message.getMsg().startsWith("신한"))
					transaction = shinhanBankProcess(message);
				else {
					ktfSmsDao.insertMessage(message);
				}
				
				if (transaction != null) {
					transactionList.add(transaction);
				}
			}	
		}
		
		try {
			transactionService.sendTransaction(transactionList);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private Transaction shinhanBankProcess(KtfSmsMessage message) {
		Transaction transaction = new Transaction();
		
		if (message.getMsg().indexOf("입금") > 0) {
			try {
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
					String moneyStr = msg[3].replaceAll("잔액", "");
					moneyStr = moneyStr.replaceAll(",", "");
					moneyStr = moneyStr.trim();
					
					money = Long.parseLong(moneyStr);
				}
				
				Long balance = null;
				String xtr = msg[4].replaceAll(",", "");
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
				
				String balanceStr = xtr.substring(0, x);
				balanceStr = balanceStr.trim();
				
				balance = Long.parseLong(balanceStr);						

				transaction.setType(Code.TRAN_TYPE_MONEYIN);
				transaction.setUserName(userName);
				transaction.setDate(theDate);
				transaction.setMoney(money);
				transaction.setBalance(balance);
				transaction.setMsgSeq(message.getMsgSeq());
				transaction.setInDate(message.getInDate());
				transaction.setIsCharge("N");
			
				transactionDao.insertTransaction(transaction);
				
				return transaction;
					
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("트랜젝션을 넣지 못했습니다");
				System.out.println(message);
			}
		} else if (message.getMsg().indexOf("지급") > 0) {
			try {
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
					String moneyStr = msg[3].replaceAll("잔액", "");
					moneyStr = moneyStr.replaceAll(",", "");
					moneyStr = moneyStr.trim();
					
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
				balanceStr = balanceStr.replaceAll(",", "");
				balanceStr = balanceStr.trim();				
				balance = Long.parseLong(balanceStr);	

				transaction.setType(Code.TRAN_TYPE_MONEYOUT);
				transaction.setUserName(userName);
				transaction.setDate(theDate);
				transaction.setMoney(money * -1);
				transaction.setBalance(balance);
				transaction.setMsgSeq(message.getMsgSeq());
				transaction.setInDate(message.getInDate());
				transaction.setIsCharge("-");
			
				transactionDao.insertTransaction(transaction);
				
				return transaction;
					
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("트랜젝션을 넣지 못했습니다");
				System.out.println(message);
			}
		}
		
		return null;
	}

	private Transaction kbBankProcess(KtfSmsMessage message) {		
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
				
				return transaction;
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
				
				return transaction;
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("트랜젝션을 넣지 못했습니다");
				System.out.println(message);
			}
		}
		else {
			ktfSmsDao.insertMessage(message);
		}
		
		return null;
	}

	private Transaction wooriBankProcess(KtfSmsMessage message) {		
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
				
				return transaction;
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
				
				return transaction;
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("트랜젝션을 넣지 못했습니다");
				System.out.println(message);
			}
		}
		else {
			ktfSmsDao.insertMessage(message);
		}
		
		return null;
	}
	
	public static void main(String args[]) {
		KtfSmsMessage message = new KtfSmsMessage();
		//message.setMsg("신한 12/23 16:32[110-257-306***]입금      19,000잔액   6,121,400안민강");
		//message.setMsg("신한 12/23 16:31[110-257-306***]지급         100잔액   6,102,40002480104300750");
		//message.setMsg("신한 12/23 18:22[110-257-306***]입금     100,000잔액  21,840,368 이훈희");
		message.setMsg("신한 12/23 17:01[110-257-306***]입금     250,000잔액  14,326,400제주:진경훈");
		
		TransactionManager tm = new TransactionManager();
		tm.shinhanBankProcess(message);
	}
}
