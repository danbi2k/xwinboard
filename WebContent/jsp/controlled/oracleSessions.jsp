<%@ include file="/jsp/inc/definitions.inc" %>
<html>
<head>
<title>Current Database Sessions</title>
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
<body onload="getContent()">
<center>
<table style="border:0px;height:15px"><tr><td></td></tr></table>
<table style="border:0px;width:748px">
<tr>
<td style="vertical-align:bottom">Database: <span class=mainDB><%=db_name%></span></td>
<td style="text-align:right"><span class=mainTitle>Current Database Sessions</span></td>
</tr>
<tr><td>&nbsp;</td></tr>
</table>
<form>
<table style="border:0px">
<tr>
<td>Number of Sessions: <span id="countContainer"></span>.</td>
</tr>
<tr><td>
<div id="tableContainer" />
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
<script type="text/javascript">
<!--
function getContent(action) {
    var now = new Date();
    var myAjax = new Ajax.Updater('tableContainer', '<%=actionPath%>/OracleSessions?id='+now+'&connId=<%=connId%>&db_name=<%=db_name%>', { method: 'get', asynchronous: false});
    var t = new SortableTable(document.getElementById('content'));
    <% if (browser != null && (browser.toUpperCase().indexOf("MSIE") > 0 || browser.toUpperCase().indexOf("FIREFOX") > 0)) { %>
           var t = new ScrollableTable(document.getElementById('content'), 400, 730);
    <% } %>
    var myCountAjax = new Ajax.Updater('countContainer', '<%=actionPath%>/ListCount?name=oracleSessionsCount&id='+now, { method: 'get'});
}
//-->
</script>
</html>