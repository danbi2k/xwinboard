<%@ include file="/jsp/inc/admin_definitions.inc" %>
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/fk.css>
<style>
 body {
   margin:50px 0px 0px 0px;
 }
</style>
<TITLE>DB Cruiser Administration - Menu</TITLE>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>

</HEAD>
<BODY background="<%=imagePath%>/<%=info.get("admin_bg")%>" alink=navy vlink=navy link=navy><CENTER>
<form NAME="menu_form"
      METHOD="POST"
      ACTION="<%=contextPath%>/action/AdminLogout"
      ENCTYPE="x-www-form-encoded">
<INPUT TYPE="hidden" NAME="controller" value="AdminLogout">
<img src=<%=imagePath%>/dbcruiser_admin.gif border=0>
<table border=0 height=30><tr><td>&nbsp;</td></tr></table>
<span class="adminTitle">Main Menu</span>
<p>
<table border=1 width=620 CELLPADDING=5 CELLSPACING=0>
<tr align=center>
<td><a class="mainmenu" href="<%=contextPath%>/jsp/controlled/admin_user_list.jsp"><font face=Arial>Monitor Active Connections</font></a></td>
<td><a class="mainmenu"href=<%=contextPath%>/jsp/controlled/admin_connection_list.jsp><font face=Arial>Manage Connection List</font></a></td>
</tr><tr align=center>
<td width=50%><a class="mainmenu" href=<%=contextPath%>/jsp/controlled/admin_server_config.jsp><font face=Arial>Edit Global Configuration</font></a></td>
<td><a class="mainmenu" href="<%=contextPath%>/action/AdminServerInfo"><font face=Arial>View Server Information</font></a></td>
</tr><tr align=center>
<td><a class="mainmenu" href="javascript:exportConfig();"><font face=Arial>Export Configuration</font></a></td>
<td><a class="mainmenu" href="<%=contextPath%>/jsp/controlled/admin_import_config.jsp"><font face=Arial>Import Configuration</font></a></td>
</tr><tr  align=center>
<td><a class="mainmenu" href=<%=contextPath%>/jsp/controlled/admin_driver_list.jsp><font face=Arial>View JDBC Driver List</font></a></td>
<td><a class="mainmenu" href="<%=contextPath%>/jsp/controlled/admin_view_logfile.jsp"><font face=Arial>View DB Cruiser Log File</font></a></td>
</tr>
</table>
<p>
<table border=0>
<tr><td>
<div id="navcontainer">
<ul id="navlist">
<li><a href="javascript:logout();" title="Logoff DB Cruiser Administration">&nbsp;&nbsp;&nbsp;Logout&nbsp;&nbsp;&nbsp;</a></li>
</ul>
</div> 
</td></tr>
</table>
<table border=0 height=60><tr><td>&nbsp;</td></tr></table>
<table style="border:0px;width:600px">
<td><%=PublicAPI.copyrightStr0()%></td>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr></table>
</BODY>
</HTML>
<SCRIPT LANGUAGE="JavaScript">
function logout() {
	document.menu_form.submit();
	window.close();
}
function exportConfig() {
	alert("Admin panel userid/password will be reset to 'admin/password' in exported file");
	window.location = "<%=actionPath%>/AdminExportConfigFile";
}
function viewLogFile() {
var width = 730;
var winl = (screen.width - width) / 2; 
	openPopup2("<%=contextPath%>/ControlServlet?controller=OpenFile&type=log", "log_file", width, 500, 0, winl);
}
function viewUserList() {
var width = 780;
var winl = (screen.width - width) / 2; 
	openPopup2("<%=contextPath%>/ControlServlet?controller=UserList", "user_list", width, 500, 0, winl);
}
</SCRIPT>
