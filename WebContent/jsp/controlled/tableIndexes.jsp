<%@ include file="/jsp/inc/definitions.inc" %>
<% 
   String tablename = (String)request.getAttribute(PublicLabel.TABLENAME);
   if (tablename == null) {
       tablename = request.getParameter(PublicLabel.TABLENAME);
   }
   Integer indexesCount = (Integer)request.getAttribute("indexesCount");
   String display = (String)request.getParameter("display");  
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/basic.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
<link rel="stylesheet" type="text/css" href="<%=stylePath%>/sortabletable.css">
<link type="text/css" rel=stylesheet href="<%=contextPath%>/styles/dhtmlwindow.css">
<script type="text/javascript" src="<%=contextPath%>/scripts/dhtmlwindow.js"></script>
<script type="text/javascript" src="<%=contextPath%>/scripts/common.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/prototype.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/scrollabletable.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/sortabletable.js"></script>
<%=PublicAPI.licenseExpired(contextPath) %>
<title><%=tablename%> - Table Indexes</title>
</head>
<% if (Boolean.valueOf((String)session.getAttribute(PublicLabel.LICENSE_EXPIRED)).booleanValue()) {
	   out.println("<body onload='stopProcessing();licenseExpiredWindow();'>");
   } else {
       out.println("<body onload='stopProcessing();'>");
   }
%>
<center>
<p>
<% if (Boolean.valueOf(display).booleanValue()) { 
       out.println("<table style=\"border:0px;height:12px\"><tr><td></td></tr></table>");
       out.println(PublicAPI.menu(contextPath, tablename, "", connId, browser, db_name));
   } else {
	   out.println(PublicAPI.processingDiv(imagePath));
   }
   out.println(PublicAPI.printTitle(display, tablename, "Table Indexes"));
%> 
<form>
<input type=hidden name=tablename value=<%=tablename%>>
<table style="border:0px">
<tr>
<td>Number of Indexes: <span id="countContainer"><%=indexesCount.intValue()%></span></td>
</tr>
<tr><td>
<% if (indexesCount== null || indexesCount.intValue() == 0) { %>
<table class="greyTable"><tr><td>
The table does NOT have any index..
</td></tr></table>
<p>
<% } else { %>
<div id="tableContainer"><%=(String)request.getAttribute("data")%></div>
<% } %>
</td></tr>
</table>
</form>
<p>
<table style="border:0px;width:760px">
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
function indexTypeWindow() {
	var typewin=dhtmlwindow.open('indexbox', 'iframe', '<%=jspPath%>/index_type.jsp', 'Table Index Types', 'width=700px,height=200px,resize=1,scrolling=1,center=0', 'blue');
}
var t = new SortableTable(document.getElementById('content'));
</script>
</html>
