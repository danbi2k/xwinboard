package com.xwin.infra.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.game.BetToto;


public class BetTotoDao extends XwinDao
{
	private static final long serialVersionUID = -8623753959083074509L;
	
	public String insertBetToto(BetToto betToto)
	{
		String betTotoId = (String) sqlMapClientTemplate.insert("insertBetToto", betToto);

		return betTotoId;
	}
	
	public void deleteBetToto(String id)
	{
		sqlMapClientTemplate.delete("deleteBetToto", id);
	}
	
	public void deleteBetTotoByDate(Date date)
	{
		sqlMapClientTemplate.delete("deleteBetTotoByDate", date);
	}
	
	public BetToto selectBetToto(Map<String, Object> param)
	{
		return (BetToto) sqlMapClientTemplate.queryForObject("selectBetToto", param);
	}
	
	public BetToto selectBetTotoById(String id)
	{
		Map<String, Object> param = new HashMap<String, Object>(1);
		param.put("id", id);
		return (BetToto) sqlMapClientTemplate.queryForObject("selectBetToto", param);
	}
	
	public List<BetToto> selectBetTotoList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectBetTotoList", param);
	}
	
	public Integer selectBetTotoCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectBetTotoCount", param);
	}
	
	public Long selectBetTotoMoneySum(Map<String, Object> param)
	{
		return (Long) sqlMapClientTemplate.queryForObject("selectBetTotoMoneySum", param);
	}
	
	public void updateBetToto(BetToto betToto)
	{
		sqlMapClientTemplate.update("updateBetToto", betToto);
	}
}
