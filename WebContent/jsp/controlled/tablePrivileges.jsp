<%@ include file="/jsp/inc/definitions.inc" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<% 
   String tablename = (String)request.getAttribute(PublicLabel.TABLENAME);
   if (tablename == null) {
       tablename = request.getParameter(PublicLabel.TABLENAME);
   }
   String userid = (String)request.getAttribute("userId");
   //System.out.println("TABLE="+tablename);
   Integer count = (Integer)request.getAttribute("count");
   //request.setAttribute("privilegeList", privilegeList);
   String display = (String)request.getParameter("display");  
   String requestURI = "/action/TablePrivileges?tablename="+tablename;
%>
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/basic.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
<link type="text/css" rel=stylesheet href="<%=contextPath%>/styles/dhtmlwindow.css">
<link rel="stylesheet" type="text/css" href="<%=stylePath%>/sortabletable.css">
<script type="text/javascript" src="<%=contextPath%>/scripts/dhtmlwindow.js"></script>
<script type="text/javascript" src="<%=contextPath%>/scripts/common.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/prototype.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/scrollabletable.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/sortabletable.js"></script>
<%=PublicAPI.licenseExpired(contextPath) %>
<TITLE><%=tablename%> - Table Privileges</TITLE>
</HEAD>
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
   out.println(PublicAPI.printTitle(display, tablename, "Table Privileges"));
%> 
<form>
<input type=hidden name=tablename value=<%=tablename%>>
<table style="border:0px">
<tr><td style="color:green">
<% if (count == null || count.intValue() == 0) { %>
From the user <span style="color:#00008B;font-weight:bold"><%=userid%></span>'s point of view, the table owner didn't not grant any privilege explicitly or indirectly.
<% } else { %>
The table owner granted the following privilege(s) explicitly or indirectly.
<% } %>
The user <span style="color:#00008B;font-weight:bold"><%=userid%></span> may still have other privileges by default, or given implicitly.
</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>Number of Privilege Granted: <span id="countContainer"><%=count.intValue()%></span></td></tr>
<% if (count != null && count.intValue() > 0) { %>
<tr><td align=center>
<div id="tableContainer"><%=(String)request.getAttribute("data")%></div>
</td></tr>
<% } %>
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
var t = new SortableTable(document.getElementById('content'));
</script>
</html>