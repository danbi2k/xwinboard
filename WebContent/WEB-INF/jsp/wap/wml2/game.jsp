<%@ include file="../include/top.jsp"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
    String token = request.getParameter("token") == null ? "" : request.getParameter("token");

%>
<%@ include file="../include/anybuilder.jsp"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/wml20.dtd">
<html>
    <head>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body id ="card1">
        <div>���� �غ����Դϴ�.</div>
        <wml:do type="vnd.up" label="����"><wml:go href="main.wap?token=<%=token%>"/></wml:do>
    </body>
</html>

