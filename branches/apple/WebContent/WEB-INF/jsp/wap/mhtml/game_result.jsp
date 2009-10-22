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
    <title>【경기결과】</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>【경기결과】</center></div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <div>----------------</div>
<%
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
%>
<%
	List<Game> gameList = (List<Game>) request.getAttribute("gameList");
%>
<%
if (gameList != null) {
	for (Game game : gameList) {
%>
        <div><%=XwinUtil.getBoardItemDate(game.getGameDate())%></div>
        <div><%=game.getLeagueName()%></div>
        <div>(승) x<%=game.getWinRateStr()%></div>
        <div><%=game.getHomeTeam()%></div>
<%
out.print(game.getType().equals("wdl")?"(무) ":"(핸디) ");
if (game.getType().equals("wdl")) {
	out.print("x" + game.getDrawRateStr());
	} else {
		out.print(game.getDrawRate()>0?"+":"");
		out.print(game.getDrawRate());
	}
%>
        <div>(패) x<%=game.getLoseRateStr()%></div>
        <div><%=game.getAwayTeam()%></div>
        <div>경기결과</div>
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
if (pIdx > 0) {
%>
        <div><a btn="확인" href="play.wap?mode=viewGameResultList&pageIndex=<%=pIdx-1%>&token=<%=token%>" accesskey="2">이전</a></div>
<%
}
%>
        <div><a btn="확인" href="play.wap?mode=viewGameResultList&pageIndex=<%=pIdx+1%>&token=<%=token%>" accesskey="3">다음</a></div>
        <btn name="상위" href="main.wap?token=<%=token%>">
    </body>
</html>

