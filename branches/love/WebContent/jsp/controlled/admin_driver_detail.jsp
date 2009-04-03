<%@ include file="/jsp/inc/admin_definitions.inc" %>
<% 
   String driver_id = request.getParameter("id");
%>
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/basic.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
<style>
      body {
        margin:30px 0px 0px 0px;
     } 
</style>
<TITLE>DB Cruiser Administration -- JDBC Driver Detail</TITLE>
<SCRIPT Language="JavaScript" SRC="<%=jspPath%>scripts/common.js"></SCRIPT>
</HEAD>
<BODY background="<%=imagePath%>/<%=info.get("admin_bg")%>"><CENTER>
<%@ include file="/jsp/inc/admin_menu.inc" %>
<p>
<span class="adminTitle">JDBC Driver Details</span>
<p>
<FORM NAME=driver_detail METHOD=POST ACTION="<%=(contextPath)%>ControlServlet">
<INPUT TYPE="hidden" NAME="controller" value="AdminLogout">
<div style='text-align:left;width:720px;padding:15px 10px 15px 20px;margin:20px 0px 10px 0px;border:1px dotted #483D8B;background-color:#F0F8FF;'>
<table style="width:700px;border:none" CELLPADDING=2 CELLSPACING=0 >
<% ArrayList driverList = info.getDrivers();
   for (Iterator iter = driverList.iterator(); iter.hasNext();) {
        DriverItem driverInfo = (DriverItem)iter.next();
		if (driverInfo.getId().equals(driver_id)) {
%>
        <tr>
		<td width=150><FONT COLOR=navy><B>Driver Name</B></td>
	    <td><nobr><FONT FACE=Arial COLOR="navy"><%=driverInfo.getName()%></FONT></nobr></td>
	    </tr><tr>
        <td><FONT COLOR=navy><B>Driver Class</B></FONT></td>
	    <td><FONT FACE=Arial COLOR="navy"><%=driverInfo.getDriverClass()%></FONT></td>
		</tr><tr>
	    <td><FONT COLOR=navy><B>Base URL</B></FONT></td>
	    <td><FONT FACE=Arial COLOR="navy"><%=driverInfo.getBaseUrl()%></FONT></td>
        </tr><tr>
	    <td><FONT COLOR=navy><B>Database Product</B></FONT></td>
	    <td><FONT FACE=Arial COLOR="navy"><%=(String)driverInfo.getProduct()%></FONT></td>
        </tr>
	
<%         break;
       }
   }
%>
</table>
</div>
<p>
<table style="border:0px;width:auto;">
<tr><td><nobr>
<div id="navcontainer">
<ul id="navlist">
<li><a href="javascript:window.history.back();" title="Back to previous page">&nbsp;&nbsp;&nbsp;&nbsp;&lt;&lt;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a href="javascript:document.location.reload();" title="Refesh the page.">&nbsp;&nbsp;&nbsp;&nbsp;Refresh&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
</ul>
</div> 
</nobr></td></tr>
</table>
</FORM>
<table style="border:0px;height:50px;"><tr><td>&nbsp;</td></tr></table>
<table style="border:0px;width:748px">
<td><%=PublicAPI.copyrightStr0()%></td>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr></table>
</CENTER></BODY>
</HTML>
<SCRIPT LANGUAGE="JavaScript">
<!--
function logout() {
	document.driver_detail.controller.value = "AdminLogout";
	document.driver_detail.submit();
	window.close();
}
//-->
</SCRIPT>