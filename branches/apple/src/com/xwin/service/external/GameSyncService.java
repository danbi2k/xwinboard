package com.xwin.service.external;

import java.util.List;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;

import com.xwin.domain.game.Game;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.service.admin.XwinService;

public class GameSyncService extends XwinService
{
	private static final String GAME_URL = "http://bethit.net:10180/external.aspx?mode=getGameList";
	private static final String LEAGUE_URL = "http://bethit.net:10180/external.aspx?mode=getLeagueList";
	
	public void sync()
	{
		String gameXml = null;
		HttpClient hc = new HttpClient();
		hc.getHttpConnectionManager().getParams().setSoTimeout(10000);
		
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
					game.setDisplayStatus(Code.GAME_DISPLAY_CLOSE);
					if (game.getWinRate() <= 1.0 || game.getLoseRate() <= 1.0)
						continue;
					
					if (game.getType().equals("wdl")) {
						Double winRate = XwinUtil.doubleCut(calcRate(game.getWinRate()));
						Double drawRate = XwinUtil.doubleCut(calcRate(game.getDrawRate()));
						Double loseRate = XwinUtil.doubleCut(calcRate(game.getLoseRate()));
						
						game.setWinRate(winRate);
						game.setDrawRate(drawRate);
						game.setLoseRate(loseRate);
					} else if (game.getType().equals("handy")) {
						Double winRate = game.getWinRate() + 0.05;
						Double loseRate = game.getLoseRate() + 0.05;
						
						game.setWinRate(winRate);
						game.setLoseRate(loseRate);
					}
					gameDao.insertGame(game);
				} catch (Exception e) {
					System.out.println("dup : " + game.getId());
					//e.printStackTrace();
				}
			}
		}
	}
	
	public Double calcRate(Double x)
	{
		if (x <= 1.0)
			return x;
		
		Double y = 0.0;
		
		if (x < 2.0) {
			y = 1.0 + ((x - 1.0) * 1.2);
		} else {
			y = 1.0 + ((x - 1.0) * 1.1);
		}
		
		return y;
	}
}
