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
<!--Web Logic ���������� �ѱ��� �����ٸ� DOCTYPE ������ ������ ������.-->
<wml>
    <head>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <card id ="card1">
        <p align="center" mode="wrap">&lt;�����&gt;</p>
        <p mode="wrap">�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</p>
        <p>----------------</p>
<%
	List<Game> gameList = (List<Game>) request.getAttribute("gameList");
%>
<%
if (gameList != null) {
	for (Game game : gameList) {
%>
        <p mode="wrap">����Ͻ�</p>
        <p mode="wrap"><%=XwinUtil.getBoardItemDate(game.getGameDate())%></p>
        <p mode="wrap">����</p>
        <p mode="wrap"><%=game.getLeagueName()%></p>
        <p mode="wrap">(��) Ȩ��</p>
        <p mode="wrap"><%=game.getHomeTeam()%>&nbsp;x<%=game.getWinRateStr()%></p>
        <p mode="wrap">��/�ڵ�ĸ</p>
<%if (game.getType().equals("wdl")) {
	out.print("x" + game.getDrawRateStr());
	} else {
		out.print(game.getDrawRate()>0?"+":"");
		out.print(game.getDrawRate());
	}
%>
        <p mode="wrap">(��) ������</p>
        <p mode="wrap"><%=game.getAwayTeam()%>&nbsp;x<%=game.getLoseRateStr()%></p>
        <p mode="wrap">�����</p>
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
        <do type="options" label="����"><go href="main.wap?token=<%=token%>"/></do>
        <do type="accept" label="Ȯ��" name="VX"><go href=""/></do>
    </card>
</wml>
