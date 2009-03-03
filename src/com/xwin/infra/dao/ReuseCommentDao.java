package com.xwin.infra.dao;

import java.util.List;

import com.xwin.domain.common.ReuseComment;

public class ReuseCommentDao extends XwinDao
{
	private static final long serialVersionUID = -2554939225951888802L;

	public void insertReuseComment(ReuseComment reuseComment)
	{
		sqlMapClientTemplate.insert("insertReuseComment", reuseComment);
	}
	
	public void deleteReuseComment(String id)
	{
		sqlMapClientTemplate.delete("deleteReuseComment", id);
	}

	public ReuseComment selectReuseComment(String id)
	{		
		return (ReuseComment) sqlMapClientTemplate.queryForObject("selectReuseComment", id);
	}
	
	public List<ReuseComment> selectReuseCommentList(String type)
	{		
		return (List<ReuseComment>) sqlMapClientTemplate.queryForList("selectReuseCommentList", type);
	}
}
