package com.xwin.infra.dao;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.statistics.FriendBetMoneyStat;
import com.xwin.domain.user.Dealer;

public class DealerDao extends XwinDao implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5414544336253610267L;

	public void insertDealer(Dealer dealer)
	{
		sqlMapClientTemplate.insert("insertDealer", dealer);
	}
	
	public void deleteDealer(String userId)
	{
		sqlMapClientTemplate.delete("deleteDealer", userId);
	}
	
	public void updateDealer(Dealer dealer)
	{
		sqlMapClientTemplate.update("updateDealer", dealer);
	}
	
	public Dealer selectDealer(String dealerId)
	{
		Map<String, String> param = new HashMap<String, String>(1);
		param.put("dealerId", dealerId);
		
		return (Dealer) sqlMapClientTemplate.queryForObject("selectDealer", param);
	}
	
	public Dealer selectDealer(Map<String, Object> param)
	{
		return (Dealer) sqlMapClientTemplate.queryForObject("selectDealer", param);
	}
	
	public List<Dealer> selectDealerList(Map<String, Object> param)
	{
		return (List<Dealer>) sqlMapClientTemplate.queryForList("selectDealerList", param);
	}

	public Integer selectDealerCount(Map<String, Object> param) {
		
		return (Integer) sqlMapClientTemplate.queryForObject("selectDealerCount", param);
	}
}
