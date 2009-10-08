<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
%>
<%@ include file="../include/anybuilder.jsp"%>
<html>
    <head>
    <title>¡¼Apple¡½</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>¡¼Apple¡½</center></div>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%
	Member member = (Member) request.getAttribute("Member");
%>
´Ð³×ÀÓ : <%=member.getNickName()%>´Ô<br>
ÀÜ°í : <%=XwinUtil.comma3(member.getBalance())%>
        <btn name="»óÀ§" href="index.jsp">
    </body>
</html>

