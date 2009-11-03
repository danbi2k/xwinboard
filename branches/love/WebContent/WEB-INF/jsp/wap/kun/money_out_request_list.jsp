<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<% if (Integer.parseInt(lcdlx) >= 240) {
    response.setHeader("KTF-Page-Resolution:","240x320");
} else if (Integer.parseInt(lcdlx) >= 176) {
    response.setHeader("KTF-Page-Resolution:","176x220");
} else if (Integer.parseInt(lcdlx) >= 128) {
    response.setHeader("KTF-Page-Resolution:","128x160");
} else {
    response.setHeader("KTF-Page-Resolution:","120x160");
} %>
<html>
    <head>
    <title>?환전내역?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <% if (network.equals("wcdma")) { %><a href='#' accesskey='#'></a><% } %>
        <div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td width="100%" height="1" bgcolor="#D9D9FF"></td></tr>
            <tr><td height="19" align="center" bgcolor="#8EC7FF"><font color="#000000">?환전내역?</font></td></tr>
            <tr><td height="1" bgcolor="#D9D9FF"></td></tr>
            <tr><td height="1" bgcolor="#D9D9FF"></td></tr>
        </table>
        </div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <hr width="100%" color="#000000"/>
<%
	List<MoneyOut> moneyOutList = (List<MoneyOut>) request.getAttribute("moneyOutList");
%>
<%
if (moneyOutList != null && moneyOutList.size() > 0) {
	for (MoneyOut moneyOut : moneyOutList) {
%>
        <div>
        <table width="100%" border="1" style="border-width:1;border-style:solid;">
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>신청날짜</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=moneyOut.getReqDateStr()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>계좌번호</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div>[<%=moneyOut.getBankName()%>]&nbsp;<%=moneyOut.getNumber()%>&nbsp;<%=moneyOut.getName()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>환전금액</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(moneyOut.getMoney())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>상태</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=Code.getValue(moneyOut.getStatus())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>환전날짜</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=moneyOut.getProcDateStr()%></div>
                </td>
            </tr>
        </table>
        </div>
<%
	}
}
%>
        <btn name="상위" href="main.wap?token=<%=token%>">
        <hr size="1" color="#BBBBBB">
        <table cellpadding="0" cellspacing="1">
            <tr>
                <td width="16" align="center"><img src="file:////images/magicn/number_square_0.sis"></td>
                <td><a href="main.wap?token=<%=token%>" accesskey="0"><font color="#0000FF">상위</font></a></td>
            </tr>
        </table>
    </body>
</html>

