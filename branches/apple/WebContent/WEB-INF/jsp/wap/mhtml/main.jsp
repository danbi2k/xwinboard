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
    <title>��Apple��</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>��Apple��</center></div>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
        <div>----------------</div>
        <div><br/>
        �� �¹���/�ڵ�ĸ���� ������ ���ô� ȸ������ ����� �޴��� �̿� ��Ź�帳�ϴ�.</div>
    </body>
</html>

