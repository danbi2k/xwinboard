package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.game.Toto;

public class TotoDao extends XwinDao
{
	private static final long serialVersionUID = 658511875748204702L;

	public void insertToto(Toto toto)
	{
		sqlMapClientTemplate.insert("insertToto", toto);
	}
	
	public void updateToto(Toto toto)
	{
		sqlMapClientTemplate.update("updateToto", toto);
	}

	public Toto selectTotoById(String id) {
		Map<String, Object> param = new HashMap<String, Object>(1);
		param.put("id", id);
		return (Toto) sqlMapClientTemplate.queryForObject("selectToto", param);
	}
	
	public Toto selectToto(Map<String, Object> param)
	{
		return (Toto) sqlMapClientTemplate.queryForObject("selectToto", param);
	}
	
	
	public List<Toto> selectTotoList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectTotoList", param);
	}
	
	public Integer selectTotoCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectTotoCount", param);
	}
}
