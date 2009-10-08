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
    <title>Apple</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <% if (network.equals("wcdma")) { %><a href='#' accesskey='#'></a><% } %>
        <div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td width="100%" height="1" bgcolor="#D9D9FF"></td></tr>
            <tr><td height="19" align="center" bgcolor="#8EC7FF"><font color="#000000">Apple</font></td></tr>
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
        <div>
        <table width="100%">
            <tr>
                <td width="50%" bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_1.sis"><a href="index.jsp" accesskey="1"><marquee type="auto">승무패</marquee></a></div>
                </td>
                <td width="50%" bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_5.sis"><a href="index.jsp" accesskey="5"><marquee type="auto">핸디캡</marquee></a></div>
                </td>
            </tr>
            <tr>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_2.sis"><a href="index.jsp" accesskey="2"><marquee type="auto">배팅내역</marquee></a></div>
                </td>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_6.sis"><a href="index.jsp" accesskey="6"><marquee type="auto">경기결과</marquee></a></div>
                </td>
            </tr>
            <tr>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_3.sis"><a href="index.jsp" accesskey="3"><marquee type="auto">환전신청</marquee></a></div>
                </td>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_7.sis"><a href="index.jsp" accesskey="7"><marquee type="auto">환전내역</marquee></a></div>
                </td>
            </tr>
            <tr>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_4.sis"><a href="index.jsp" accesskey="4"><marquee type="auto">충전신청</marquee></a></div>
                </td>
                <td bgcolor="#F5F5F5" style="background-color:#F5F5F5;">
                    <div><img src="file:////images/magicn/number_square_8.sis"><a href="index.jsp" accesskey="8"><marquee type="auto">충전내역</marquee></a></div>
                </td>
            </tr>
        </table>
        </div>
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

