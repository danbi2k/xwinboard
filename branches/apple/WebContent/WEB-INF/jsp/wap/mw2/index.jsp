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
<%
	Member adhocMember = (Member) request.getAttribute("adhocMember");
%>
        <div><%=adhocMember.getNickName()%>님 환영합니다!</div>
<%
String pin = adhocMember.getPin();
if (StringUtils.isNumeric(pin) && pin.length() == 6) {
%>
        <div><form name="pin_login" method="get" action="./login.wap">
            <div style="text-align:center;">
            <table width="100%" cellspacing="0" cellpadding="0" style="height:100%;background-color:#FFFFFF;">
                <tr>
                    <td align="left" style="background-color:#FFFFFF;">
                        <div>※ PIN 번호를 입력해 주세요<br/>
                        &nbsp;</div>
                        <div><img src="../picto_img/gif/core-arrow-right_2.gif" alt=""/>PIN번호</div>
                        <div><input type="password" name="pin" maxlength="6" value="" style="width:98%;text-align:center;" /></div>
                        <div><input type="hidden" name="token" value="<%=token%>" /></div>
                        <div style="text-align:center;margin:5 0 5 0;"><input type="submit" value="전송"/></div>
                    </td>
                </tr>
            </table>
            </div>
        </form></div>
<%}  else {%>
        <div>모바일서비스를 이용하시려면 홈페이지 '정보수정' 에서 '모바일PIN번호' 6자리를 등록하셔야 합니다.</div>
<%} %>
    </div>
    </body>
</html>
