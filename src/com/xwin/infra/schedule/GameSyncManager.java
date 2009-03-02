package com.xwin.infra.schedule;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.xwin.service.external.GameSyncService;

public class GameSyncManager extends QuartzJobBean
{
	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException
	{
		GameSyncService gameSyncService =
			(GameSyncService) context.getJobDetail().getJobDataMap().get("gameSyncService");
		
		gameSyncService.sync();
	}
}
