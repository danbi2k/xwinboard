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
    <title>?관리?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td width="100%" height="1" bgcolor="#D9D9FF"></td></tr>
            <tr><td height="19" align="center" bgcolor="#8EC7FF"><font color="#000000">?관리?</font></td></tr>
            <tr><td height="1" bgcolor="#D9D9FF"></td></tr>
            <tr><td height="1" bgcolor="#D9D9FF"></td></tr>
        </table>
        </div>
        <div>
        <table width="100%">
            <tr>
                <td width="50%" bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_1.sis"><a href="adminCommon.wap?mode=viewDailyBettingMoneySummary&token=<%=token%>" accesskey="1"><marquee type="auto">일일정산내역</marquee></a></div>
                </td>
                <td width="50%" bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_2.sis"><a href="?token=<%=token%>" accesskey="2"><marquee type="auto">경기별배팅현황</marquee></a></div>
                </td>
            </tr>
            <tr>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_3.sis"><a href="?token=<%=token%>" accesskey="3"><marquee type="auto">충전신청내역</marquee></a></div>
                </td>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_4.sis"><a href="?token=<%=token%>" accesskey="4"><marquee type="auto">환전신청내역</marquee></a></div>
                </td>
            </tr>
            <tr>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_5.sis"><a href="?token=<%=token%>" accesskey="5"><marquee type="auto">충환전내역</marquee></a></div>
                </td>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_6.sis"><a href="?token=<%=token%>" accesskey="6"><marquee type="auto">입출금내역</marquee></a></div>
                </td>
            </tr>
            <tr>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_7.sis"><a href="?token=<%=token%>" accesskey="7"><marquee type="auto">고객센터</marquee></a></div>
                </td>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_8.sis"><a href="?token=<%=token%>" accesskey="8"><marquee type="auto">게시판</marquee></a></div>
                </td>
            </tr>
        </table>
        </div>
    </body>
</html>

