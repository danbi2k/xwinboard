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
    <title>【알림】</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>【알림】</center></div>
<%
	ResultWap rw = (ResultWap) request.getAttribute("resultWap");
	if (rw == null)
		rw = ResultWap.FAILURE;
%>
        <div><%=rw.getMessage()%></div>
        <btn name="상위" href="<%=rw.getReturnUrl()%>">
    </body>
</html>

