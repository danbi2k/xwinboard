package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.admin.BankBook;

public class BankBookDao extends XwinDao
{

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
	
	public BankBook selectBankBook(String id)
	{
		return (BankBook) sqlMapClientTemplate.queryForObject("selectBankBook", id);		
	}
}