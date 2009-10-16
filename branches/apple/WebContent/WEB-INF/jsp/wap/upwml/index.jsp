<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/vnd.wap.wml;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");
%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE wml PUBLIC "-//PHONE.COM//DTD WML 1.1//EN" "http://www.phone.com/dtd/wml11.dtd">
<!--Web Logic 웹서버에서 한글이 깨진다면 DOCTYPE 라인을 삭제해 보세요.-->
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
        <p mode="wrap">모바일서비스를 이용하시려면 홈페이지 &apos;정보수정&apos; 에서 &apos;모바일PIN번호&apos; 6자리를 등록하셔야 합니다.</p>
<%} %>
        <do type="accept" label="확인" name="VX"><go href=""/></do>
    </card>
</wml>

