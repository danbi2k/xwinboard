<%@ include file="/jsp/inc/definitions.inc" %>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>scripts/common.js"></SCRIPT>
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/introduction.css>
<title>Find table definitions of databases</title>
</head>
<body OnLoad="stopProcessing();">
<center>
<table border=0 width=660>
<tr><td colspan=2>&nbsp;</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="30" align="left" valign="top">
<font color=navy>
Select a Schema or Catalog, the select a table in the "<font color="#0000A0">Table</font>" list above.
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="30" align="left" valign="top">
<font color=navy>
Click an appropriate action button to get the information you want about the table.
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="45" align="left" valign="top">
Click <font color="#0000A0"><b>SQL</b></font> 
<font color=navy>
 button will launch a <font color="#0000A0"><b>SQL Work Sheet</b></font> asscociated with the table: it displays SQL statements related to the table.
 Furthermore, you may execute any SELECT statements in a SQL Work Sheet.
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="30" align="left" valign="top">
Click <font color="#0000A0"><b>Query Builder</b></font> 
<font color=navy>
 button will launch a GUI letting you build SELECT statements graphically..
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="90" align="left" valign="top">
<font color="#0000A0"><b>View Table</b></font> 
<font color=navy>
 button let you look a table quickly, but it may not be appropriate for tables of large sizes. If you are not sure of the table size, please click <font color="#0000A0"><b>Row Count</b></font> button to get the size first. 
</font>
<p>
 <font color=navy>
 For tables of large sizes, you may use <font color="#0000A0"><b>Column Definitions</b></font>, <font color="#0000A0"><b>Query Builder</b></font>, <font color="#0000A0"><b>SQL Work Area</b></font> (see left-hand menu), or <font color="#0000A0"><b>SQL Work Sheet</b></font> to view the columns or rows you want, instead of viewing the whole table.
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="50" align="left" valign="top">
<font color=navy>
This <font color="#0000A0">Browse Tables</font> panel has the same functionality as <B>Table Work Area</B>. The difference is: there will be no pops up windows. 
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="50" align="left" valign="top">
<font color=navy>
<font color=crimson><b>Note:</b></font> 
You may always get the latest query result for a particular table by clciking <B>Query Result</B> button. DB Cruiser memorizes all the latest query results.
</font>
</td></tr>
<tr><td colspan=2 align=center>
<%=PublicAPI.button("javascript:window.history.back();", "_self", "back_small", imagePath)%>
</td></tr>
</table>
<p>
<table border=0 width=650><tr>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr></table>
<%=PublicAPI.processingDiv(imagePath)%>
</center>
</body>
</html>
