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
            <tr><td align="center" valign="middle" style="background-color:#8EC7FF;color:#000000;height:19px;">?충전내역?</td></tr>
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
        </table></div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <hr style="color:#000000;width:100%;"/>
<%
	List<MoneyIn> moneyInList = (List<MoneyIn>) request.getAttribute("moneyInList");
%>
<%
if (moneyInList != null && moneyInList.size() > 0) {
	for (MoneyIn moneyIn : moneyInList) {
%>	
        <div>
        <table width="100%" style="border-width:1;border-style:solid;">
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>신청날짜</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=moneyIn.getReqDateStr()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>입금계좌</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div>[<%=moneyIn.getBankBook().getBankName()%>]&nbsp;<%=moneyIn.getBankBook().getNumber()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>입금자</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=moneyIn.getName()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>입금액</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(moneyIn.getMoney())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>상태</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=Code.getValue(moneyIn.getStatus())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>처리일시</div>
                </td>
                <td style="border-width:1;border-style:solid;">
<%
if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST)) {
%>
                    <div><a title="확인" href="earncache.wap?mode=cancelMoneyInRequest&id=<%=moneyIn.getId()%>&token=<%=token%>">신청취소</a></div>
<%
} else {
	out.print(moneyIn.getProcDateStr());
}
%>
                </td>
            </tr>
        </table>
        </div>
<%
	}
}
%>
        <div><a title="상위" href="main.wap?token=<%=token%>">상위</a></div>
    </div>
    </body>
</html>
