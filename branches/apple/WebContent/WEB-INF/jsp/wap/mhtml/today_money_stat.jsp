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
    <title>���������곻����</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>���������곻����</center></div>
<%
	String _bias = request.getParameter("bias");
	Integer bias = 0;
	if (_bias != null)
		bias = Integer.parseInt(_bias);
%>
        <div><a btn="Ȯ��" href="adminCommon.wap?mode=viewDailyBettingMoneySummary&bias=<%=bias-1%>&token=<%=token%>">����</a></div>
        <div><a btn="Ȯ��" href="adminCommon.wap?mode=viewDailyBettingMoneySummary&bias=<%=bias+1%>&token=<%=token%>">����</a></div>
<%		
	BetMoneyStat betMoneyStatToday = (BetMoneyStat) request.getAttribute("betMoneyStatToday");
	if (betMoneyStatToday != null) {
			Long benefit = betMoneyStatToday.getInMoney() - (betMoneyStatToday.getOutMoney() + betMoneyStatToday.getBettingPoint() + betMoneyStatToday.getBonusPoint());
%>

        <div>��¥</div>
        <div><%=XwinUtil.toDateStr(betMoneyStatToday.getDate(), 2)%></div>
        <div>�ѹ��ñݾ�</div>
        <div><%=XwinUtil.comma3(betMoneyStatToday.getInMoney())%></div>
        <div>�Ѵ�÷�ݾ�</div>
        <div><%=XwinUtil.comma3(betMoneyStatToday.getOutMoney())%></div>
        <div>�ѹ�������Ʈ</div>
        <div><%=XwinUtil.comma3(betMoneyStatToday.getBettingPoint())%></div>
        <div>������</div>
        <div><%=XwinUtil.comma3(benefit)%></div>
<%
	}
%>
        <btn name="����" href="admin.jsp?token=<%=token%>">
    </body>
</html>

