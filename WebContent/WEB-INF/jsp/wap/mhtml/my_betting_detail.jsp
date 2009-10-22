<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<html>
    <head>
    <title>�����ó����󼼡�</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>�����ó����󼼡�</center></div>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
        <div>----------------</div>
<%
	Betting betting = (Betting) request.getAttribute("betting");
%>
        <div>�����Ͻ� :&nbsp;<%=betting.getDateStr()%><br/>
        ����� :&nbsp;<%=betting.getRateStr()%><br/>
        ���ñݾ� :&nbsp;<%=XwinUtil.comma3(betting.getMoney())%><br/>
        �������߱ݾ� :&nbsp;<%=XwinUtil.comma3(betting.getExpect())%><br/>
        ���߱ݾ� :&nbsp;<%=betting.getStatus().equals(Code.BET_STATUS_SUCCESS)?XwinUtil.comma3(betting.getExpect()):"0"%></div>
<%
List<BetGame> betGameList = betting.getBetGameList();
if (betGameList != null && betGameList.size() > 0) {
	for (BetGame betGame : betGameList) {
%>
        <div><%=XwinUtil.getBoardItemDate(betGame.getGameDate())%></div>
        <div><%=betGame.getLeagueName()%></div>
        <div>(��) x<%=betGame.getWinRateStr()%></div>
        <div><%=betGame.getHomeTeam()%></div>
<%
out.print(betGame.getType().equals("wdl")?"(��) ":"(�ڵ�) ");
if (betGame.getType().equals("wdl")) {
	out.print("x" + betGame.getDrawRateStr());
	} else {
		out.print(betGame.getDrawRate()>0?"+":"");
		out.print(betGame.getDrawRate());
	}
%>
        <div>(��) x<%=betGame.getLoseRateStr()%></div>
        <div><%=betGame.getAwayTeam()%></div>
        <div>������</div>
        <div><%=Code.getValue(betGame.getGuess())%></div>
        <div>�����</div>
<%
if (betGame.getStatus().equals(Code.GAME_STATUS_END)) {
	out.print(betGame.getHomeScore() + " : " + betGame.getAwayScore() + " " + Code.getValue(betGame.getResult()));
} else {
	out.print(Code.getValue(betGame.getStatus()));
}%>	
        <div>��������</div>
        <div><%=Code.getValue(betGame.getResultStatus())%></div>
<%
	}
}
%>
        <btn name="����" href="betlog.wap?mode=viewMyBettingList&token=<%=token%>">
    </body>
</html>

