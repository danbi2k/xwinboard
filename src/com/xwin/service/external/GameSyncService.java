package com.xwin.service.external;

import java.util.Date;
import java.util.List;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;

import com.xwin.domain.admin.Admin;
import com.xwin.domain.game.Game;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.service.admin.XwinService;

public class GameSyncService extends XwinService
{
	private String syncUrl = null;
//	private String leagueUrl = null;
	
	public void sync() throws Exception
	{
		Date date = new Date();
		String dateStr = XwinUtil.getBoardItemDate(date);
		String gameXml = null;
		HttpClient hc = new HttpClient();
		hc.getHttpConnectionManager().getParams().setSoTimeout(50000);
		
		PostMethod post = new PostMethod(syncUrl + "?mode=getGameList");		
		post.addRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=utf-8");
		
		try {	
			hc.executeMethod(post);
			gameXml = post.getResponseBodyAsString();
//			System.out.println(gameXml);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		int wdl_count = 0, handy_count = 0;
		List<Game> gameList = (List<Game>) XmlUtil.fromXml(gameXml);
		if (gameList != null) {
			for (Game game : gameList) {
//				if (game.getDisplayStatus().equals(Code.GAME_DISPLAY_CLOSE))
//					continue;
				
				game.setSyncId(game.getId());
//				game.setDisplayStatus(Code.GAME_DISPLAY_CLOSE);
				if (game.getWinRate() <= 1.0 || game.getLoseRate() <= 1.0)
					continue;
				
				Game dbGame = gameDao.selectSyncGame(game.getId());
				if (dbGame == null) {					
					if (game.getType().equals("wdl")) {
						Double winRate = XwinUtil.doubleCut(calcRate(game.getWinRate()));
						Double drawRate = XwinUtil.doubleCut(calcRate(game.getDrawRate()));
						Double loseRate = XwinUtil.doubleCut(calcRate(game.getLoseRate()));
						
						game.setWinRate(winRate);
						game.setDrawRate(drawRate);
						game.setLoseRate(loseRate);
						
						wdl_count++;
					} else if (game.getType().equals("handy")) {
						Double winRate = game.getWinRate() + 0.02;
						Double loseRate = game.getLoseRate() + 0.02;
						
						game.setWinRate(winRate);
						game.setLoseRate(loseRate);
						
						handy_count++;
					}
					gameDao.insertGame(game);
				} else if (dbGame.getSyncDeny().equals("Y")) {
					String note = XwinUtil.nvl(dbGame.getNote());
					
					Game syncGame = new Game();
					syncGame.setId(dbGame.getId());
					syncGame.setHomeTeam(game.getHomeTeam());
					syncGame.setAwayTeam(game.getAwayTeam());
					syncGame.setGameDate(game.getGameDate());
					
					syncGame.setDisplayStatus(game.getDisplayStatus());
					
					if (dbGame.getHomeTeam().equals(syncGame.getHomeTeam()) == false)
						note += dateStr + " 홈팀명변경: " + dbGame.getHomeTeam() + " -> " + syncGame.getHomeTeam() + "\n";
					if (dbGame.getAwayTeam().equals(syncGame.getAwayTeam()) == false)
						note += dateStr + " 원정팀명변경: " + dbGame.getAwayTeam() + " -> " + syncGame.getAwayTeam() + "\n";
					if (dbGame.getGameDate().equals(syncGame.getGameDate()) == false)
						note += dateStr + " 경기일시변경: " + XwinUtil.getBoardItemDate(dbGame.getGameDate()) + " -> " + XwinUtil.getBoardItemDate(syncGame.getGameDate()) + "\n";
					
					if (game.getType().equals("wdl")) {
						Double winRate = XwinUtil.doubleCut(calcRate(game.getWinRate()));
						Double drawRate = XwinUtil.doubleCut(calcRate(game.getDrawRate()));
						Double loseRate = XwinUtil.doubleCut(calcRate(game.getLoseRate()));
						
						syncGame.setWinRate(winRate);
						syncGame.setDrawRate(drawRate);
						syncGame.setLoseRate(loseRate);
						
						if (dbGame.getWinRate().equals(syncGame.getWinRate()) == false)
							note += dateStr + " 승배당변경 : " + dbGame.getWinRateStr() + " -> " + syncGame.getWinRateStr() + "\n";
						if (dbGame.getDrawRate().equals(syncGame.getDrawRate()) == false)
							note += dateStr + " 무배당변경 : " + dbGame.getDrawRateStr() + " -> " + syncGame.getDrawRateStr() + "\n";
						if (dbGame.getLoseRate().equals(syncGame.getLoseRate()) == false)
							note += dateStr + " 패배당변경 : " + dbGame.getLoseRateStr() + " -> " + syncGame.getLoseRateStr() + "\n";
					} else if (game.getType().equals("handy")) {
						Double winRate = XwinUtil.doubleCut(game.getWinRate() + 0.02);
						Double loseRate = XwinUtil.doubleCut(game.getLoseRate() + 0.02);
						Double drawRate = XwinUtil.doubleCut(game.getDrawRate());
						
						syncGame.setWinRate(winRate);
						syncGame.setDrawRate(drawRate);
						syncGame.setLoseRate(loseRate);
						
						if (dbGame.getWinRate().equals(syncGame.getWinRate()) == false)
							note += dateStr + " 승배당변경 : " + dbGame.getWinRateStr() + " -> " + syncGame.getWinRateStr() + "\n";
						if (dbGame.getDrawRate().equals(syncGame.getDrawRate()) == false)
							note += dateStr + " 핸디캡변경 : " + dbGame.getDrawRate() + " -> " + syncGame.getDrawRate() + "\n";
						if (dbGame.getLoseRate().equals(syncGame.getLoseRate()) == false)
							note += dateStr + " 패배당변경 : " + dbGame.getLoseRateStr() + " -> " + syncGame.getLoseRateStr() + "\n";
					}
					
					syncGame.setNote(note);
					gameDao.updateGame(syncGame);
				}
			}
		}
		Admin.SYNC_COUNT_WDL = wdl_count;
		Admin.SYNC_COUNT_HANDY = handy_count;
		
		post = new PostMethod(syncUrl + "?mode=getProcessedGameList");		
		post.addRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=utf-8");
		
		String processXml = null;
		try {	
			hc.executeMethod(post);
			processXml = post.getResponseBodyAsString();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		List<Game> processList = (List<Game>) XmlUtil.fromXml(processXml);
		if (processList != null) {
			for (Game game : processList) {
				final Game dbGame = gameDao.selectSyncGame(game.getId());
				
				if (dbGame != null && dbGame.getStatus().equals(Code.GAME_STATUS_RUN)) {
					dbGame.setHomeScore(game.getHomeScore());
					dbGame.setAwayScore(game.getAwayScore());
					dbGame.setResult(processService.judgeGameScore(dbGame));
					dbGame.setStatus(Code.GAME_STATUS_END);
						
					gameDao.updateGame(dbGame);
						
					try {
						Thread judge = new Thread() {
							public void run() {
								processService.judgeGameResult(dbGame, false);
								
								Game processedGame = new Game();
								processedGame.setId(dbGame.getId());
								processedGame.setProcessDate(new Date());
								gameDao.updateGame(processedGame);
							}
						};
						judge.start();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	public Double calcRate(Double x)
	{
		return x;
		
//		if (x <= 1.0)
//			return x;
//		
//		Double y = 0.0;
//		
//		if (x < 2.0) {
//			y = 1.0 + ((x - 1.0) * 1.05);
//		} else {
//			y = 1.0 + ((x - 1.0) * 1.05);
//		}
//		
//		return y;
	}

	public void setSyncUrl(String syncUrl) {
		this.syncUrl = syncUrl;
	}
}
