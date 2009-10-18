<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.w3.org/TR/XHTML-basic/XHTML-basic10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
<%
	Member adhocMember = (Member) request.getAttribute("adhocMember");
%>
        <div><%=adhocMember.getNickName()%>님 환영합니다!</div>
<%
String pin = adhocMember.getPin();
if (StringUtils.isNumeric(pin) && pin.length() == 6) {
%>
        <div><form name="pin_login" method="get" action="./login.wap">
            <div align="center">
            <table width="100%" height="100%" cellspacing="0" cellpadding="0" style="background-color:#FFFFFF;">
                <tr>
                    <td align="left" style="background-color:#FFFFFF;">
                        <div>※ PIN 번호를 입력해 주세요<br/>
                        &nbsp;</div>
                        <div><img localsrc="pict:///core/arrow/right_4" alt=""/>PIN번호</div>
                        <div><input type="password" name="pin" maxlength="6" value="" format="N*N" emptyok="true" style="width:98%;text-align:center;" /></div>
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
    </body>
</html>

