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
        <p align="center" mode="wrap">&lt;배팅내역상세&gt;</p>
        <p mode="wrap">닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</p>
        <p>----------------</p>
<%
	Betting betting = (Betting) request.getAttribute("betting");
%>
        <p mode="wrap">배팅일시 :&nbsp;<%=betting.getDateStr()%><br/>
        배당율 :&nbsp;<%=betting.getRateStr()%><br/>
        배팅금액 :&nbsp;<%=XwinUtil.comma3(betting.getMoney())%><br/>
        예상적중금액 :&nbsp;<%=XwinUtil.comma3(betting.getExpect())%><br/>
        적중금액 :&nbsp;<%=betting.getStatus().equals(Code.BET_STATUS_SUCCESS)?XwinUtil.comma3(betting.getExpect()):"0"%></p>
<%
List<BetGame> betGameList = betting.getBetGameList();
if (betGameList != null && betGameList.size() > 0) {
	for (BetGame betGame : betGameList) {
%>
        <p mode="wrap"><%=XwinUtil.getBoardItemDate(betGame.getGameDate())%></p>
        <p mode="wrap"><%=betGame.getLeagueName()%></p>
        <p mode="wrap">(승) x<%=betGame.getWinRateStr()%></p>
        <p mode="wrap"><%=betGame.getHomeTeam()%></p>
<%
out.print(betGame.getType().equals("wdl")?"(무) ":"(핸디) ");
if (betGame.getType().equals("wdl")) {
	out.print("x" + betGame.getDrawRateStr());
	} else {
		out.print(betGame.getDrawRate()>0?"+":"");
		out.print(betGame.getDrawRate());
	}
%>
        <p mode="wrap">(패) x<%=betGame.getLoseRateStr()%></p>
        <p mode="wrap"><%=betGame.getAwayTeam()%></p>
        <p mode="wrap">배팅팀</p>
        <p mode="wrap"><%=Code.getValue(betGame.getGuess())%></p>
        <p mode="wrap">경기결과</p>
<%
if (betGame.getStatus().equals(Code.GAME_STATUS_END)) {
	out.print(betGame.getHomeScore() + " : " + betGame.getAwayScore() + " " + Code.getValue(betGame.getResult()));
} else {
	out.print(Code.getValue(betGame.getStatus()));
}%>	
        <p mode="wrap">적중유무</p>
        <p mode="wrap"><%=Code.getValue(betGame.getResultStatus())%></p>
<%
	}
}
%>
        <do type="options" label="상위"><go href="betlog.wap?mode=viewMyBettingList&amp;token=<%=token%>"/></do>
        <do type="accept" label="확인" name="VX"><go href=""/></do>
    </card>
</wml>

