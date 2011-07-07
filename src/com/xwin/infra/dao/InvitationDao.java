package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.join.Invitation;

public class InvitationDao extends XwinDao
{
	private static final long serialVersionUID = -204076982558600004L;

	public void insertInvitation(Invitation invitation)
	{
		sqlMapClientTemplate.insert("insertInvitation", invitation);
	}
	
	public void updateInvitation(Invitation invitation)
	{
		sqlMapClientTemplate.update("updateInvitation", invitation);
	}
	
	public Invitation selectUserInvitation(String userId, String inviteKey)
	{
		Map<String, String> param = new HashMap<String, String>(2);
		param.put("userId", userId);
		param.put("inviteKey", inviteKey);
		
		return( Invitation) sqlMapClientTemplate.queryForObject("selectUserInvitation", param);
	}
	
	public Invitation selectDealerInvitation(String dealerId, String inviteKey)
	{
		Map<String, String> param = new HashMap<String, String>(2);
		param.put("dealerId", dealerId);
		param.put("inviteKey", inviteKey);
		
		return( Invitation) sqlMapClientTemplate.queryForObject("selectDealerInvitation", param);
	}
	
	public List<Invitation> selectInvitationList(Map<String, Object> param)
	{
		return sqlMapClientTemplate.queryForList("selectInvitationList", param);
	}
	
	public Integer selectInvitationCount(Map<String, Object> param)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("selectInvitationCount", param);
	}
}
