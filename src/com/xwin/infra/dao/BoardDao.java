package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.board.BoardComment;
import com.xwin.domain.board.BoardItem;

public class BoardDao extends XwinDao
{
	private static final long serialVersionUID = -2410471303804000934L;

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
	
	public BoardItem selectBoardItem(String id, String boardName, String grade)
	{
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		param.put("boardName", boardName);
		param.put("grade", grade);
		
		BoardItem boardItem = 
			(BoardItem) sqlMapClientTemplate.queryForObject("selectBoardItem", param);
		
		if (boardItem != null) {
		List<BoardComment> boardCommentList = 
			selectBoardCommentList(boardItem.getId());				
			boardItem.setBoardCommentList(boardCommentList);
		}
		
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
	
	public Integer selectUnAnsweredQna(String grade)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectUnAnsweredQna", grade);
	}
	
	public List<BoardItem> selectRecentlyQna()
	{
		Map<String, Object> param = new HashMap<String, Object>(2);
		param.put("fromRow", 0);
		param.put("rowSize", 5);
		param.put("boardName", "qna");
		
		return sqlMapClientTemplate.queryForList("selectBoardList");
	}
}
