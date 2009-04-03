<%@ include file="/jsp/inc/definitions.inc" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 
<html>
  <head>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0"> 
    <title>My JSP 'admin_server_info.jsp' starting page</title>
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/basic.css">
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/fk.css">
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
  </head>
  
  <BODY><CENTER>
<table style="border:0px;height:15px"><tr><td></td></tr></table>
<table style="border:0px;width:748px">
<tr>
<td style="vertical-align:bottom">&nbsp; <span class=mainDB>&nbsp;</span></td>
<td style="text-align:right"><span class=mainTitle>Request Information</span></td>
</tr>
<tr><td>&nbsp;</td></tr>
</table>
    <%=(String)request.getAttribute("content")%>
<p>
<table style="border:0px;width:748px">
<tr>
<td align=left>
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
