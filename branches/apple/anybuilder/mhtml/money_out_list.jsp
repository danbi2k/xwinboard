<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page language="java" import="java.io.*,java.util.*,java.net.*,java.sql.*"%>
<%
    response.setHeader("Pragma","no-cache");
%>
<%@ include file="../include/anybuilder.jsp"%>
<html>
    <head>
    <title>��ȯ��������</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>��ȯ��������</center></div>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>
<%
	Member member = (Member) request.getAttribute("Member");
%>
�г��� : <%=member.getNickName()%>��<br>
�ܰ� : <%=XwinUtil.comma3(member.getBalance())%>
<%
	List<MoneyOut> moneyOutList = (List<MoneyOut>) request.getAttribute("moneyOutList");
%>
<%%>
        <div>��û��¥</div>
        <div><%=moneyOut.getReqDateStr()%></div>
        <div>���¹�ȣ</div>
        <div>[<%=moneyOut.getBankName()%>]&nbsp;<%=moneyOut.getNumber()%>&nbsp;<%=moneyOut.getName()%></div>
        <div>ȯ���ݾ�</div>
        <div><%=XwinUtil.comma3(moneyOut.getMoney())%></div>
        <div>����</div>
        <div><%=Code.getValue(moneyOut.getStatus())%></div>
        <div>ȯ����¥</div>
        <div><%=moneyOut.getProcDateStr()%></div>
<%%>
        <btn name="����" href="index.jsp">
    </body>
</html>

