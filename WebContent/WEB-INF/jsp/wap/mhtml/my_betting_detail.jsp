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
    <title>【배팅내역상세】</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>【배팅내역상세】</center></div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <div>----------------</div>
<%
	Betting betting = (Betting) request.getAttribute("betting");
%>
        <div>배팅일시 :&nbsp;<%=betting.getDateStr()%><br/>
        배당율 :&nbsp;<%=betting.getRateStr()%><br/>
        배팅금액 :&nbsp;<%=XwinUtil.comma3(betting.getMoney())%><br/>
        예상적중금액 :&nbsp;<%=XwinUtil.comma3(betting.getExpect())%><br/>
        적중금액 :&nbsp;<%=betting.getStatus().equals(Code.BET_STATUS_SUCCESS)?XwinUtil.comma3(betting.getExpect()):"0"%></div>
<%
List<BetGame> betGameList = betting.getBetGameList();
if (betGameList != null && betGameList.size() > 0) {
	for (BetGame betGame : betGameList) {
%>
        <div><%=XwinUtil.getBoardItemDate(betGame.getGameDate())%></div>
        <div><%=betGame.getLeagueName()%></div>
        <div>(승) x<%=betGame.getWinRateStr()%></div>
        <div><%=betGame.getHomeTeam()%></div>
<%
out.print(betGame.getType().equals("wdl")?"(무) ":"(핸디) ");
if (betGame.getType().equals("wdl")) {
	out.print("x" + betGame.getDrawRateStr());
	} else {
		out.print(betGame.getDrawRate()>0?"+":"");
		out.print(betGame.getDrawRate());
	}
%>
        <div>(패) x<%=betGame.getLoseRateStr()%></div>
        <div><%=betGame.getAwayTeam()%></div>
        <div>배팅팀</div>
        <div><%=Code.getValue(betGame.getGuess())%></div>
        <div>경기결과</div>
<%
if (betGame.getStatus().equals(Code.GAME_STATUS_END)) {
	out.print(betGame.getHomeScore() + " : " + betGame.getAwayScore() + " " + Code.getValue(betGame.getResult()));
} else {
	out.print(Code.getValue(betGame.getStatus()));
}%>	
        <div>적중유무</div>
        <div><%=Code.getValue(betGame.getResultStatus())%></div>
<%
	}
}
%>
        <btn name="상위" href="betlog.wap?mode=viewMyBettingList&token=<%=token%>">
    </body>
</html>

