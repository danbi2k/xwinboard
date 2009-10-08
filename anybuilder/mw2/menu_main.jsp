<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
%>
<%@ include file="../include/anybuilder.jsp"%>
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
            <tr><td align="center" valign="middle" style="background-color:#8EC7FF;color:#000000;height:19px;">Apple</td></tr>
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
            <tr><td style="background-color:#D9D9FF;height:1px;"></td></tr>
        </table></div>
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
                <td style="width:50%;background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_img/gif/core-button-1.gif" alt=""/><a title="확인" href="index.jsp" accesskey="1">승무패</a></div>
                </td>
                <td style="width:50%;background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_img/gif/core-button-5.gif" alt=""/><a title="확인" href="index.jsp" accesskey="5">핸디캡</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_img/gif/core-button-2.gif" alt=""/><a title="확인" href="index.jsp" accesskey="2">배팅내역</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_img/gif/core-button-6.gif" alt=""/><a title="확인" href="index.jsp" accesskey="6">경기결과</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_img/gif/core-button-3.gif" alt=""/><a title="확인" href="index.jsp" accesskey="3">환전신청</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_img/gif/core-button-7.gif" alt=""/><a title="확인" href="index.jsp" accesskey="7">환전내역</a></div>
                </td>
            </tr>
            <tr>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_img/gif/core-button-4.gif" alt=""/><a title="확인" href="index.jsp" accesskey="4">충전신청</a></div>
                </td>
                <td style="background-color:#F5F5F5;">
                    <div style="white-space:nowrap;"><img src="../picto_img/gif/core-button-8.gif" alt=""/><a title="확인" href="index.jsp" accesskey="8">충전내역</a></div>
                </td>
            </tr>
        </table>
        </div>
        <div><a title="상위" href="index.jsp">상위</a></div>
    </div>
    </body>
</html>
