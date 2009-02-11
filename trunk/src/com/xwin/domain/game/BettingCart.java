package com.xwin.domain.game;

import java.util.ArrayList;
import java.util.List;

import com.xwin.domain.XwinObject;

public class BettingCart extends XwinObject
{
	private static final long serialVersionUID = 8646838591449782692L;
	
	private List<GameFolder> gameFolderList = new ArrayList<GameFolder>();
	
	public List<GameFolder> getGameFolderList()
	{
		return gameFolderList;
	}
	
	public void add(GameFolder gameFolder)
	{
		gameFolderList.add(gameFolder);
	}
	
	public void remove(Object o)
	{
		gameFolderList.remove(o);
	}
	
	public void removeIndex(int index)
	{
		gameFolderList.remove(index);
	}
	
	public void clear()
	{
		gameFolderList.clear();
	}
	
	public GameFolder get(int index)
	{
		return gameFolderList.get(index);
	}
}
