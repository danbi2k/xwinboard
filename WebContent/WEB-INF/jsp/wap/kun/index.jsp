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
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
<%
	Member adhocMember = (Member) request.getAttribute("adhocMember");
%>
        <div><%=adhocMember.getNickName()%>�� ȯ���մϴ�!</div>
<%
String pin = adhocMember.getPin();
if (StringUtils.isNumeric(pin) && pin.length() == 6) {
%>
        <div><form name="pin_login" method="get" action="./login.wap">
            <div align="center">
            <table width="100%" height="100%" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF" style="background-color:#FFFFFF;">
                <tr>
                    <td align="left" bgcolor="#FFFFFF" style="background-color:#FFFFFF;">
                        <div>�� PIN ��ȣ�� �Է��� �ּ���<br/>
                        &nbsp;</div>
                        <div>��PIN��ȣ</div>
                        <div><input type="text" name="pin" maxlength="6" value="" format="1" style="width:98%;text-align:center;" /></div>
                        <div><input type="hidden" name="token" value="<%=token%>" /></div>
                        <div style="text-align:center;margin:5 0 5 0;"><input type="submit" value="����"/></div>
                    </td>
                </tr>
            </table>
            </div>
        </form></div>
<%}  else {%>
        <div>����ϼ��񽺸� �̿��Ͻ÷��� Ȩ������ '��������' ���� '�����PIN��ȣ' 6�ڸ��� ����ϼž� �մϴ�.</div>
<%} %>
    </body>
</html>

