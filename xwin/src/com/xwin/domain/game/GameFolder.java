package com.xwin.domain.game;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.XwinObject;
import com.xwin.infra.util.XwinUtil;

public class GameFolder extends XwinObject
{
	private static final long serialVersionUID = 6490338832855997259L;
	
	private Map<String, GameFolderItem> gameFolder = new HashMap<String, GameFolderItem>();
	
	private Double rate = null;
	private String rateStr = null;
	private Long expect = null;
	private Long money = null;
	private String type = null;

	public GameFolder(String type)
	{
		this.type = type;
	}
	
	public GameFolderItem get(String key)
	{
		return gameFolder.get(key);
	}
	
	public void put(String key, GameFolderItem gameFolderItem)
	{
		gameFolder.put(key, gameFolderItem);
	}
	
	public void remove(String key)
	{
		gameFolder.remove(key);
	}

//	public Collection<GameFolderItem> values()
//	{
//		return gameFolder.values();
//	}
	
	public List<GameFolderItem> getGameFolderItemList()
	{
		List<GameFolderItem> itemList = new ArrayList<GameFolderItem>(gameFolder.size());
		itemList.addAll(gameFolder.values());
		
		return itemList;
		
	}
	
	public boolean containsKey(String key)
	{
		return gameFolder.containsKey(key);
	}
	
	public int size()
	{
		return gameFolder.size();
	}

	public Long getExpect() {
		return expect;
	}

	public void setExpect(Long expect) {
		this.expect = expect;
	}

	public Long getMoney() {
		return money;
	}

	public void setMoney(Long money) {
		this.money = money;
	}

	public Double getRate() {
		return rate;
	}

	public void setRate(Double rate) {
		this.rate = rate;
		this.rateStr = XwinUtil.to2Digit(rate);
	}

	public String getRateStr() {
		return rateStr;
	}

	public void setRateStr(String rateStr) {
		this.rateStr = rateStr;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void calculate()
	{
		Double totalRate = 0.0;
			
		List<GameFolderItem> itemList = this.getGameFolderItemList();
		if (itemList != null && itemList.size() > 0) {
			totalRate = 1.0;
			for (GameFolderItem gfi : itemList) {
				Double rate = null;
				if (gfi.getGuess().equals("W"))
					rate = gfi.getWinRate();
				else if (gfi.getGuess().equals("D"))
					rate = gfi.getDrawRate();
				else if (gfi.getGuess().equals("L"))
					rate = gfi.getLoseRate();
				
				totalRate *= rate;
			}
		}
		
		this.setRate(XwinUtil.doubleCut(totalRate));
		this.expect = XwinUtil.calcExpectMoney(this.rate, this.money);
	}
}
