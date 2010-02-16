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
    <title>?일일정산내역?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body id ="card1">
        <div><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
            <tr><td height="19" align="center" valign="middle" style="background-color:#8EC7FF;color:#000000">?일일정산내역?</td></tr>
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
        </table></div>
<%
	String _bias = request.getParameter("bias");
	Integer bias = 0;
	if (_bias != null)
		bias = Integer.parseInt(_bias);
%>
        <div align="left" style="display:inline;"><a title="확인" href="adminCommon.wap?mode=viewDailyBettingMoneySummary&bias=<%=bias-1%>&amp;token=<%=token%>">이전</a></div>
        <div style="display:inline;"><a title="확인" href="adminCommon.wap?mode=viewDailyBettingMoneySummary&bias=<%=bias+1%>&amp;token=<%=token%>">다음</a></div>
<%		
	BetMoneyStat betMoneyStatToday = (BetMoneyStat) request.getAttribute("betMoneyStatToday");
	if (betMoneyStatToday != null) {
			Long benefit = betMoneyStatToday.getInMoney() - (betMoneyStatToday.getOutMoney() + betMoneyStatToday.getBettingPoint()) + betMoneyStatToday.getBonusPoint();
%>

        <div>
        <table width="100%" style="border-width:1;border-style:solid;">
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>날짜</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.toDateStr(betMoneyStatToday.getDate(), 2)%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>총배팅금액</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(betMoneyStatToday.getInMoney())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>총당첨금액</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(betMoneyStatToday.getOutMoney())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>총배팅포인트</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(betMoneyStatToday.getBettingPoint())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>직충전차감</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(betMoneyStatToday.getBonusPoint())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>순순익</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(benefit)%></div>
                </td>
            </tr>
        </table>
        </div>
<%
	}
%>
        <wml:do type="vnd.up" label="상위"><wml:go href="admin.jsp?token=<%=token%>"/></wml:do>
    </body>
</html>

