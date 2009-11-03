<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<% if (Integer.parseInt(lcdlx) >= 240) {
    response.setHeader("KTF-Page-Resolution:","240x320");
} else if (Integer.parseInt(lcdlx) >= 176) {
    response.setHeader("KTF-Page-Resolution:","176x220");
} else if (Integer.parseInt(lcdlx) >= 128) {
    response.setHeader("KTF-Page-Resolution:","128x160");
} else {
    response.setHeader("KTF-Page-Resolution:","120x160");
} %>
<html>
    <head>
    <title>?배팅내역상세?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <% if (network.equals("wcdma")) { %><a href='#' accesskey='#'></a><% } %>
        <div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td width="100%" height="1" bgcolor="#D9D9FF"></td></tr>
            <tr><td height="19" align="center" bgcolor="#8EC7FF"><font color="#000000">?배팅내역상세?</font></td></tr>
            <tr><td height="1" bgcolor="#D9D9FF"></td></tr>
            <tr><td height="1" bgcolor="#D9D9FF"></td></tr>
        </table>
        </div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <hr width="100%" color="#000000"/>
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
        <div>
        <table width="100%" border="1" style="border-width:1;border-style:solid;">
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.getBoardItemDate(betGame.getGameDate())%></div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betGame.getLeagueName()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>(승) x<%=betGame.getWinRateStr()%></div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betGame.getHomeTeam()%></div>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="border-width:1;border-style:solid;">
<%
out.print(betGame.getType().equals("wdl")?"(무) ":"(핸디) ");
if (betGame.getType().equals("wdl")) {
	out.print("x" + betGame.getDrawRateStr());
	} else {
		out.print(betGame.getDrawRate()>0?"+":"");
		out.print(betGame.getDrawRate());
	}
%>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>(패) x<%=betGame.getLoseRateStr()%></div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betGame.getAwayTeam()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>배팅팀</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=Code.getValue(betGame.getGuess())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>경기결과</div>
                </td>
                <td style="border-width:1;border-style:solid;">
<%
if (betGame.getStatus().equals(Code.GAME_STATUS_END)) {
	out.print(betGame.getHomeScore() + " : " + betGame.getAwayScore() + " " + Code.getValue(betGame.getResult()));
} else {
	out.print(Code.getValue(betGame.getStatus()));
}%>	
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>적중유무</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=Code.getValue(betGame.getResultStatus())%></div>
                </td>
            </tr>
        </table>
        </div>
<%
	}
}
%>
        <btn name="상위" href="betlog.wap?mode=viewMyBettingList&token=<%=token%>">
        <hr size="1" color="#BBBBBB">
        <table cellpadding="0" cellspacing="1">
            <tr>
                <td width="16" align="center"><img src="file:////images/magicn/number_square_0.sis"></td>
                <td><a href="betlog.wap?mode=viewMyBettingList&token=<%=token%>" accesskey="0"><font color="#0000FF">상위</font></a></td>
            </tr>
        </table>
    </body>
</html>

