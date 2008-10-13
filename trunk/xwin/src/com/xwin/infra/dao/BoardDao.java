package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.board.BoardComment;
import com.xwin.domain.board.BoardItem;

public class BoardDao extends XwinDao
{
	public String insertBoardItem(BoardItem boardItem)
	{
		String boardId = (String)
			sqlMapClientTemplate.insert("insertBoardItem", boardItem);
		
		return boardId;
	}
	
	public void deleteBoardItem(String id)
	{
		sqlMapClientTemplate.delete("deleteBoardItem", id);
	}
	
	public BoardItem selectBoardItem(String id, String boardName)
	{
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		param.put("boardName", boardName);
		
		BoardItem boardItem = 
			(BoardItem) sqlMapClientTemplate.queryForObject("selectBoardItem", param);
		
		List<BoardComment> boardCommentList = 
			selectBoardCommentList(boardItem.getId());
		
		boardItem.setBoardCommentList(boardCommentList);
		
		return boardItem;
	}
	
	public List<BoardItem> selectBoardItemList(Map<String, Object> param)
	{		
		return (List<BoardItem>) sqlMapClientTemplate.queryForList("selectBoardItemList", param);
	}

	public Integer selectBoardItemCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectBoardItemCount", param);
	}
	
	public void updateBoardItem(BoardItem boardItem)
	{
		sqlMapClientTemplate.update("updateBoardItem", boardItem);
	}
	
	/**************************************************/
	
	public void insertBoardComment(BoardComment boardComment)
	{
		sqlMapClientTemplate.insert("insertBoardComment", boardComment);
	}
	
	public void deleteBoardComment(String id)
	{
		sqlMapClientTemplate.delete("deleteBoardComment", id);
	}
	
	public void deleteBoardCommentList(String boardId)
	{
		sqlMapClientTemplate.delete("deleteBoardCommentList", boardId);
	}
	
	public BoardComment selectBoardComment(String id)
	{
		return (BoardComment) sqlMapClientTemplate.queryForObject("selectBoardComment", id);
	}
	
	public List<BoardComment> selectBoardCommentList(String boardId)
	{
		return (List<BoardComment>) sqlMapClientTemplate.queryForList("selectBoardCommentList", boardId);
	}
	
	public void plusBoardItemReadCout(String boardId)
	{
		sqlMapClientTemplate.update("plusBoardItemReadCout", boardId);
	}
	
	public Integer selectUnAnsweredQna()
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectUnAnsweredQna");
	}
}
