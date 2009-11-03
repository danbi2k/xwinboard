<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/wml20.dtd">
<html>
    <head>
    <title>?경기결과?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body id ="card1">
        <div><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
            <tr><td height="19" align="center" valign="middle" style="background-color:#8EC7FF;color:#000000">?경기결과?</td></tr>
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
        </table></div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <hr width="100%" style="color:#000000;width:100%;"/>
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
        <div>
        <table width="100%" style="border-width:1;border-style:solid;">
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.getBoardItemDate(game.getGameDate())%></div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=game.getLeagueName()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>(승) x<%=game.getWinRateStr()%></div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=game.getHomeTeam()%></div>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="border-width:1;border-style:solid;">
<%
out.print(game.getType().equals("wdl")?"(무) ":"(핸디) ");
if (game.getType().equals("wdl")) {
	out.print("x" + game.getDrawRateStr());
	} else {
		out.print(game.getDrawRate()>0?"+":"");
		out.print(game.getDrawRate());
	}
%>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>(패) x<%=game.getLoseRateStr()%></div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=game.getAwayTeam()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>경기결과</div>
                </td>
                <td style="border-width:1;border-style:solid;">
<%
if (game.getStatus().equals(Code.GAME_STATUS_END)) {
	out.print(game.getHomeScore() + " : " + game.getAwayScore() + " " + Code.getValue(game.getResult()));
} else {
	out.print(Code.getValue(game.getStatus()));
}%>	
                </td>
            </tr>
        </table>
        </div>
<%
	}
}
%>
<%
if (pIdx > 0) {
%>
        <div><a title="확인" href="play.wap?mode=viewGameResultList&pageIndex=<%=pIdx-1%>&amp;token=<%=token%>" accesskey="2">이전</a></div>
<%
}
%>
        <div><a title="확인" href="play.wap?mode=viewGameResultList&pageIndex=<%=pIdx+1%>&amp;token=<%=token%>" accesskey="3">다음</a></div>
        <wml:do type="vnd.up" label="상위"><wml:go href="main.wap?token=<%=token%>"/></wml:do>
    </body>
</html>

