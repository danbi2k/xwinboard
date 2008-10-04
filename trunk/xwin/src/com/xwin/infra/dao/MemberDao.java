package com.xwin.infra.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.xwin.domain.user.Member;

public class MemberDao extends XwinDao
{
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
	
	public List<Member> selectMemberList(String grade, String search, String keyword)
	{
		Map<String, String> param = new HashMap<String, String>(3);
		param.put("grade", grade);
		param.put(search, "%" + keyword + "%");
		return (List<Member>) sqlMapClientTemplate.queryForList("selectMemberList", param);
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
	
	public void updateBalance(String userId, Long balance)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", userId);
		param.put("balance", balance);
		
		sqlMapClientTemplate.update("updateBalance", param);
	}
	
	public void plusMinusBalance(String userId, Long money)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", userId);
		param.put("money", money);
		
		sqlMapClientTemplate.update("plusMinusBalance", param);
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
		param.put("pageIndex", 0);
		param.put("pageSize", 5);
		
		return sqlMapClientTemplate.queryForList("selectMemberList", param);
	}
}
