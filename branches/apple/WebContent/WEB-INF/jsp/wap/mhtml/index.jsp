<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
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
            <div><input type="hidden" name="mode" value="processPinLogin" /></div>
<%}  else {%>
            <div><input type="hidden" name="mode" value="processUserLogin" /></div>
        <div>Ȩ������ '��������' ���� '�����PIN��ȣ' 6�ڸ��� ����Ͻø� ���� ���� �α����� ���� �մϴ�.</div>
<%} %>
    </body>
</html>

