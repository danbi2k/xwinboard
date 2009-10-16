<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.w3.org/TR/XHTML-basic/XHTML-basic10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head>
    <title>?���ó�����?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
            <tr><td height="19" align="center" valign="middle" style="background-color:#8EC7FF;color:#000000">?���ó�����?</td></tr>
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
        </table></div>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
        <hr width="100%" style="color:#000000;width:100%;"/>
<%
	Betting betting = (Betting) request.getAttribute("betting");
%>
        <div>�����Ͻ� :&nbsp;<%=betting.getDateStr()%><br/>
        ����� :&nbsp;<%=betting.getRateStr()%><br/>
        ���ñݾ� :&nbsp;<%=XwinUtil.comma3(betting.getMoney())%><br/>
        �������߱ݾ� :&nbsp;<%=XwinUtil.comma3(betting.getExpect())%><br/>
        ���߱ݾ� :&nbsp;<%=betting.getStatus().equals(Code.BET_STATUS_SUCCESS)?XwinUtil.comma3(betting.getExpect()):"0"%></div>
<%
List<BetGame> betGameList = betting.getBetGameList();
if (betGameList != null && betGameList.size() > 0) {
	for (BetGame betGame : betGameList) {
%>
        <div>
        <table width="100%" style="border-width:1;border-style:solid;">
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>����Ͻ�</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betGame.getGameDateStr()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>(��) Ȩ��</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betGame.getHomeTeam()%>&nbsp;(<%=betGame.getWinRateStr()%>)</div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>��/�ڵ�ĸ</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div>(<%=betGame.getType().equals("wdl")?"�� " + betGame.getDrawRateStr():"�ڵ� " + (betGame.getDrawRate()>0?"+":"") + betGame.getDrawRate()%>)</div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>(��) ������</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=betGame.getAwayTeam()%>&nbsp;(<%=betGame.getLoseRateStr()%>)</div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>������</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=Code.getValue(betGame.getGuess())%></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div>�����</div>
                </td>
                <td>
                    <div><%=Code.getValue(betGame.getResult())%>&nbsp;<%=XwinUtil.nvl(betGame.getHomeScore())%><%=betGame.getHomeScore()!=null?" : ":"" %><%=XwinUtil.nvl(betGame.getAwayScore())%></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div>��������</div>
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
        <do type="vnd.up" label="����"><go href="betlog.wap?mode=viewMyBettingList&token=<%=token%>"/></do>
    </body>
</html>

