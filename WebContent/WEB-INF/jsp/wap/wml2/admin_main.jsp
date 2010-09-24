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
    <title>?관리?</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body id ="card1">
        <div><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
            <tr><td height="19" align="center" valign="middle" style="background-color:#8EC7FF;color:#000000">?관리?</td></tr>
            <tr><td height="1" style="background-color:#D9D9FF"></td></tr>
        </table></div>
        <div>
        <table width="100%">
            <tr>
                <td width="50%" style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/1"/><a title="확인" href="adminCommon.wap?mode=viewDailyBettingMoneySummary&amp;token=<%=token%>" accesskey="1" style="marquee-style:sktscroll;">일일정산내역</a></div>
                </td>
                <td width="50%" style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/2"/><a title="확인" href="?token=<%=token%>" accesskey="2" style="marquee-style:sktscroll;">경기별배팅현황</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/3"/><a title="확인" href="?token=<%=token%>" accesskey="3" style="marquee-style:sktscroll;">충전신청내역</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/4"/><a title="확인" href="?token=<%=token%>" accesskey="4" style="marquee-style:sktscroll;">환전신청내역</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/5"/><a title="확인" href="?token=<%=token%>" accesskey="5" style="marquee-style:sktscroll;">충환전내역</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/6"/><a title="확인" href="?token=<%=token%>" accesskey="6" style="marquee-style:sktscroll;">입출금내역</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/7"/><a title="확인" href="?token=<%=token%>" accesskey="7" style="marquee-style:sktscroll;">고객센터</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div><img localsrc="pict:///core/button/8"/><a title="확인" href="?token=<%=token%>" accesskey="8" style="marquee-style:sktscroll;">게시판</a></div>
                </td>
            </tr>
        </table>
        </div>
    </body>
</html>

