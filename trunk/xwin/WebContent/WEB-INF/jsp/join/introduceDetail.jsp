<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.join.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="java.util.*" %>
<%
	List<Invitation> invitationList = (List<Invitation>) request.getAttribute("invitationList");
%>
<html>
<head>
	<link rel="stylesheet" href="style/default.css">
</head>
<body>
	<table width="600" bgcolor="#333333" cellpadding="5" style="border:1 solid #909090;">
	<%
	if (invitationList != null) {
		for (Invitation invitation : invitationList) {
			
	%>
		<tr>
			<td><%=invitation.getUserId()%></td>
			<td><%=invitation.getJoinId()%></td>
		</tr>
	<%
		}
	}
	%>
		
	</table>
</body>
</html>