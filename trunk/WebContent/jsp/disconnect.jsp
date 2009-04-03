<%@ include file="/jsp/inc/definitions.inc" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    
    <title>My JSP 'disconnect.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <script>
		function closeConnTab() {
		   if (window.top.closeConnById) {
		       window.top.closeConnById('<%=request.getParameter("connId")%>');
		   }
           document.location.href='<%=contextPath%>/disconnected.html';
		   return false;
		}
   	</script>
  </head>
  
  <body onLoad='closeConnTab()'>
    <a href='#' onclick="return showConnTab('<c:out value="${requestScope.userId}" />', '<c:out value="${requestScope.connName}" />', '<c:out value="${requestScope.connURL}" />', '<c:out value="${requestScope.connId}" />')" class='quickLink'>closed</a>
  </body>
</html>
