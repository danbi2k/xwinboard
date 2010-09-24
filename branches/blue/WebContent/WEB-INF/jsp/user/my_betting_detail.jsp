<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="com.xwin.domain.*" %>

<%
	Betting betting = (Betting) request.getAttribute("betting");
	List<BetGame> betGameList = betting.getBetGameList();
%>
<html>

<head>
<title><%=SiteConfig.SITE_NAME%></title>
    <Meta Http-Equiv="Content-Type" Content="Text/Html; Charset=UTF-8">
    <Meta Http-Equiv="Imagetoolbar" Content="No">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" content="-1">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
	<META HTTP-EQUIV="Refresh" Content="1800; URL=/member/logout.asp?auto=1">

    <link rel="stylesheet" href="style/default.css">
    <script language="JavaScript" src="script/default.js"></script>
</head>
<script src="game.js"></script>
<body style="margin:0" oncontextmenu="return false">



<table width="800" bgcolor="#d9d8d6" cellspacing="1" cellpadding="3">
		<colgroup>
			<col align="center" width="100">

			<col align="center" width="*">
			<col align="center" width="70">
			<col align="center" width="70">
			<col align="center" width="90">
			<col align="center" width="80">
			<col align="center" width="80">
		</colgroup>

		<tr bgcolor="#ce892c">

			<th style="color:white;">경기일시</th>
			<th style="color:white;">리그</th>
			<th style="color:white;">배당율</th>
			<th style="color:white;">선택</th>
			<th style="color:white;">Score</th>
			<th style="color:white;">결과</th>
			<th style="color:white;">상태</th>
		</tr>
		
		<%
		if (betGameList != null && betGameList.size() > 0) {
			for (BetGame betGame : betGameList) {
		%>
		<tr height="26" bgcolor="#0a0a0a">
			<td><%=betGame.getGameDateStr()%></td>
			<td align="left">
				<table cellpadding="0" cellspacing="2"><tr><td><img src="symbol/6.gif" style="display:none" onload="this.style.display='';"></td>
				<td><%=betGame.getLeagueName()%></td>

				<td style="color:#4f4f4f;">- <%=betGame.getHomeTeam()%> vs <%=betGame.getAwayTeam()%></td>
				<td style="color:darkorange"></td></tr>
				</table>
			</td>
			<td><%=betGame.getWinRateStr()%></td>
			<td>
				<%=Code.getValue(betGame.getGuess())%>
			</td>
			<%if (betting.getGameType().equals("wdl")) { %>
			<td><%=betGame.getHomeScore()==null ? "-":betGame.getHomeScore()%> : <%=betGame.getAwayScore()==null ? "-":betGame.getAwayScore()%></td>
			<%
			} else if (betting.getGameType().equals("handy")) {
				String oper = betGame.getDrawRate() >= 0 ? "+":"-";
				double abs = Math.abs(betGame.getDrawRate());
			%>
			<td><%=betGame.getHomeScore()==null ? "-":betGame.getHomeScore() + " " + oper + " (" + abs + ") "%> : <%=betGame.getAwayScore()==null ? "-":betGame.getAwayScore()%></td>
			<%} %>
			<td>
				<%=Code.getValue(betGame.getResult())==null?"-":Code.getValue(betGame.getResult())%>
			</td>
			<td><%=Code.getValue(betGame.getStatus())%></td>
		</tr>
		<%
			}
		}
		%>
		</table>

<br><br>
<!------------------------------------------------------------------------------//-->


	<table width="100%" bgcolor="#d9d8d6" cellspacing="1" cellpadding="3">
	<colgroup>

		<col align="center" width="100">
		<col align="right"  width="80">
		<col align="center" width="70">
		<col align="right"  width="80">
		<col align="center" width="70">
	</colgroup>

	<tr bgcolor="#ce892c">
		<th style="color:white;">배팅일시</th>
		<th style="color:white;" align="center" >배팅금액</th>
		<th style="color:white;">배당율</th>
		<th style="color:white;" align="center" >배당금</th>
		<th style="color:white;">상태</th>
	</tr>
	<tr height="26" bgcolor="#0a0a0a">		
		<td><%=betting.getDateStr()%></td>
		<td><%=XwinUtil.comma3(betting.getMoney())%> 원</td>
		<td><%=betting.getRateStr()%></td>
		<td>
		<font color="pink"><%=XwinUtil.comma3(betting.getExpect())%>원</font>
		</td>
		<td><font color="pink"><%=Code.getValue(betting.getStatus())%></font></td>
	</tr>	
	</table>

</body>

</html>