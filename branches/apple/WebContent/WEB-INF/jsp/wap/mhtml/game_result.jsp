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
    <title>���������</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>���������</center></div>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
        <div>----------------</div>
<%
	List<Game> gameList = (List<Game>) request.getAttribute("gameList");
%>
<%
if (gameList != null) {
	for (Game game : gameList) {
%>
        <div>����Ͻ�</div>
        <div><%=XwinUtil.getBoardItemDate(game.getGameDate())%></div>
        <div>����</div>
        <div><%=game.getLeagueName()%></div>
        <div>(��) Ȩ��</div>
        <div><%=game.getHomeTeam()%>&nbsp;x<%=game.getWinRateStr()%></div>
        <div>��/�ڵ�ĸ</div>
<%if (game.getType().equals("wdl")) {
	out.print("x" + game.getDrawRateStr());
	} else {
		out.print(game.getDrawRate()>0?"+":"");
		out.print(game.getDrawRate());
	}
%>
        <div>(��) ������</div>
        <div><%=game.getAwayTeam()%>&nbsp;x<%=game.getLoseRateStr()%></div>
        <div>�����</div>
<%
if (game.getStatus().equals(Code.GAME_STATUS_END)) {
	out.print(game.getHomeScore() + " : " + game.getAwayScore() + " " + Code.getValue(game.getResult()));
} else {
	out.print(Code.getValue(game.getStatus()));
}%>	
<%
	}
}
%>
<%
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
%>
<%
if (pIdx > 0) {
%>
        <div><a btn="Ȯ��" href="play.wap?mode=viewGameResultList&pageIndex=<%=pIdx-1%>&token=<%=token%>" accesskey="2">����</a></div>
<%
}
%>
        <div><a btn="Ȯ��" href="play.wap?mode=viewGameResultList&pageIndex=<%=pIdx+1%>&token=<%=token%>" accesskey="3">����</a></div>
        <btn name="����" href="main.wap?token=<%=token%>">
    </body>
</html>

