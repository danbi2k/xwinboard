<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/vnd.wap.wml;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");
%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
    <head>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <card id ="card1">
<%
	Member adhocMember = (Member) request.getAttribute("adhocMember");
%>
        <p mode="wrap"><%=adhocMember.getNickName()%>�� ȯ���մϴ�!</p>
<%
String pin = adhocMember.getPin();
if (StringUtils.isNumeric(pin) && pin.length() == 6) {
%>
<%}  else {%>
        <p mode="wrap">Ȩ������ &apos;��������&apos; ���� &apos;�����PIN��ȣ&apos; 6�ڸ��� ����Ͻø� ���� ���� �α����� ���� �մϴ�.</p>
<%} %>
    </card>
</wml>

