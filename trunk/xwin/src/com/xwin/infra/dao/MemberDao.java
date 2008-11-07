package com.xwin.infra.dao;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.user.Member;

public class MemberDao extends XwinDao implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1108876346856028351L;

	public void insertMember(Member member)
	{
		sqlMapClientTemplate.insert("insertMember", member);
	}
	
	public void deleteMember(String userId)
	{
		sqlMapClientTemplate.delete("deleteMember", userId);
	}
	
	public void updateMember(Member member)
	{
		sqlMapClientTemplate.insert("updateMember", member);
	}
	
	public Member selectMember(String userId, String grade)
	{
		Map<String, String> param = new HashMap<String, String>(2);
		param.put("userId", userId);
		param.put("grade", grade);
		
		return (Member) sqlMapClientTemplate.queryForObject("selectMember", param);
	}
	
	public Member selectMember(Map<String, Object> param)
	{
		return (Member) sqlMapClientTemplate.queryForObject("selectMember", param);
	}
	
	public List<Member> selectMemberList(Map<String, Object> param)
	{
		return (List<Member>) sqlMapClientTemplate.queryForList("selectMemberList", param);
	}

	public Integer selectMemberCount(Map<String, Object> param) {
		
		return (Integer) sqlMapClientTemplate.queryForObject("selectMemberCount", param);
	}
	
	public Integer countMemberByUserId(String id)
	{
		Object value = sqlMapClientTemplate.queryForObject("countMemberByUserId", id);
		return (Integer) value;
	}
	
	public Integer countMemberByNickName(String nickName)
	{
		Object value = sqlMapClientTemplate.queryForObject("countMemberByNickName", nickName);
		return (Integer) value;
	}
	
	public void plusMinusBalance(String userId, Long money)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", userId);
		param.put("money", money);
		
		sqlMapClientTemplate.update("plusMinusBalance", param);
	}
	
	public void plusMinusPoint(String userId, Long point)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", userId);
		param.put("point", point);
		
		sqlMapClientTemplate.update("plusMinusPoint", param);
	}
	
	public Integer confirmGetJoinEvent(String mobile)
	{
		return (Integer) sqlMapClientTemplate.queryForObject("confirmGetJoinEvent", mobile);
	}
	
	public void loggingGetEvent(String mobile)
	{
		sqlMapClientTemplate.insert("loggingGetEvent", mobile);
	}

	public void updateMemberStatus(String userId, String status)
	{
		Map<String, String> param = new HashMap<String, String>(2);
		param.put("userId", userId);
		param.put("status", status);
		
		sqlMapClientTemplate.update("updateMemberStatus", param);		
	}

	public List<Member> selectRecentlyJoinMemberList()
	{
		Map<String, Object> param = new HashMap<String, Object>(2);
		param.put("fromRow", 0);
		param.put("rowSize", 5);
		
		return sqlMapClientTemplate.queryForList("selectMemberList", param);
	}
	
	public Long selectTotalBalance()
	{
		return (Long) sqlMapClientTemplate.queryForObject("selectTotalBalance");
	}
}
