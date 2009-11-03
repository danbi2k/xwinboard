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
    <title>?��������?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <% if (network.equals("wcdma")) { %><a href='#' accesskey='#'></a><% } %>
        <div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td width="100%" height="1" bgcolor="#D9D9FF"></td></tr>
            <tr><td height="19" align="center" bgcolor="#8EC7FF"><font color="#000000">?��������?</font></td></tr>
            <tr><td height="1" bgcolor="#D9D9FF"></td></tr>
            <tr><td height="1" bgcolor="#D9D9FF"></td></tr>
        </table>
        </div>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
        <hr width="100%" color="#000000"/>
<%
	List<MoneyIn> moneyInList = (List<MoneyIn>) request.getAttribute("moneyInList");
%>
<%
if (moneyInList != null && moneyInList.size() > 0) {
	for (MoneyIn moneyIn : moneyInList) {
%>	
        <div>
        <table width="100%" border="1" style="border-width:1;border-style:solid;">
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>��û��¥</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=moneyIn.getReqDateStr()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>�Աݰ���</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div>[<%=moneyIn.getBankBook().getBankName()%>]&nbsp;<%=moneyIn.getBankBook().getNumber()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>�Ա���</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=moneyIn.getName()%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>�Աݾ�</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=XwinUtil.comma3(moneyIn.getMoney())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>����</div>
                </td>
                <td style="border-width:1;border-style:solid;">
                    <div><%=Code.getValue(moneyIn.getStatus())%></div>
                </td>
            </tr>
            <tr>
                <td style="border-width:1;border-style:solid;">
                    <div>ó���Ͻ�</div>
                </td>
                <td style="border-width:1;border-style:solid;">
<%
if (moneyIn.getStatus().equals(Code.MONEY_IN_REQUEST)) {
%>
                    <div><a href="earncache.wap?mode=cancelMoneyInRequest&id=<%=moneyIn.getId()%>&token=<%=token%>">��û���</a></div>
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
        <btn name="����" href="main.wap?token=<%=token%>">
        <hr size="1" color="#BBBBBB">
        <table cellpadding="0" cellspacing="1">
            <tr>
                <td width="16" align="center"><img src="file:////images/magicn/number_square_0.sis"></td>
                <td><a href="main.wap?token=<%=token%>" accesskey="0"><font color="#0000FF">����</font></a></td>
            </tr>
        </table>
    </body>
</html>

