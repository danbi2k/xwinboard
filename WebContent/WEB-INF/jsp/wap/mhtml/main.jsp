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
    <title>��<%=SiteConfig.SITE_NICKNAME%>��</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center><a href>��<%=SiteConfig.SITE_NICKNAME%>��</a></center></div>
        <div>�г��� :&nbsp;<%=member.getNickName()%>&nbsp;��<br/>
        �ܰ� :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;��</div>
        <div>----------------</div>
        <div><br/>
        �� �ֽ����� �̿��Ͻô� ȸ������ �¹���/�ڵ�ĸ �ֽ��� �޴��� Ȱ���Ͻø� ���� ������ �����ϽǼ� �ֽ��ϴ�.</div>
    </body>
</html>

