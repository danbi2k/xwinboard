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
    <title>?�����?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
            <tr><td height="19" align="center" valign="middle" style="background-color:#8EC7FF;color:#000000">?�����?</td></tr>
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
        </table></div>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
        <hr width="100%" style="color:#000000;width:100%;"/>
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
                    <div>����Ͻ�</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.getBoardItemDate(game.getGameDate())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>����</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=game.getLeagueName()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>(��) Ȩ��</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=game.getHomeTeam()%>&nbsp;x<%=game.getWinRateStr()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>��/�ڵ�ĸ</div>
                </td>
                <td style="border-width:1;border-style:solid;">
<%if (game.getType().equals("wdl")) {
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
                    <div>(��) ������</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=game.getAwayTeam()%>&nbsp;x<%=game.getLoseRateStr()%></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div>�����</div>
                </td>
                <td>
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
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
%>
<%
if (pIdx > 0) {
%>
        <div><a title="Ȯ��" href="play.wap?mode=viewGameResultList&pageIndex=<%=pIdx-1%>&token=<%=token%>" accesskey="2">����</a></div>
<%
}
%>
        <div><a title="Ȯ��" href="play.wap?mode=viewGameResultList&pageIndex=<%=pIdx+1%>&token=<%=token%>" accesskey="3">����</a></div>
        <do type="vnd.up" label="����"><go href="main.wap?token=<%=token%>"/></do>
    </body>
</html>

