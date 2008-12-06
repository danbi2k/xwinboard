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
	
	public Invitation selectInvitation(String userId, String inviteKey)
	{
		Map<String, String> param = new HashMap<String, String>(2);
		param.put("userId", userId);
		param.put("inviteKey", inviteKey);
		
		return( Invitation) sqlMapClientTemplate.queryForObject("selectInvitation", param);
	}
	
	public List<Invitation> selectInvitationList(String userId)
	{
		return sqlMapClientTemplate.queryForList("selectInvitation", userId);
	}
}
