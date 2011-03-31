package com.xwin.infra.schedule;

import java.util.Calendar;
import java.util.Date;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.xwin.domain.admin.Admin;
import com.xwin.infra.dao.GameDao;

public class GameBetStatusManager extends QuartzJobBean
{
	private final long THREE_MINUTE = 3 * 60 * 1000;
	
	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException
	{
		GameDao gameDao = (GameDao) context.getJobDetail().getJobDataMap().get("gameDao");
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MINUTE, 5);

		gameDao.batchGameBetStatus(cal.getTime());
		gameDao.batchGameStatus(new Date());
		
		try
		{
			Date now = new Date();
			
			if (Admin.AUTO_CHARGE_ALIVE == null || now.getTime() - Admin.AUTO_CHARGE_ALIVE.getTime() > THREE_MINUTE)
			{
				System.out.println("자충박동이 오지 않는다. 재시작 한다.");
				
				Process p = Runtime.getRuntime().exec("D:\\Tomcat 6.0\\show.bat");
			}
			else
			{
				System.out.println("자충박동이 잘 온다.");
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
}
