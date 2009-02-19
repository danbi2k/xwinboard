package com.xwin.infra.schedule;

import java.util.List;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.xwin.domain.game.Game;
import com.xwin.infra.dao.GameDao;
import com.xwin.infra.util.XmlUtil;

public class GameSyncManager extends QuartzJobBean
{
	private static final String GAME_URL = "http://bethit.net:10180/external.aspx?mode=getGameList";
	private static final String LEAGUE_URL = "http://bethit.net:10180/external.aspx?mode=getLeagueList";
	//private static final String SERVER_URL = "http://localhost:8080/xwin/external.aspx?mode=getSmsWaitList";
	//private static final String ALLUSER_URL = "http://localhost:8080/xwin/external.aspx?mode=getAllNormalPhoneNumber";
	
	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException
	{
		GameDao gameDao = (GameDao) context.getJobDetail().getJobDataMap().get("gameDao");
		
		String gameXml = null;
		HttpClient hc = new HttpClient();
		hc.getHttpConnectionManager().getParams().setSoTimeout(5000);
		
		PostMethod post = new PostMethod(GAME_URL);		
		post.addRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=utf-8");
		
		try {	
			hc.executeMethod(post);
			gameXml = post.getResponseBodyAsString();
			System.out.println(gameXml);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//List<SmsWait> smsWaitList = smsWaitDao.selectSmsWaitList();
		
		List<Game> gameList = (List<Game>) XmlUtil.fromXml(gameXml);
		if (gameList != null) {
			for (Game game : gameList) {
				try {
					game.setSyncId(game.getId());
					gameDao.insertGame(game);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
