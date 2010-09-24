package com.xwin.infra.dao;

public class MaintananceDao extends XwinDao
{
	public void deleteMoneyInData(String date)
	{
		sqlMapClientTemplate.delete("deleteMoneyInData", date);
	}
	
	public void deleteMoneyOutData(String date)
	{
		sqlMapClientTemplate.delete("deleteMoneyOutData", date);
	}
	
	public void deleteTransactionData(String date)
	{
		sqlMapClientTemplate.delete("deleteTransactionData", date);
	}

	public void deleteAccountData(String date)
	{
		sqlMapClientTemplate.delete("deleteAccountData", date);		
	}

	public void deletePointData(String date)
	{
		sqlMapClientTemplate.delete("deletePointData", date);		
	}

	public void deleteBetGameData(String date)
	{
		sqlMapClientTemplate.delete("deleteBetGameData", date);		
	}
	
	public void updateBoardWithBetting(String date)
	{
		sqlMapClientTemplate.update("updateBoardWithBetting", date);
	}

	public void deleteBettingData(String date)
	{
		sqlMapClientTemplate.delete("deleteBettingData", date);		
	}
}
