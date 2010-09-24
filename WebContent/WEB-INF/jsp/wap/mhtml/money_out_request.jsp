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
    <title>【환전신청】</title>
        <meta name="generator" content="AnyBuilder VX" />
    </head>
    <body>
        <div><center>【환전신청】</center></div>
        <div>닉네임 :&nbsp;<%=member.getNickName()%>&nbsp;님<br/>
        잔고 :&nbsp;<%=XwinUtil.comma3(member.getBalance())%>&nbsp;원</div>
        <div>----------------</div>
            <div><input type="hidden" name="mode" value="moneyOutRequest" /></div>
        <btn name="상위" href="main.wap?token=<%=token%>">
    </body>
</html>

