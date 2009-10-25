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
        <p mode="wrap"><%=adhocMember.getNickName()%>님 환영합니다!</p>
<%
String pin = adhocMember.getPin();
if (StringUtils.isNumeric(pin) && pin.length() == 6) {
%>
<%}  else {%>
        <p mode="wrap">홈페이지 &apos;정보수정&apos; 에서 &apos;모바일PIN번호&apos; 6자리를 등록하시면 보다 쉽게 로그인이 가능 합니다.</p>
<%} %>
    </card>
</wml>

