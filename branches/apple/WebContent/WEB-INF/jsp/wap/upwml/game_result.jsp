<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/vnd.wap.wml;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");
%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE wml PUBLIC "-//PHONE.COM//DTD WML 1.1//EN" "http://www.phone.com/dtd/wml11.dtd">
<!--Web Logic 웹서버에서 한글이 깨진다면 DOCTYPE 라인을 삭제해 보세요.-->
<wml>
    <head>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <card id ="card1">
        <p align="center" mode="wrap">&lt;경기결과&gt;</p>
        <p mode="wrap">닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</p>
        <p>----------------</p>
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
        <p mode="wrap"><%=XwinUtil.getBoardItemDate(game.getGameDate())%></p>
        <p mode="wrap"><%=game.getLeagueName()%></p>
        <p mode="wrap">(승) x<%=game.getWinRateStr()%></p>
        <p mode="wrap"><%=game.getHomeTeam()%></p>
<%
out.print(game.getType().equals("wdl")?"(무) ":"(핸디) ");
if (game.getType().equals("wdl")) {
	out.print("x" + game.getDrawRateStr());
	} else {
		out.print(game.getDrawRate()>0?"+":"");
		out.print(game.getDrawRate());
	}
%>
        <p mode="wrap">(패) x<%=game.getLoseRateStr()%></p>
        <p mode="wrap"><%=game.getAwayTeam()%></p>
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
if (pIdx > 0) {
%>
        <p mode="wrap"><a title="확인" href="play.wap?mode=viewGameResultList&pageIndex=<%=pIdx-1%>&amp;token=<%=token%>" accesskey="2">이전</a></p>
<%
}
%>
        <p mode="wrap"><a title="확인" href="play.wap?mode=viewGameResultList&pageIndex=<%=pIdx+1%>&amp;token=<%=token%>" accesskey="3">다음</a></p>
        <do type="options" label="상위"><go href="main.wap?token=<%=token%>"/></do>
        <do type="accept" label="확인" name="VX"><go href=""/></do>
    </card>
</wml>

