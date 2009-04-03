<%@ include file="/jsp/inc/definitions.inc" %>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/introduction.css>
<title>SQL Work Area</title>
</head>
<body bgcolor=#f0fff0 OnLoad="stopProcessing();">
<center>
<span style="font-size:18px;font-weight:bold;color:#0000CC;">SQL Work Area Help</span>
<p>
<table border=0 width=670>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="35" align="left" valign="top">
<font color=navy>
Enter any standard SQL statement(s) in the above text area, specify the display size (optional), then click the "<FONT COLOR=#0000A0><b>Execute</b></FONT>" button to run the statement(s).
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="35" align="left" valign="top">
<font color=navy>
To enter multiple statements, each statement must begin with a new line, and end with the character '<B>;</B>', and  no white space after the ending '<B>;</B>' is allowed. A statement itself can span to several lines. 
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="35" align="left" valign="top">
<font color=navy>
If there are multiple statements, you may <FONT COLOR=#0000A0><b>highlight</b></FONT> only those statements you want to execute, then then click the "<FONT COLOR=#0000A0><b>Execute</b></FONT>" button to run the highlighted statement(s) only.
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="25" align="left" valign="top">
<font color=navy>
If "Auto Commit" is No, you need to click "<FONT COLOR=#0000A0><b>Commit</b>" button to commit the modification made.
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="35" align="left" valign="top">
<font color=navy>
You may save the statement(s) into a local disk by cliking "<FONT COLOR=#0000A0><b>Save</b></FONT>" button. To import a statement from a file in 
the local disk, first click "<FONT COLOR=#0000A0><b>Browse ...</b></FONT>" button to select a file.
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="25" align="left" valign="top">
<font color=navy>
You can view the history of all the SQL statements you have executed by clicking "<FONT COLOR=#0000A0><b>History</b></FONT>" button.
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="25" align="left" valign="top">
<font color=navy>
To view last execution output, clicking "<FONT COLOR=#0000A0><b>Output</b></FONT>" button.
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="30" align="left" valign="top">
<font color=navy>
<font color=crimson><b>Note:</b></font> Tables contaning user defined types are not currently supported, but will be soon.
</font>
</td></tr>
</table>
<table border=0 width=670><tr>
<td><%=PublicAPI.copyrightStr()%></td>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr></table>
<%=PublicAPI.processingDiv(imagePath)%>
</center>
<br>

</body>
</html>
