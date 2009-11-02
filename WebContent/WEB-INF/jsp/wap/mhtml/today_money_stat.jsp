<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<html>
    <head>
    <title>【일일정산내역】</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>【일일정산내역】</center></div>
<%
	String _bias = request.getParameter("bias");
	Integer bias = 0;
	if (_bias != null)
		bias = Integer.parseInt(_bias);
%>
        <div><a btn="확인" href="adminCommon.wap?mode=viewDailyBettingMoneySummary&bias=<%=bias-1%>&token=<%=token%>">이전</a></div>
        <div><a btn="확인" href="adminCommon.wap?mode=viewDailyBettingMoneySummary&bias=<%=bias+1%>&token=<%=token%>">다음</a></div>
<%		
	BetMoneyStat betMoneyStatToday = (BetMoneyStat) request.getAttribute("betMoneyStatToday");
	if (betMoneyStatToday != null) {
			Long benefit = betMoneyStatToday.getInMoney() - (betMoneyStatToday.getOutMoney() + betMoneyStatToday.getBettingPoint() + betMoneyStatToday.getBonusPoint());
%>

        <div>날짜</div>
        <div><%=XwinUtil.toDateStr(betMoneyStatToday.getDate(), 2)%></div>
        <div>총배팅금액</div>
        <div><%=XwinUtil.comma3(betMoneyStatToday.getInMoney())%></div>
        <div>총당첨금액</div>
        <div><%=XwinUtil.comma3(betMoneyStatToday.getOutMoney())%></div>
        <div>총배팅포인트</div>
        <div><%=XwinUtil.comma3(betMoneyStatToday.getBettingPoint())%></div>
        <div>순순익</div>
        <div><%=XwinUtil.comma3(benefit)%></div>
<%
	}
%>
        <btn name="상위" href="admin.jsp?token=<%=token%>">
    </body>
</html>

