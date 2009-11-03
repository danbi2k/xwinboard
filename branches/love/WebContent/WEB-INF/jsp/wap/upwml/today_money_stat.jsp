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
<!--Web Logic 웹서버에서 한글이 깨진다면 DOCTYPE 라인을 삭제해 보세요.-->
<wml>
    <head>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <card id ="card1">
        <p align="center" mode="wrap">&lt;일일정산내역&gt;</p>
<%
	String _bias = request.getParameter("bias");
	Integer bias = 0;
	if (_bias != null)
		bias = Integer.parseInt(_bias);
%>
        <p mode="wrap"><a title="확인" href="adminCommon.wap?mode=viewDailyBettingMoneySummary&bias=<%=bias-1%>&amp;token=<%=token%>">이전</a></p>
        <p mode="wrap"><a title="확인" href="adminCommon.wap?mode=viewDailyBettingMoneySummary&bias=<%=bias+1%>&amp;token=<%=token%>">다음</a></p>
<%		
	BetMoneyStat betMoneyStatToday = (BetMoneyStat) request.getAttribute("betMoneyStatToday");
	if (betMoneyStatToday != null) {
			Long benefit = betMoneyStatToday.getInMoney() - (betMoneyStatToday.getOutMoney() + betMoneyStatToday.getBettingPoint() + betMoneyStatToday.getBonusPoint());
%>

        <p mode="wrap">날짜</p>
        <p mode="wrap"><%=XwinUtil.toDateStr(betMoneyStatToday.getDate(), 2)%></p>
        <p mode="wrap">총배팅금액</p>
        <p mode="wrap"><%=XwinUtil.comma3(betMoneyStatToday.getInMoney())%></p>
        <p mode="wrap">총당첨금액</p>
        <p mode="wrap"><%=XwinUtil.comma3(betMoneyStatToday.getOutMoney())%></p>
        <p mode="wrap">총배팅포인트</p>
        <p mode="wrap"><%=XwinUtil.comma3(betMoneyStatToday.getBettingPoint())%></p>
        <p mode="wrap">순순익</p>
        <p mode="wrap"><%=XwinUtil.comma3(benefit)%></p>
<%
	}
%>
        <do type="options" label="상위"><go href="admin.jsp?token=<%=token%>"/></do>
        <do type="accept" label="확인" name="VX"><go href=""/></do>
    </card>
</wml>

