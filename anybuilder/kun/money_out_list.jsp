<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
%>
<%@ include file="../include/anybuilder.jsp"%>
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
    <title>환전내역</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <% if (network.equals("wcdma")) { %><a href='#' accesskey='#'></a><% } %>
        <div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td width="100%" height="1" bgcolor="#D9D9FF"></td></tr>
            <tr><td height="19" align="center" bgcolor="#8EC7FF"><font color="#000000">환전내역</font></td></tr>
            <tr><td height="1" bgcolor="#D9D9FF"></td></tr>
            <tr><td height="1" bgcolor="#D9D9FF"></td></tr>
        </table>
        </div>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%
	Member member = (Member) request.getAttribute("Member");
%>
닉네임 : <%=member.getNickName()%>님<br>
잔고 : <%=XwinUtil.comma3(member.getBalance())%>
<%
	List<MoneyOut> moneyOutList = (List<MoneyOut>) request.getAttribute("moneyOutList");
%>
<%%>
        <div>
        <table width="100%">
            <tr>
                <td>
                    <div>신청날짜</div>
                </td>
                <td>
                    <div><%=moneyOut.getReqDateStr()%></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div>계좌번호</div>
                </td>
                <td>
                    <div>[<%=moneyOut.getBankName()%>]&nbsp;<%=moneyOut.getNumber()%>&nbsp;<%=moneyOut.getName()%></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div>환전금액</div>
                </td>
                <td>
                    <div><%=XwinUtil.comma3(moneyOut.getMoney())%></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div>상태</div>
                </td>
                <td>
                    <div><%=Code.getValue(moneyOut.getStatus())%></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div>환전날짜</div>
                </td>
                <td>
                    <div><%=moneyOut.getProcDateStr()%></div>
                </td>
            </tr>
        </table>
        </div>
<%%>
        <btn name="상위" href="index.jsp">
        <hr size="1" color="#BBBBBB">
        <table cellpadding="0" cellspacing="1">
            <tr>
                <td width="16" align="center"><img src="file:////images/magicn/number_square_0.sis"></td>
                <td><a href="index.jsp" accesskey="0"><font color="#0000FF">상위</font></a></td>
            </tr>
        </table>
    </body>
</html>

