<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/vnd.wap.wml;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");
%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
    <head>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <card id ="card1" title="경기결과">
        <p mode="wrap">닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</p>
        <p>----------------</p>
<%
	List<Game> gameList = (List<Game>) request.getAttribute("gameList");
%>
<%
if (gameList != null) {
	for (Game game : gameList) {
%>
        <p mode="wrap">경기일시</p>
        <p mode="wrap"><%=XwinUtil.getBoardItemDate(game.getGameDate())%></p>
        <p mode="wrap">리그</p>
        <p mode="wrap"><%=game.getLeagueName()%></p>
        <p mode="wrap">(승) 홈팀</p>
        <p mode="wrap"><%=game.getHomeTeam()%>&nbsp;x<%=game.getWinRateStr()%></p>
        <p mode="wrap">무/핸디캡</p>
<%if (game.getType().equals("wdl")) {
	out.print("x" + game.getDrawRateStr());
	} else {
		out.print(game.getDrawRate()>0?"+":"");
		out.print(game.getDrawRate());
	}
%>
        <p mode="wrap">(패) 원정팀</p>
        <p mode="wrap"><%=game.getAwayTeam()%>&nbsp;x<%=game.getLoseRateStr()%></p>
        <p mode="wrap">경기결과</p>
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
        <p mode="wrap"><a title="확인" href="play.wap?mode=viewGameResultList&pageIndex=<%=pIdx-1%>&amp;token=<%=token%>">이전</a></p>
<%
}
%>
        <p mode="wrap"><a title="확인" href="play.wap?mode=viewGameResultList&pageIndex=<%=pIdx+1%>&amp;token=<%=token%>">다음</a></p>
        <do type="vnd.up" label="상위"><go href="main.wap?token=<%=token%>"/></do>
    </card>
</wml>

