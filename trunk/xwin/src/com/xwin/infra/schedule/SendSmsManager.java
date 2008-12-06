package com.xwin.infra.schedule;

import java.util.List;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.xwin.domain.comm.SmsWait;
import com.xwin.infra.dao.SmsWaitDao;
import com.xwin.infra.sms.MunjaBadaConnector;
import com.xwin.infra.sms.SendSmsConnector;
import com.xwin.infra.util.XmlUtil;

public class SendSmsManager extends QuartzJobBean
{
	//private static final String SERVER_URL = "http://bethit.net:10180/external.aspx?mode=getSmsWaitList";
	private static final String SERVER_URL = "http://localhost:8080/xwin/external.aspx?mode=getSmsWaitList";
	
	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException
	{
		SmsWaitDao smsWaitDao = (SmsWaitDao) context.getJobDetail().getJobDataMap().get("smsWaitDao");
		SendSmsConnector sendSmsConnector = (MunjaBadaConnector) context.getJobDetail().getJobDataMap().get("munjaBadaConnector");
		
		String smsWaitXml = null;
		HttpClient hc = new HttpClient();
		hc.getHttpConnectionManager().getParams().setSoTimeout(5000);
		
		GetMethod get = new GetMethod(SERVER_URL);
		try {
			hc.executeMethod(get);
			smsWaitXml = get.getResponseBodyAsString(); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//List<SmsWait> smsWaitList = smsWaitDao.selectSmsWaitList();
		
		List<SmsWait> smsWaitList = (List<SmsWait>) XmlUtil.fromXml(smsWaitXml);
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
