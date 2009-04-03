<SCRIPT LANGUAGE="JavaScript">
function exportConfig() {
	alert("Admin panel userid/password will be reset to 'admin/password' in exported file");
	window.location = "<%=actionPath%>/AdminExportConfigFile";
}
</SCRIPT>
<img src="<%=contextPath%>/images/dbcruiser_admin.gif" border=0><br>
<nobr>
<a href='<%=contextPath%>/jsp/controlled/admin_user_list.jsp' target='site' style='color:#0000FF'>Active Connections</A>&nbsp;|
<a href='<%=contextPath%>/jsp/controlled/admin_connection_list.jsp' style='color:#0000FF'>Manage Connections</A> |
<a href='<%=contextPath%>/jsp/controlled/admin_server_config.jsp' style='color:#0000FF'>Global Configuration</A> |
<a href='<%=contextPath%>/action/AdminServerInfo' style='color:#0000FF'>Server Info</A> |
<a href='<%=contextPath%>/jsp/controlled/admin_driver_list.jsp' style='color:#0000FF'>Drivers</A> |
<a href='<%=contextPath%>/jsp/controlled/admin_view_logfile.jsp' style='color:#0000FF'>View Log</A> |
<A href='javascript:exportConfig();' style='color:#0000FF'>Export</A> |
<a href='<%=contextPath%>/jsp/controlled/admin_import_config.jsp' style='color:#0000FF'>Import</A> |&nbsp;
<a href='<%=contextPath%>/action/AdminLogout' style='color:#0000FF'>Logout</A>
</nobr>
<p>