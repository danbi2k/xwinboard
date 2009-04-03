<%@ include file="/jsp/inc/definitions.inc" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<% 
   Integer count = (Integer)request.getAttribute("count"); 
   String procedureName = (String)request.getAttribute("procedureName"); 
   String pattern = request.getParameter("pattern");
   String schema  = request.getParameter("schema");
   String catalog  = request.getParameter("catalog");
   String requestURI = "/action/ProcedureDetails?connId="+connId+"&db_name="+db_name+"&pattern="+pattern+"&schema="+schema+"&catalog="+catalog;
%>
<html>
<head>
<title>Stored Procedure Details</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel="stylesheet" type="text/css" href="<%=stylePath%>/basic.css">
<link rel="stylesheet" type="text/css" href="<%=stylePath%>/sortabletable.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
<link type="text/css" rel=stylesheet href="<%=contextPath%>/styles/dhtmlwindow.css">
<script type="text/javascript" src="<%=scriptPath%>/common.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/prototype.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/scrollabletable.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/sortabletable.js"></script>
<script type="text/javascript" src="<%=contextPath%>/scripts/dhtmlwindow.js"></script>
</head>
<body>
<center>
<table style="border:0px;height:15px"><tr><td></td></tr></table>
<table style="border:0px;width:755px">
<tr>
<td style="vertical-align:bottom;text-align:left">Database: <span class=mainDB><%=db_name%></span></td>
<td style="text-align:right"><span class=mainTitle>Stored Procedure Details</span></td>
</tr>
<tr><td>&nbsp;</td></tr>
</table>
<form>
<table style="border:0px">
<tr>
<td>Procedure Name: <span class=mainDB><%=procedureName%></span></td>
<td style="text-align:right">
Number of Columns: <span id="countContainer"><%=count.intValue()%></span>
</td>
</tr>
<tr><td colspan=2>
<% if (count == null || count.intValue() == 0) { %>
<table class="greyTable"><tr><td>
No column found for the stored procedure.
</td></tr></table>
<% } else { %>
<div id="tableContainer"><%=(String)request.getAttribute("data")%></div>
<% } %>
</td></tr>
</table>
</form>
<p>
<table style="border:0px;width:748px">
<td align=left>
<div id="actcontainer">
<ul id="navlist">
<li><a href="javascript:window.history.back();" title="Back to previous page">&nbsp;<<&nbsp;Back&nbsp;&nbsp;</a></li>
 </ul>
 </div>
 &nbsp;&nbsp;&nbsp;&nbsp;
 </td>
<td><%=PublicAPI.copyrightStr0()%></td>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr></table>
</center>
</body>
<%=PublicAPI.mainMenuJavaScript(contextPath)%>
<%=PublicAPI.closeTWAJavaScript(contextPath)%>
<script type="text/javascript">
var t = new SortableTable(document.getElementById('content'));
</script>
</html>