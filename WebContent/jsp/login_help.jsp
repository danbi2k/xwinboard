<%@ include file="/jsp/inc/definitions.inc" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/admin.css>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
<TITLE>DB Cruiser Login Help</TITLE>
</HEAD>
<BODY bgcolor=#f0fff0><CENTER>
<FORM METHOD=POST ACTION="">
<span style="font-size:18px;font-weight:bold;color:#0000CC;">DB Cruiser Login Help</span>
<p>

<TABLE BORDER=0 WIDTH=95% CELLPADDING=2 CELLSPACING=0>
<TR><TD colspan=3 valign=top>
There are three (3) ways to connect to a database via DB Cruiser:
</TD></TR>
<TR><TD colspan=3 valign=top>&nbsp;</TD></TR>
<TR>
<TD valign=top>
<img src=<%=imagePath%>/bluebox.gif>
</TD>
<TD colspan=2 valign=top> Connect to databases on the list.
</TD></TR>
<TR>
<TD valign=top>&nbsp;</TD>
<TD valign=top><img src=<%=imagePath%>/greenball.gif></TD>
<TD colspan=2 valign=top>
Scroll down to find your connection, then select it (<font FACE="Arial" color="#A0522D"><b>Connect to selected database</b></font> radio button will be selected)
</TD>
</TR>
<TR>
<TD valign=top>&nbsp;</TD>
<TD valign=top><img src=<%=imagePath%>/greenball.gif></TD>
<TD valign=top>
Type in the userid and password (optional).
</TD>
</TR>
<TR>
<TD valign=top>&nbsp;</TD>
<TD valign=top><img src=<%=imagePath%>/greenball.gif></TD>
<TD valign=top>
Hit Enter or Return key, or click Connect button.
</TD>
</TR>
<TR>
<TD valign=top>&nbsp;</TD>
<TD colspan=2 valign=top><B>Note:</B>
</TD>
</TR>
<TR>
<TD valign=top>&nbsp;</TD>
<TD colspan=2 valign=top>
<TABLE BORDER=0 CELLPADDING=2 CELLSPACING=0>
<TR>
<TD valign=top>(1)</TD>
<TD valign=top>
When a connection is selected, the detail of the connection (the URL and the JDBC driver) will be populated on the "Use the following information to connect" box below, in green color.
</TD>
</TR>
<TR>
<TD valign=top>(2)</TD>
<TD valign=top>
You may add, delete or modify connections from the list via <a href="<%=contextPath%>/jsp/admin_login.jsp" target=_self>DB Cruiser Administration</a>, 
which is accessible by clicking Admin menu on top right corner of the main window. Any database product with JDBC 2.0 or later version drivers can be be added into the list.
</TD>
</TR>
<TR>
<TD valign=top>(3)</TD>
<TD valign=top>
If you can not find your connection from the list, use one of the two ways described below.
</TD>
</TR>
</TABLE>

</TD>
</TR>
<TR><TD colspan=3 valign=top>&nbsp;</TD></TR>
<TR>
<TD valign=top>
<img src=<%=imagePath%>/bluebox.gif>
</TD>
<TD colspan=2 valign=top>
Specify a connection URL and a JDBC driver to connect.
</TD>
</TR>
<TR>
<TD valign=top>&nbsp;</TD>
<TD colspan=2 valign=top>
If your connection is not on the list, you can connect to the database directly by specifying a connection URL and a JDBC drive. More specifically:
</TD>
</TR>
<TR>
<TD valign=top>&nbsp;</TD>
<TD valign=top><img src=<%=imagePath%>/greenball.gif></TD>
<TD valign=top>
Enter a connection URL (<font FACE="Arial" color="#A0522D"><b>Use the following information to connect</b></font> radio button will be selected automatically)
</TD>
</TR>
<TR>
<TD valign=top>&nbsp;</TD>
<TD valign=top><img src=<%=imagePath%>/greenball.gif></TD>
<TD valign=top>
Enter a JDBC driver.
</TD>
</TR>
<TR>
<TD valign=top>&nbsp;</TD>
<TD valign=top><img src=<%=imagePath%>/greenball.gif></TD>
<TD valign=top>
Enter a database name or a short description.
</TD>
</TR>
<TR>
<TD valign=top>&nbsp;</TD>
<TD colspan=2 valign=top><B>Tip:</B>
</TD>
</TR>
<TR>
<TD valign=top>&nbsp;</TD>
<TD colspan=2 valign=top>
<TABLE BORDER=0 CELLPADDING=2 CELLSPACING=0>
<TR>
<TD valign=top>(1)</TD>
<TD valign=top>
Select a connection to the same database product (like ORACLE&#174;, Sybase&#174;, DB2&#174;, MySQL&#174;, etc.) from the list, the detail of the connection will be populated in green color.
</TD>
</TR>
<TR>
<TD valign=top>(2)</TD>
<TD valign=top>
Modify the populated connection URL (in green), usually the hostname, the port number and the database name, as well as the short name/descripton.
</TD>
</TR>
<TR>
<TD valign=top>(3)</TD>
<TD valign=top>
If no connection of the same database product found in the list, try to find the JDBC driver class and connection URL for your database product 
<a href="http://www.maththinking.com/resourceDriver.html" target="_blank"><span style="color:#0000FF;">here</span></a>. 
</TD>
</TR>
</TABLE>

</TD>
</TR>
<TR><TD colspan=3 valign=top>&nbsp;</TD></TR>
<TR>
<TD valign=top>
<img src=<%=imagePath%>/bluebox.gif>
</TD>
<TD colspan=2 valign=top>
Choose a database product and a JDBC driver to connect.
</TD>
</TR>
<TR>
<TD valign=top>&nbsp;</TD>
<TD colspan=2 valign=top>
If your connection is not on the list, and you don't know how to construct the connection URL, you can still connect to it 
by choosing a database product and a JDBC driver, as well as providing other additional information:
</TD>
</TR>
<!-- 
<TR>
<TD valign=top>&nbsp;</TD>
<TD valign=top><img src=<%=imagePath%>/greenball.gif></TD>
<TD valign=top>
Check <font FACE="Arial" color="#0000CC"><b>Choose a database product and a JDBC driver to connect</b></font> radio button.
</TD>
</TR>
-->
<TR>
<TD valign=top>&nbsp;</TD>
<TD valign=top><img src=<%=imagePath%>/greenball.gif></TD>
<TD>
Provide the following information:
</TD>
<TR>
<TD colspan=2 valign=top>&nbsp;</TD>
<TD>

<TABLE style="border:1px solid navy">
<TR>
<TD valign=top>
<B>Database Name</B>: 
</TD><TD valign=top>
The name of the database. For example, testdb.
</TD>
</TR>
<TR>
<TD valign=top><B>Port Number</B>: 
</TD><TD valign=top>
The port of the database server listening to. (For example, the default port number for Oracle is 1521).
</TD>
</TR>
<TR>
<TD valign=top><nobr><B>Database Hostname</B>:</nobr> 
</TD><TD valign=top>The hostname or IP address of the database server machine.
</TD>
</TR>
<TR>
<TD valign=top><B>Database Product</B>: 
</TD><TD valign=top>Choose the database product from the drop-down list
</TD>
</TR>
<TR>
<TD valign=top><B>JDBC Driver</B>: 
</TD><TD valign=top>Choose an appropriate JDBC driver from the drop-down list
</TD>
</TR>
</TABLE>
</TD></TR>
<TR><TD colspan=3 valign=top>&nbsp;</TD></TR>
<TR><TD colspan=3 valign=top>
<table width=100% border=0>
<tr>
<td><%=PublicAPI.copyrightStr0()%></td>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr>
</table>
</TD></TR>
</TABLE>
</CENTER></BODY>
</HTML>
<SCRIPT LANGUAGE="JavaScript">
<!--
function adminWindow() {
	var width = 730;
	var winl = (screen.width - width) / 2;
	openPopup2("admin_login.jsp", "admin_panel", width, 550, 0, winl);
}
//-->
</SCRIPT>
