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
    <title>��ȯ����û��</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>��ȯ����û��</center></div>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
        <div>----------------</div>
            <div><input type="hidden" name="mode" value="moneyOutRequest" /></div>
        <btn name="����" href="main.wap?token=<%=token%>">
    </body>
</html>

