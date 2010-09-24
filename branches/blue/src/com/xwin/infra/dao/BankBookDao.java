package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.admin.BankBook;

public class BankBookDao extends XwinDao
{
	private static final long serialVersionUID = 6698304840950398336L;


	public void insertBankBook(BankBook bankBook)
	{
		sqlMapClientTemplate.insert("insertBankBook", bankBook);
	}
	

	public List<BankBook> selectBankBookList(String status)
	{
		Map<String, Object> param = new HashMap<String, Object>(1);
		param.put("status", status);
		
		return sqlMapClientTemplate.queryForList("selectBankBookList", param);		
	}
	

	public List<BankBook> selectBankBookList(String status, String grade)
	{
		Map<String, Object> param = new HashMap<String, Object>(2);
		param.put("status", status);
		param.put("grade", grade);
		
		return sqlMapClientTemplate.queryForList("selectBankBookList", param);		
	}
	
	public BankBook selectBankBook(String id)
	{
		return (BankBook) sqlMapClientTemplate.queryForObject("selectBankBook", id);		
	}
	
	public void updateBankBook(BankBook bankBook)
	{
		sqlMapClientTemplate.update("updateBankBook", bankBook);
	}
	
	// MEMBER BANK BOOK //
	
	public void insertMemberBankBook(BankBook bankBook)
	{
		sqlMapClientTemplate.insert("insertMemberBankBook", bankBook);
	}
	

	public List<BankBook> selectMemberBankBookList(String userId)
	{
		Map<String, Object> param = new HashMap<String, Object>(1);
		param.put("status", userId);
		
		return sqlMapClientTemplate.queryForList("selectMemberBankBookList", param);		
	}
}
