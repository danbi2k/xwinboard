package com.xwin.domain.game;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class GameFolder
{
	private Map<String, GameFolderItem> gameFolder = new HashMap<String, GameFolderItem>();
	
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

	public Collection<GameFolderItem> values()
	{
		return gameFolder.values();
	}
	
	public boolean containsKey(String key)
	{
		return gameFolder.containsKey(key);
	}
	
	public int size()
	{
		return gameFolder.size();
	}
}
