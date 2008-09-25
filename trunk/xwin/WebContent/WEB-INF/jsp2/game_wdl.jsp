<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.xwin.infra.util.*" %>
<%@ page import="com.xwin.domain.game.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<select id="eventSelect">
	<option value="">전체</option>
	<option value="<%=CodeTable.EVENT_SOCCER%>">축구</option>
	<option value="<%=CodeTable.EVENT_BASEBALL%>">야구</option>
	<option value="<%=CodeTable.EVENT_BASKETBALL%>">농구</option>
	<option value="<%=CodeTable.EVENT_ETC%>">기타</option>
</Select>

<%
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	Iterator<League> leagueIter = leagueList.iterator();
%>
<select id="leagueSelect">
<%
	while (leagueIter.hasNext()) {
		League league = leagueIter.next();
%>
	<option value="<%=league.getId()%>"><%=league.getName()%></option>
<%
	}
%>
</select>
</body>
</html>