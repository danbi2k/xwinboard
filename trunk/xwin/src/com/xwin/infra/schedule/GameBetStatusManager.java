package com.xwin.infra.schedule;

import java.util.Calendar;
import java.util.Date;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.xwin.infra.dao.GameDao;

public class GameBetStatusManager extends QuartzJobBean
{

	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException
	{
		System.out.println("**************");
		System.out.println("START Game Status Updater");
		System.out.println("**************");
		
		GameDao gameDao = (GameDao) context.getJobDetail().getJobDataMap().get("gameDao");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MINUTE, 10);

		gameDao.batchGameBetStatus(cal.getTime());
		gameDao.batchGameStatus(new Date());
		
		System.out.println("**************");
		System.out.println("END Game Status Updater");
		System.out.println("**************");
	}
}
