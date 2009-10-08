﻿<%@ page contentType="text/html;charset=utf-8"%>
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
            <tr><td align="center" valign="middle" style="background-color:#8EC7FF;color:#000000;height:19px;">환전신청</td></tr>
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
        <div><form name="money_out_request" method="get" action="./sendcache.wap">
            <div><input type="hidden" name="mode" value="moneyOutRequest" /></div>
            <div style="text-align:center;">
            <table width="100%" cellspacing="0" cellpadding="0" style="height:100%;background-color:#FF6600;">
                <tr>
                    <td align="left" valign="middle" style="width:5px;">
                    </td>
                    <td align="left" valign="top" style="background-color:#FFFFFF;padding : 5 0 0 5;">
                        <div>&nbsp;<br/>
                        ■ 신청액과 PIN번호를 입력해주세요.<br/>
                        &nbsp;</div>
                        <div><img src="../picto_img/gif/core-arrow-right_2.gif" alt=""/>신청액</div>
                        <div><input type="text" name="money" value="" style="width:98%;text-align:center;" /></div>
                        <div><img src="../picto_img/gif/core-arrow-right_2.gif" alt=""/>PIN번호</div>
                        <div><input type="password" name="pin" value="" style="width:98%;text-align:center;" /></div>
                        <div style="text-align:center;margin:5 0 5 0;"><input type="submit" value="전송"/></div>
                    </td>
                    <td align="left" valign="middle" style="width:5px;">
                    </td>
                </tr>
            </table>
            </div>
        </form></div>
        <div><a title="상위" href="index.jsp">상위</a></div>
    </div>
    </body>
</html>
