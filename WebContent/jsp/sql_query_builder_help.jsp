<%@ include file="/jsp/inc/definitions.inc" %>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/introduction.css>
<title>Find table definitions of databases</title>
</head>
<body OnLoad="stopProcessing();">
<center>
<hr height=1 width=660>
<table border=0 width=660>
<tr><td colspan=2>&nbsp;</td></tr>
<tr><td valign="top" colspan=2>
<font color=navy><b>
Steps to build a SQL query graphically:
</b></font>
</td></tr>
<tr><td colspan=2>&nbsp;</td></tr>
<tr>
<td valign="top"><image src=<%=imagePath%>/smallball.gif></td>
<td height="40" align="left" valign="top">
<font color=navy>
 List tables: select appropriate Schema and Catalog, specify the pattern (optional) and the display size (optional), then click <B>Get Tables</B> button to list those tables which meet the criterion.
</font>
</td></tr>
<tr>
<td valign="top"><image src=<%=imagePath%>/smallball.gif></td>
<td height="40" align="left" valign="top">
<font color=navy>
 Choose tables: after tables listed, on the table list panel, selected tables you want to build the query on them.
</td></tr>
<tr>
<td valign="top"><image src=<%=imagePath%>/smallball.gif></td>
<td height="40" align="left" valign="top">
<font color=navy>
 Enter Query Builder: click <B>Query Button</B> button on the table list panel to enter the Query Builder.
</font>
<p>
</td></tr>
<tr><td colspan=2 align=center>
<%=PublicAPI.button("javascript:window.history.back();", "_self", "back_small", imagePath)%>
</td></tr>
<tr><td colspan=2 height=170>&nbsp;</td></tr>
</table>
<table border=0 width=660><tr>
<td><%=PublicAPI.copyrightStr()%></td>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr></table>
</center>
<%=PublicAPI.processingDiv(imagePath)%>
</body>
</html>
