package com.xwin.infra.dao;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

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
	
	public Member selectMember(String userId)
	{
		return (Member) sqlMapClientTemplate.queryForObject("selectMember", userId);
	}
	
	public List<Member> selectMemberList()
	{
		return (List<Member>) sqlMapClientTemplate.queryForList("selectMemberList");
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
}
