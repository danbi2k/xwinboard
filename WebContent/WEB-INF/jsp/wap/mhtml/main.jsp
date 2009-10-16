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
    <title>¡¼Apple¡½</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>¡¼Apple¡½</center></div>
        <div>´Ð³×ÀÓ :&nbsp;<%=member.getNickName()%>&nbsp;´Ô<br/>
        ÀÜ°í :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;¿ø</div>
        <div>----------------</div>
    </body>
</html>

