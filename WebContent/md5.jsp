<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.xwin.domain.user.*"%>    
<%@ page import="com.xwin.infra.dao.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%
	MemberDao memberDao = Admin.memberDao;
	Map<String, Object> param = new HashMap<String, Object>();
	List<Member> memberList = memberDao.selectMemberList(param);
	if (memberList != null) {
		for (Member member : memberList) {
			member.setPassword(XwinUtil.getEncoded(member.getPassword()));
			member.setPin(XwinUtil.getEncoded(member.getPin()));
			memberDao.updateMember(member);
		}
	}
%>