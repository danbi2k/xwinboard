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
            <tr><td align="center" valign="middle" style="background-color:#8EC7FF;color:#000000;height:19px;">?관리?</td></tr>
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
        </table></div>
        <div>
        <table width="100%">
            <tr>
                <td style="width:50%;background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_images/gif/core-button-1.gif" alt=""/><a title="확인" href="adminCommon.wap?mode=viewDailyBettingMoneySummary&token=<%=token%>" accesskey="1">일일정산내역</a></div>
                </td>
                <td style="width:50%;background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_images/gif/core-button-2.gif" alt=""/><a title="확인" href="?token=<%=token%>" accesskey="2">경기별배팅현황</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_images/gif/core-button-3.gif" alt=""/><a title="확인" href="?token=<%=token%>" accesskey="3">충전신청내역</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_images/gif/core-button-4.gif" alt=""/><a title="확인" href="?token=<%=token%>" accesskey="4">환전신청내역</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_images/gif/core-button-5.gif" alt=""/><a title="확인" href="?token=<%=token%>" accesskey="5">충환전내역</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_images/gif/core-button-6.gif" alt=""/><a title="확인" href="?token=<%=token%>" accesskey="6">입출금내역</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_images/gif/core-button-7.gif" alt=""/><a title="확인" href="?token=<%=token%>" accesskey="7">고객센터</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_images/gif/core-button-8.gif" alt=""/><a title="확인" href="?token=<%=token%>" accesskey="8">게시판</a></div>
                </td>
            </tr>
        </table>
        </div>
    </div>
    </body>
</html>
