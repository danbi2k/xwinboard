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
    <title>?배팅내역상세?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body id ="card1">
        <div><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
            <tr><td height="19" align="center" valign="middle" style="background-color:#8EC7FF;color:#000000">?배팅내역상세?</td></tr>
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
        </table></div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <hr width="100%" style="color:#000000;width:100%;"/>
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
        <table width="100%" style="border-width:1;border-style:solid;">
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>경기일시</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betGame.getGameDateStr()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>(승) 홈팀</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betGame.getHomeTeam()%>&nbsp;(<%=betGame.getWinRateStr()%>)</div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>무/핸디캡</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div>(<%=betGame.getType().equals("wdl")?"무 " + betGame.getDrawRateStr():"핸디 " + (betGame.getDrawRate()>0?"+":"") + betGame.getDrawRate()%>)</div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>(패) 원정팀</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betGame.getAwayTeam()%>&nbsp;(<%=betGame.getLoseRateStr()%>)</div>
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
                <td>
                    <div>경기결과</div>
                </td>
                <td>
                    <div><%=Code.getValue(betGame.getResult())%>&nbsp;<%=XwinUtil.nvl(betGame.getHomeScore())%><%=betGame.getHomeScore()!=null?" : ":"" %><%=XwinUtil.nvl(betGame.getAwayScore())%></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div>적중유무</div>
                </td>
                <td>
                    <div><%=Code.getValue(betGame.getResultStatus())%></div>
                </td>
            </tr>
        </table>
        </div>
<%
	}
}
%>
        <wml:do type="vnd.up" label="상위"><wml:go href="betlog.wap?mode=viewMyBettingList&amp;token=<%=token%>"/></wml:do>
    </body>
</html>

