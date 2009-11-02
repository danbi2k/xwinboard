<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head>
    <title>&nbsp; </title>
        <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=0" />
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
    <div style="width:<%=lcdlx%>px">
        <div><table width="100%" cellspacing="0" cellpadding="0">
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
            <tr><td align="center" valign="middle" style="background-color:#8EC7FF;color:#000000;height:19px;">?일일정산내역?</td></tr>
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
        </table></div>
<%
	String _bias = request.getParameter("bias");
	Integer bias = 0;
	if (_bias != null)
		bias = Integer.parseInt(_bias);
%>
        <div style="text-align:left;display:inline;"><a title="확인" href="adminCommon.wap?mode=viewDailyBettingMoneySummary&bias=<%=bias-1%>&token=<%=token%>">이전</a></div>
        <div style="display:inline;"><a title="확인" href="adminCommon.wap?mode=viewDailyBettingMoneySummary&bias=<%=bias+1%>&token=<%=token%>">다음</a></div>
<%		
	BetMoneyStat betMoneyStatToday = (BetMoneyStat) request.getAttribute("betMoneyStatToday");
	if (betMoneyStatToday != null) {
			Long benefit = betMoneyStatToday.getInMoney() - (betMoneyStatToday.getOutMoney() + betMoneyStatToday.getBettingPoint() + betMoneyStatToday.getBonusPoint());
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
        <div><a title="상위" href="admin.jsp?token=<%=token%>">상위</a></div>
    </div>
    </body>
</html>
