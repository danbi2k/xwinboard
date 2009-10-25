package com.xwin.web.controller.game;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;

import com.xwin.domain.game.BettingCart;
import com.xwin.domain.game.Game;
import com.xwin.domain.game.GameFolder;
import com.xwin.domain.game.GameFolderItem;
import com.xwin.domain.user.Member;
import com.xwin.infra.util.Code;
import com.xwin.infra.util.XmlUtil;
import com.xwin.infra.util.XwinUtil;
import com.xwin.web.command.FolderCalc;
import com.xwin.web.command.ResultXml;
import com.xwin.web.controller.XwinController;

public class BettingController extends XwinController
{
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger
			.getLogger(BettingController.class);

	private static final long MAX_EXPECT = 3000000;
	
	public synchronized ModelAndView betting(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		ResultXml rx = null;
		
		String _type = request.getParameter("type");
		String _money = request.getParameter("money");
		String _action = request.getParameter("action");
		HttpSession session = request.getSession();
		
		Member sessionMember = (Member) session.getAttribute("Member");		
		Member member = memberDao.selectMember(sessionMember.getUserId(), null);
		BettingCart bettingCart = (BettingCart) session.getAttribute("BettingCart");
		
		GameFolder gameFolder =
			(GameFolder)session.getAttribute("gameFolder_" + _type);
		
		Long money = Long.parseLong(_money);		
		FolderCalc fc = getFolderCalc(gameFolder, money, member.getBalance());
		Integer retVal = 0;
		
		List<GameFolderItem> itemList = gameFolder.getGameFolderItemList();
		if (itemList.size() == 0) {
			rx = new ResultXml(-1, "선택하신 게임이 없습니다", null);
		}
		else if (bettingService.checkBettingAccept(gameFolder) == false) {
			rx = new ResultXml(-2, "일부 게임이 배팅 마감 상태 입니다", null);
		}
		else if (fc.getMoney() < 5000) {
			rx = new ResultXml(-1, "5,000캐쉬 이상 배팅 하셔야 합니다", null);
		}
		else if (fc.getMoney() > 1000000) {
			rx = new ResultXml(-1, "1,000,000캐쉬 이상은 배팅 하실 수 없습니다", null);
		}
		else if (fc.getExpect() > MAX_EXPECT) {
			rx = new ResultXml(-1, "예상 배당금은 3000,000캐쉬 이하만 허용 됩니다", null);
		}
		else if (_action.equals("betting") && fc.getAfter() < 0) {
			rx = new ResultXml(-1, "캐쉬 잔고가 부족합니다", null);
		}
		else if ((retVal = bettingService.checkDuplicateBetting(gameFolder, member.getUserId())) < 0) {
			if (retVal == -1)
				rx = new ResultXml(-1, "중복배팅입니다\n배팅금액 1,000,000캐쉬 초과", null);
			else
				rx = new ResultXml(-1, "중복배팅입니다\n배당금액 3,000,000캐쉬 초과", null);
		}
		else if (_action.equals("betting")) {
			bettingService.processBetting(gameFolder, member, Code.SOURCE_WEB);
			
			session.removeAttribute("gameFolder_" + _type);
			
			rx = new ResultXml(0, "배팅에 성공하였습니다\n회원님의 대박을 기원합니다", null);
			Member betMember = (Member) session.getAttribute("Member");
			betMember.setBettingDate(new Date());
		}
		else if (_action.equals("cart")) {
			bettingCart.add(gameFolder);
			
			rx = new ResultXml(0, "배팅카트에 추가 되었습니다", null);
		}
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));

		return mv;
	}
	
	public ModelAndView addGameFolder(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String type = request.getParameter("type");
		HttpSession session = request.getSession();
		GameFolder gameFolder = (GameFolder) session.getAttribute("gameFolder_" + type);
		Member member = (Member) session.getAttribute("Member");		
		
		String gameId = request.getParameter("gameId");
		String guess = request.getParameter("guess");
		String _money = request.getParameter("money");		
		
		Long money = 0L;
		if (_money != null)
			money = Long.parseLong(_money);
		
		FolderCalc fc = getFolderCalc(gameFolder, money, member.getBalance());		
		Game game = gameDao.selectGame(gameId);
		Double thisRate = null;
		if (guess.equals("W"))
			thisRate = game.getWinRate();
		else if (guess.equals("D"))
			thisRate = game.getDrawRate();
		else if (guess.equals("L"))
			thisRate = game.getLoseRate();
		
		int retCode = 0;
		String message = null;
		
		if (gameFolder.size() >= 10 && gameFolder.containsKey(gameId) == false) {
			gameFolder.remove(game.getId());
			retCode = -1;
			message = "10 폴더를 초과하였습니다";
		} else if (XwinUtil.calcExpectMoney(thisRate * fc.getRate(), money) > MAX_EXPECT) {
			gameFolder.remove(game.getId());
			retCode = -1;
			message = "예상 배당금은 3,000,000캐쉬 이하만 허용 됩니다";
		} else if (game.getStatus().equals(Code.GAME_STATUS_RUN) == false ||
				game.getBetStatus().equals(Code.BETTING_STATUS_ACCEPT) == false) {
			gameFolder.remove(game.getId());
			retCode = -2;
			message = "게임이 배팅 마감 상태 입니다";
		} else if ((guess.equals("W") && game.getWinDeny().equals("Y") == false) ||
				(guess.equals("D") && game.getDrawDeny().equals("Y") == false) ||
				(guess.equals("L") && game.getLoseDeny().equals("Y") == false)) {
			gameFolder.remove(game.getId());
			retCode = -1;
			message = "게임이 배팅 금지 상태 입니다";
		} else {
			GameFolderItem gfi = new GameFolderItem();
			gfi.setId(gameId);
			gfi.setHomeTeam(game.getHomeTeam());
			gfi.setAwayTeam(game.getAwayTeam());
			gfi.setWinRate(game.getWinRate());
			gfi.setDrawRate(game.getDrawRate());
			gfi.setLoseRate(game.getLoseRate());
			gfi.setSelRate(thisRate);
			gfi.setGuess(guess);
			gfi.setLeagueName(game.getLeagueName());
			gfi.setType(game.getType());
			gfi.setGameDate(game.getGameDate());
			
			gameFolder.put(gameId, gfi);
		}
		
		List<GameFolderItem> itemList = gameFolder.getGameFolderItemList();
		ResultXml rx = new ResultXml(retCode, message, itemList);
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView deleteGameFolder(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String type = request.getParameter("type");
		String gameId = request.getParameter("gameId");
		
		HttpSession session = request.getSession();
		GameFolder gameFolder = (GameFolder) session.getAttribute("gameFolder_" + type);
		
		gameFolder.remove(gameId);
		
		List<GameFolderItem> itemList = gameFolder.getGameFolderItemList();
		
		ResultXml rx = new ResultXml(0, null, itemList);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView getGameFolder(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String type = request.getParameter("type");
		
		HttpSession session = request.getSession();
		GameFolder gameFolder = (GameFolder) session.getAttribute("gameFolder_" + type);
		
		List<GameFolderItem> itemList = gameFolder.getGameFolderItemList();
		
		ResultXml rx = new ResultXml(0, null, itemList);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(rx));
		
		return mv;
	}
	
	public ModelAndView emptyGameFolder(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		//if (accessDao.selectBlockIpCount(request.getRemoteAddr()) > 0)
			//return new ModelAndView("block");
		if (request.getSession().getAttribute("Member") == null)
			return new ModelAndView("dummy");
		
		String type = request.getParameter("type");
		HttpSession session = request.getSession();
		session.removeAttribute("gameFolder_" + type);
		
		ModelAndView mv = new ModelAndView("xmlFacade");
		mv.addObject("resultXml", XmlUtil.toXml(new ResultXml(0, null, null)));
		return mv;
	}
	
	private FolderCalc getFolderCalc(GameFolder gameFolder, Long money, Long memberBalance)
	{
		gameFolder.setMoney(money);
		gameFolder.calculate();
		
		Double cutRate = gameFolder.getRate();
		Long expect = gameFolder.getExpect();
		Long balance = memberBalance;		
		Long after = null;
		if (cutRate > 0)
			after = balance - money;
		else
			after = balance;
		
		FolderCalc fc = new FolderCalc();
		
		fc.setRate(cutRate);
		fc.setBalance(balance);
		fc.setMoney(money);
		fc.setAfter(after);
		fc.setExpect(expect);
		
		return fc;
	}
}
