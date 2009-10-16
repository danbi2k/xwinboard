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
        <div>서비스 준비중입니다.</div>
        <btn name="상위" href="main.wap?token=<%=token%>">
    </body>
</html>

