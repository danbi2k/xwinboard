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
import com.xwin.infra.dao.TransactionDao;
import com.xwin.infra.sms.KtfSmsConnector;
import com.xwin.infra.util.Code;
import com.xwin.service.admin.MoneyInService;

public class AutoMoneyInManager extends QuartzJobBean
{
	private static final SimpleDateFormat smsDateFormat = new SimpleDateFormat("MM/dd HH:mm");
	
	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException
	{
		TransactionDao transactionDao = (TransactionDao) context.getJobDetail().getJobDataMap().get("transactionDao");
		KtfSmsConnector ktfSmsConnector = (KtfSmsConnector) context.getJobDetail().getJobDataMap().get("ktfSmsConnector");
		MoneyInService moneyInService = (MoneyInService) context.getJobDetail().getJobDataMap().get("moneyInService");
		
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
				
				Transaction transaction = new Transaction();
				
				if (message.getMsg().startsWith("[KB]") && message.getMsg().indexOf("입금") > 0) {
					
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
					
					transactionDao.insertTransaction(transaction);
				} else if (message.getMsg().startsWith("[KB]") && message.getMsg().indexOf("출금") > 0) {
					
				}
			}	
		}
		
		try {
			moneyInService.processMoneyInAuto();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
