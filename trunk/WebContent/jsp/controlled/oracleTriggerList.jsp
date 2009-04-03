<%@ include file="/jsp/inc/definitions.inc" %>
<html>
<head>
<title>Oracle Trigger List</title>
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
<%=PublicAPI.licenseExpired(contextPath) %>
</head>
<% if (Boolean.valueOf((String)session.getAttribute(PublicLabel.LICENSE_EXPIRED)).booleanValue()) {
	   out.println("<body onload=\"licenseExpiredWindow();getContent();\">");
   } else {
       out.println("<body onload=\"getContent()\">");
   }
%>
<center>
<table style="border:0px;height:15px"><tr><td></td></tr></table>
<table style="border:0px;width:748px">
<tr>
<td style="vertical-align:bottom">Database: <span class=mainDB><%=db_name%></span></td>
<td style="text-align:right;width:400px"><span class=mainTitle>Triggers</span></td>
</tr>
<tr><td>&nbsp;</td></tr>
</table>
<form>
<table style="border:0px;width:748px;"><tr>
<td>Number of Triggers: <span id="countContainer"></span></td>
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
function getTable(url) {
	window.location = getFullURL(url);
}
function getFullURL(url) {
	var prefix =  url+"&connId=<%=connId%>&db_name="+escape('<%=db_name%>');
	return prefix;
}
function popUpWin(url, name, width, height, top, left) {
	      // alert(url);
	       var winProperty = 'resizable=1,scrollbars=1,titlebar=yes,menubar=no,toolbar=no,location=no'
	                         + ',width='+width+',height='+height+',top='+top+',left='+left;
	      // var prefix =  '"+req.getContextPath()+Label.ACTION_PREFIX+ClassName.TABLE_COLUMN_DEFINITION+"?connId="+connId+"&db_name="+db_name+"&tablename=';
	       var mark = '<%=connId%>';
	       var newname = escape(name);
	      open(getFullURL(url),mark+newname,winProperty);
}
function getContent(action) {
    var now = new Date();
    var myAjax = new Ajax.Updater('tableContainer', '<%=actionPath%>/OracleTriggers?id='+now+'&connId=<%=connId%>&db_name=<%=db_name%>', { method: 'get', asynchronous: false});
    var t = new SortableTable(document.getElementById('content'));
    <% if (browser != null && (browser.toUpperCase().indexOf("MSIE") > 0 || browser.toUpperCase().indexOf("FIREFOX") > 0)) { %>
           var t = new ScrollableTable(document.getElementById('content'), 400, 730);
    <% } %>
    var myCountAjax = new Ajax.Updater('countContainer', '<%=actionPath%>/ListCount?name=oracleTriggersCount&id='+now, { method: 'get'});
}
//-->
</script>
</html>
