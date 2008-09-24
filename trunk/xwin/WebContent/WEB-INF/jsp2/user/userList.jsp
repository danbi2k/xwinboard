<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<table>
	<%
		List<Member> userList = (List<Member>) request.getAttribute("userList");
			Iterator<Member> userIter = userList.iterator();
			
			while (userIter.hasNext()) {
		Member user = userIter.next();
	%>
	<tr>
		<td><%=user.getId()%></td>
		<td><%=user.getUserId()%></td>
		<td><%=user.getNickName()%></td>
		<td><%=user.getEmail()%></td>
	</tr>
	<%
		}
	%>
</table>
</body>
</html>