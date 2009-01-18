<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.join.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%@ page import="java.util.*" %>
<%
	List<Invitation> noJoinList = (List<Invitation>) request.getAttribute("noJoinList");
%>
<html>
<head>
	<link rel="stylesheet" href="style/default.css">
</head>
<body>
	<BR>
	<table width="550" style="margin-top:10">
	<tr><td><b>미가입추천장보기</b></td></tr>
	</table>
	<BR>
	<table width="550" bgcolor="#d9d8d6" cellspacing="1" cellpadding="5" style="border:1 solid #909090;">
		<tr bgcolor="#333333">
			<th>추천장</th>
			<th>휴대폰</th>
			<th>발송일</th>
		</tr>
	<%
	if (noJoinList != null) {
		for (Invitation invitation : noJoinList) {
			
	%>
		<tr bgcolor='black'>
			<td><%=invitation.getInviteKey()%></td>
			<td><%=invitation.getMobile()%></td>
			<td><%=XwinUtil.toDateStr(invitation.getSendDate(), 1)%></td>
		</tr>
	<%
		}
	}
	%>
		
	</table>
</body>
</html>