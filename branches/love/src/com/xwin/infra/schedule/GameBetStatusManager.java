package com.xwin.infra.schedule;

import java.util.Calendar;
import java.util.Date;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.xwin.infra.dao.GameDao;
import com.xwin.infra.dao.TotoDao;

public class GameBetStatusManager extends QuartzJobBean
{

	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException
	{
		GameDao gameDao = (GameDao) context.getJobDetail().getJobDataMap().get("gameDao");
		TotoDao totoDao = (TotoDao) context.getJobDetail().getJobDataMap().get("totoDao");
		
		Date today = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MINUTE, 5);

		gameDao.batchGameBetStatus(cal.getTime());
		gameDao.batchGameStatus(today);
		
		totoDao.batchTotoBetStatus(today);
	}
}
