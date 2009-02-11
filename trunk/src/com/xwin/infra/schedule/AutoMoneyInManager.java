package com.xwin.infra.schedule;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.xwin.service.admin.MoneyInService;

public class AutoMoneyInManager extends QuartzJobBean
{
	private MoneyInService moneyInService = null;
	
	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException
	{	
		moneyInService = (MoneyInService) context.getJobDetail().getJobDataMap().get("moneyInService");
		
		try {
			moneyInService.processMoneyInAuto();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
