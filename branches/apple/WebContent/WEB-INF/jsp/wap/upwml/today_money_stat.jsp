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
        <p align="center" mode="wrap">&lt;�������곻��&gt;</p>
<%
	String _bias = request.getParameter("bias");
	Integer bias = 0;
	if (_bias != null)
		bias = Integer.parseInt(_bias);
%>
        <p mode="wrap"><a title="Ȯ��" href="adminCommon.wap?mode=viewDailyBettingMoneySummary&bias=<%=bias-1%>&amp;token=<%=token%>">����</a></p>
        <p mode="wrap"><a title="Ȯ��" href="adminCommon.wap?mode=viewDailyBettingMoneySummary&bias=<%=bias+1%>&amp;token=<%=token%>">����</a></p>
<%		
	BetMoneyStat betMoneyStatToday = (BetMoneyStat) request.getAttribute("betMoneyStatToday");
	if (betMoneyStatToday != null) {
			Long benefit = betMoneyStatToday.getInMoney() - (betMoneyStatToday.getOutMoney() + betMoneyStatToday.getBettingPoint() + betMoneyStatToday.getBonusPoint());
%>

        <p mode="wrap">��¥</p>
        <p mode="wrap"><%=XwinUtil.toDateStr(betMoneyStatToday.getDate(), 2)%></p>
        <p mode="wrap">�ѹ��ñݾ�</p>
        <p mode="wrap"><%=XwinUtil.comma3(betMoneyStatToday.getInMoney())%></p>
        <p mode="wrap">�Ѵ�÷�ݾ�</p>
        <p mode="wrap"><%=XwinUtil.comma3(betMoneyStatToday.getOutMoney())%></p>
        <p mode="wrap">�ѹ�������Ʈ</p>
        <p mode="wrap"><%=XwinUtil.comma3(betMoneyStatToday.getBettingPoint())%></p>
        <p mode="wrap">������</p>
        <p mode="wrap"><%=XwinUtil.comma3(benefit)%></p>
<%
	}
%>
        <do type="options" label="����"><go href="admin.jsp?token=<%=token%>"/></do>
        <do type="accept" label="Ȯ��" name="VX"><go href=""/></do>
    </card>
</wml>

