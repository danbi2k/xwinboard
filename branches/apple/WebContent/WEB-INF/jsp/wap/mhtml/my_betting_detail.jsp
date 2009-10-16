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
        <div>����Ͻ�</div>
        <div><%=betGame.getGameDateStr()%></div>
        <div>(��) Ȩ��</div>
        <div><%=betGame.getHomeTeam()%>&nbsp;(<%=betGame.getWinRateStr()%>)</div>
        <div>��/�ڵ�ĸ</div>
        <div>(<%=betGame.getType().equals("wdl")?"�� " + betGame.getDrawRateStr():"�ڵ� " + (betGame.getDrawRate()>0?"+":"") + betGame.getDrawRate()%>)</div>
        <div>(��) ������</div>
        <div><%=betGame.getAwayTeam()%>&nbsp;(<%=betGame.getLoseRateStr()%>)</div>
        <div>������</div>
        <div><%=Code.getValue(betGame.getGuess())%></div>
        <div>�����</div>
        <div><%=Code.getValue(betGame.getResult())%>&nbsp;<%=XwinUtil.nvl(betGame.getHomeScore())%><%=betGame.getHomeScore()!=null?" : ":"" %><%=XwinUtil.nvl(betGame.getAwayScore())%></div>
        <div>��������</div>
        <div><%=Code.getValue(betGame.getResultStatus())%></div>
<%
	}
}
%>
        <btn name="����" href="betlog.wap?mode=viewMyBettingList&token=<%=token%>">
    </body>
</html>

