package com.xwin.infra.schedule;

import java.util.List;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.xwin.domain.comm.SmsWait;
import com.xwin.infra.dao.SmsWaitDao;
import com.xwin.infra.sms.MunjaBadaConnector;
import com.xwin.infra.sms.SendSmsConnector;

public class SendSmsManager extends QuartzJobBean
{

	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException
	{
		SmsWaitDao smsWaitDao = (SmsWaitDao) context.getJobDetail().getJobDataMap().get("smsWaitDao");
		SendSmsConnector sendSmsConnector = (MunjaBadaConnector) context.getJobDetail().getJobDataMap().get("munjaBadaConnector");
		
		List<SmsWait> smsWaitList = smsWaitDao.selectSmsWaitList();
		if (smsWaitList != null) {
			for (SmsWait smsWait : smsWaitList) {
				try {
					sendSmsConnector.sendSms(smsWait.getMsg(), smsWait.getPhone(), smsWait.getCallback());
					smsWaitDao.deleteSmsWait(smsWait.getId());
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
