package com.xwin.infra.schedule;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.xwin.infra.dao.KtfSmsDao;
import com.xwin.infra.sms.KtfSmsConnector;

public class KtfSmsManager extends QuartzJobBean
{

	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException
	{
		KtfSmsDao ktfSmsDao = (KtfSmsDao) context.getJobDetail().getJobDataMap().get("ktfSmsDao");
		KtfSmsConnector ktfSmsConnector = (KtfSmsConnector) context.getJobDetail().getJobDataMap().get("ktfSmsConnector");
		
		ktfSmsConnector.processDbTranscation();
	}
}
