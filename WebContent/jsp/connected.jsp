<%@ include file="/jsp/inc/definitions.inc" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'connected.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <script>
		function showConnTab() {
		   //window.parent.showConn(argUserId,argName,argConnUrl,argConnId);
		   if (window.parent.showConn) {
		       window.parent.showConn('<c:out value="${requestScope.userId}" />',
		                              '<c:out value="${requestScope.connName}" />',
		                              '<c:out value="${requestScope.connURL}" />',
		                              '<c:out value="${requestScope.connId}" />');
		   }
           //document.location.href='<%=contextPath%>/welcome.html';
           document.location.href='<%=jspPath%>/controlled/table_list.jsp?connId=<c:out value="${requestScope.connId}" />&db_name=<c:out value="${requestScope.connName}" />&welcome=true';
		   return false;
		}
   	</script>
  </head>
  <body onLoad='showConnTab()'>
  </body>
</html>
