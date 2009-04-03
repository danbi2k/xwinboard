<%@ page language="java" import="java.io.*,com.maththinking.dbcruiser.*" pageEncoding="ISO-8859-1" isErrorPage="true" %>
<%
String contextPath = request.getContextPath();
session.setAttribute(PublicLabel.ADMIN_PAGE, PublicPage.ADMIN_MENU);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>DB Cruiser Administration Error</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
    <link rel=stylesheet href=<%=contextPath%>/styles/admin.css>
    <SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>

  </head>
  
  <body>
    <h2>DB Cruiser Administration Error</h2>
    <TABLE>
    <tr><td>&nbsp;</td></tr>
    <tr><td><b>Exception Class:</b></td></tr>
    <tr><td><%= exception.getClass() %></td></tr>
  <tr><td>&nbsp;</td></tr>

   <tr><td><b>Exception Message:</b></td></tr>
   <tr><td><%= exception.getMessage() %></td></tr>

    <tr><td>&nbsp;</td></tr>

   <tr><td><b>Exception Details:</b></td></tr>
   <tr><td><pre><% exception.printStackTrace(new PrintWriter(out)); %></pre></td></tr>
  

</TABLE>

  </body>
</html>
