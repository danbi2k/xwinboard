<%@ include file="/jsp/inc/admin_definitions.inc" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 
<html>
  <head>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0"> 
    <title>DB Cruiser Administration - Server Information</title>
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/basic.css">
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
  </head>
  
  <body background="<%=imagePath%>/<%=info.get("admin_bg")%>"><CENTER>
<%@ include file="/jsp/inc/admin_menu.inc" %>
<p>
<span class="adminTitle"><c:out value="${requestScope.title}" /></span>
<p>
    <%=(String)request.getAttribute("content")%>
<p>
<table style="border:0px;width:748px">
<td align="left">
<div id="actcontainer">
<ul id="navlist">
<li><a href="javascript:window.history.back();" title="Back to previous page">&nbsp;&lt;&lt;&nbsp;Back&nbsp;&nbsp;</a></li>
 </ul>
 </div>
 &nbsp;&nbsp;&nbsp;&nbsp;
 </td>
<td><%=PublicAPI.copyrightStr0()%></td>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr></table>
    </CENTER>
  </body>
</html>
