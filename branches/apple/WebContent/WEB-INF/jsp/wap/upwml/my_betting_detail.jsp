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
        <p align="center" mode="wrap">&lt;���ó�����&gt;</p>
        <p mode="wrap">�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</p>
        <p>----------------</p>
<%
	Betting betting = (Betting) request.getAttribute("betting");
%>
        <p mode="wrap">�����Ͻ� :&nbsp;<%=betting.getDateStr()%><br/>
        ����� :&nbsp;<%=betting.getRateStr()%><br/>
        ���ñݾ� :&nbsp;<%=XwinUtil.comma3(betting.getMoney())%><br/>
        �������߱ݾ� :&nbsp;<%=XwinUtil.comma3(betting.getExpect())%><br/>
        ���߱ݾ� :&nbsp;<%=betting.getStatus().equals(Code.BET_STATUS_SUCCESS)?XwinUtil.comma3(betting.getExpect()):"0"%></p>
<%
List<BetGame> betGameList = betting.getBetGameList();
if (betGameList != null && betGameList.size() > 0) {
	for (BetGame betGame : betGameList) {
%>
        <p mode="wrap">����Ͻ�</p>
        <p mode="wrap"><%=betGame.getGameDateStr()%></p>
        <p mode="wrap">(��) Ȩ��</p>
        <p mode="wrap"><%=betGame.getHomeTeam()%>&nbsp;(<%=betGame.getWinRateStr()%>)</p>
        <p mode="wrap">��/�ڵ�ĸ</p>
        <p mode="wrap">(<%=betGame.getType().equals("wdl")?"�� " + betGame.getDrawRateStr():"�ڵ� " + (betGame.getDrawRate()>0?"+":"") + betGame.getDrawRate()%>)</p>
        <p mode="wrap">(��) ������</p>
        <p mode="wrap"><%=betGame.getAwayTeam()%>&nbsp;(<%=betGame.getLoseRateStr()%>)</p>
        <p mode="wrap">������</p>
        <p mode="wrap"><%=Code.getValue(betGame.getGuess())%></p>
        <p mode="wrap">�����</p>
        <p mode="wrap"><%=Code.getValue(betGame.getResult())%>&nbsp;<%=XwinUtil.nvl(betGame.getHomeScore())%><%=betGame.getHomeScore()!=null?" : ":"" %><%=XwinUtil.nvl(betGame.getAwayScore())%></p>
        <p mode="wrap">��������</p>
        <p mode="wrap"><%=Code.getValue(betGame.getResultStatus())%></p>
<%
	}
}
%>
        <do type="options" label="����"><go href="betlog.wap?mode=viewMyBettingList&amp;token=<%=token%>"/></do>
        <do type="accept" label="Ȯ��" name="VX"><go href=""/></do>
    </card>
</wml>

