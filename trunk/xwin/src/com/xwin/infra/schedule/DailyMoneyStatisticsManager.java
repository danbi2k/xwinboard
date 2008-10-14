package com.xwin.infra.schedule;

import java.util.Date;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.xwin.infra.dao.BettingDao;

public class DailyMoneyStatisticsManager extends QuartzJobBean
{

	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException
	{
		BettingDao bettingDao = (BettingDao) context.getJobDetail().getJobDataMap().get("bettingDao");
		
		bettingDao.insertDailyMoneyStatistics();
	}
}
