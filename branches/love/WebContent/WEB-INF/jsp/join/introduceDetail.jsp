<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.join.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%@ page import="java.util.*" %>
<%
	List<Member> invitationList = (List<Member>) request.getAttribute("invitationList");
%>
<html>
<head>
	<link rel="stylesheet" href="style/default.css">
</head>
<body>
	<BR>
	<table width="550" style="margin-top:10">
	<tr><td><b>추천내역보기</b></td></tr>
	</table>
	<BR>
	<table width="550" bgcolor="#d9d8d6" cellspacing="1" cellpadding="5" style="border:1 solid #909090;">
		<tr bgcolor="#333333">
			<th>아이디</th>
			<th>닉네임</th>
			<th>가입일</th>
		</tr>
	<%
	if (invitationList != null) {
		for (Member member : invitationList) {
			
	%>
		<tr bgcolor='black'>
			<td><%=member.getUserId()%></td>
			<td><%=member.getNickName()%></td>
			<td><%=XwinUtil.toDateStr(member.getJoinDate(), 1)%></td>
		</tr>
	<%
		}
	}
	%>
		
	</table>
</body>
</html>