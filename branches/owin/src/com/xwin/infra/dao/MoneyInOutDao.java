package com.xwin.infra.dao;

import java.util.List;
import java.util.Map;

import com.xwin.domain.user.MoneyInOut;

public class MoneyInOutDao extends XwinDao
{
	private static final long serialVersionUID = -5745196251550891927L;

	public List<MoneyInOut> selectMoneyInOutList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectMoneyInOutList", param);
	}
	
	public Integer selectMoneyInOutCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectMoneyInOutCount", param);
	}
	
	public Integer selectMoneyInOutSum(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectMoneyInOutSum", param);
	}
}
