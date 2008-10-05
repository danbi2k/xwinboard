package com.xwin.infra.dao;

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
	
	public BoardItem selectBoardItem(String id)
	{
		BoardItem boardItem = 
			(BoardItem) sqlMapClientTemplate.queryForObject("selectBoardItem", id);
		
		List<BoardComment> boardCommentList = 
			selectBoardCommentList(boardItem.getId());
		
		boardItem.setBoardCommentList(boardCommentList);
		
		return boardItem;
	}
	
	public List<BoardItem> selectBoardItemList(Map<String, Object> param)
	{		
		return (List<BoardItem>) sqlMapClientTemplate.queryForList("selectBoardItemList", param);
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
	
	public List<BoardComment> selectBoardCommentList(String boardId)
	{
		return (List<BoardComment>) sqlMapClientTemplate.queryForList("selectBoardCommentList", boardId);
	}
}
