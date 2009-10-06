<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.domain.game.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%
	Member member = (Member) session.getAttribute("Member");
	List<Betting> bettingList = (List<Betting>) request.getAttribute("bettingList");
%>
<html>
<head>
<title>APPLE</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<br>
<br>
* 배팅내역<br>
* 최근 5개 만 보입니다.
<br><br>
<%
if (bettingList != null && bettingList.size() > 0) {
	for (Betting betting : bettingList) {
%>
배팅일시 : <%=betting.getDateStr()%><br>
배당율 : <%=betting.getRateStr()%><br>
배팅금액 : <%=XwinUtil.comma3(betting.getMoney())%><br>
예상적중금액 : <%=XwinUtil.comma3(betting.getExpect())%><br>
적중금액 :
<%
if (betting.getStatus().equals(Code.BET_STATUS_SUCCESS))
	out.print(XwinUtil.comma3(betting.getExpect()));
else
	out.print(0);							
%>
<br>
	<%
	List<BetGame> betGameList = betting.getBetGameList();
	if (betGameList != null && betGameList.size() > 0) {
		for (BetGame betGame : betGameList) {
	%>
		<table border=1>
			<tr>
				<td>경기일시</td>
				<td><%=betGame.getGameDateStr()%></td>
			</tr>
			<tr>
				<td>(승) 홈팀</td>
				<td><%=betGame.getHomeTeam()%>&nbsp;(<%=betGame.getWinRateStr()%>)</td>
			</tr>
			<tr>
				<td>무/핸디캡</td>
				<td>(<%=betGame.getType().equals("wdl")?"무 " + betGame.getDrawRateStr():"핸디 " + (betGame.getDrawRate()>0?"+":"") + betGame.getDrawRate()%>)</td>
			</tr>
			<tr>
				<td>(패) 원정팀</td>
				<td><%=betGame.getAwayTeam()%>&nbsp;(<%=betGame.getLoseRateStr()%>)</td>
			</tr>
			<tr>
				<td>배팅팀</td>
				<td><%=Code.getValue(betGame.getGuess())%></td>
			</tr>
			<tr>
				<td>경기결과</td>
				<td><%=Code.getValue(betGame.getResult())%> <%=XwinUtil.nvl(betGame.getHomeScore())%><%=betGame.getHomeScore()!=null?" : ":"" %><%=XwinUtil.nvl(betGame.getAwayScore())%></td>
			</tr>
			<tr>
				<td>적중유무</td>
				<td><%=Code.getValue(betGame.getResultStatus())%></td>
			</tr>
		</table>
	<%
		}
	}
	%>
	<br><br>
<%
	}
} else {
	out.println("배팅 내역이 없습니다");
}
%>
<br>
<br>
<a href="main.wap">돌아가기</a>
</body>
</html>