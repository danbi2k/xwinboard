<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.domain.game.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%
	Member member = (Member) session.getAttribute("Member");
	List<Game> gameList = (List<Game>) request.getAttribute("gameList");
	String type = request.getParameter("type");
%>
<html>
<head>
<title>APPLE</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<br>
<br>
* <%=type.equals("wdl")?"승무패":"핸디캡"%><br>
<br><br>
<%
if (gameList != null && gameList.size() > 0) {
	for (Game game : gameList) {
%>
<table>
	<tr><td><%=game.getLeagueName()%></td></tr>
	<tr><td><%=game.getGameDateStr()%></td></tr>
	<tr><td><%=game.getHomeTeam()%> <%=game.getWinRateStr() %></td></tr>
	<tr><td><%=game.getDrawRateStr()%></td></tr>
	<tr><td><%=game.getAwayTeam()%> <%=game.getLoseRateStr() %></td></tr>	
</table>
<br>
<%
	}
} else {
	out.println("진행중인 경기가 없습니다");
}
%>
<br>
<br>
<a href="main.wap">돌아가기</a>
</body>
</html>