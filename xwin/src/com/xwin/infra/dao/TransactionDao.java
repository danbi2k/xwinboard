package com.xwin.infra.dao;

import java.util.List;
import java.util.Map;

import com.xwin.domain.admin.Transaction;

public class TransactionDao extends XwinDao
{
	private static final long serialVersionUID = 6418102061799972887L;

	public void insertTransaction(Transaction transaction) {
		sqlMapClientTemplate.insert("insertTransaction", transaction);
	}
	
	public List<Transaction> selectTransactionList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectTransactionList", param);		
	}
	
	public Integer selectTransactionCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectTransactionCount", param);		
	}
	
	public Long selectTransactionSum(Map<String, Object> param)
	{
		return (Long) sqlMapClientTemplate.queryForObject("selectTransactionSum", param);		
	}

	public void updateTransaction(Transaction transaction) {
		sqlMapClientTemplate.update("updateTransaction", transaction);
		
	}
}
