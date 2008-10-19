package com.xwin.infra.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.admin.Point;

public class PointDao extends XwinDao
{

	public void insertPoint(Point point) {
		sqlMapClientTemplate.insert("insertPoint", point);
	}
	
	public List<Point> selectPointList(String search, String keyword, Date fromReqDate, Date toReqDate, Date fromProcDate, Date toProcDate)
	{
		Map<String, Object> param = new HashMap<String, Object>(6);
		param.put(search, keyword);
		param.put("fromReqDate", fromReqDate);
		param.put("toReqDate", toReqDate);
		param.put("fromProcDate", fromProcDate);
		param.put("toProcDate", toProcDate);
		
		return sqlMapClientTemplate.queryForList("selectPointList", param);		
	}
	
	public List<Point> selectPointList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectPointList", param);		
	}
	
	public Integer selectPointCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectPointCount", param);		
	}

	public void updatePoint(Point point) {
		sqlMapClientTemplate.update("updatePoint", point);
		
	}
}
