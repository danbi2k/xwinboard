<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	Iterator<League> leagueIter = leagueList.iterator();
	
	while (leagueIter.hasNext()) {
		League league = leagueIter.next();
		out.println(league.getName());
	}
%>

</body>
</html>