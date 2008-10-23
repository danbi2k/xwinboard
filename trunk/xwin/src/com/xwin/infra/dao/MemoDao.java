package com.xwin.infra.dao;

import java.util.List;
import java.util.Map;

import com.xwin.domain.user.Memo;

public class MemoDao extends XwinDao
{
	public void insertMemo(Memo memo)
	{
		sqlMapClientTemplate.insert("insertMemo", memo);
	}
	
	public void deleteMemo(String id)
	{
		sqlMapClientTemplate.delete("deleteMemo", id);
	}
	
	public List<Memo> selectMemoList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectMemoList", param);
	}

	public void updateMemo(Map<String, Object> param) {
		sqlMapClientTemplate.update("updateMemo", param);
	}
}
