<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
%>
<%@ include file="../include/anybuilder.jsp"%>
<html>
    <head>
    <title>��ȯ����û��</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>��ȯ����û��</center></div>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%
	Member member = (Member) request.getAttribute("Member");
%>
�г��� : <%=member.getNickName()%>��<br>
�ܰ� : <%=XwinUtil.comma3(member.getBalance())%>
            <div><input type="hidden" name="mode" value="moneyOutRequest" /></div>
        <btn name="����" href="index.jsp">
    </body>
</html>

