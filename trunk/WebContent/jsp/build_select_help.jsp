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
<span style="font-size:18px;font-weight:bold;color:#0000CC;">Build Select Statements Help</span>
<p>
<table border=0 width=670>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="65" align="left" valign="top">
<font color=navy>
You can graphically build select statements like<br>
"SELECT column1, column2, ... columnN FROM table Where ...(adn/or logic)... ORDER BY ASCEND/DESCEND
<p>
To build more complicated statements, please use Query Builder, SQL Work Area or SQL Work Sheet.
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="20" align="left" valign="top">
<font color=navy>
Select table columns you want to view using the checkboxes on the left side.
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="80" align="left" valign="top">
<font color=navy>
Use the dropdown list under "Search Values" column to select the search logic for the column, then type in search value if applicable.
<p>
<font color=crimson><b>Note:</b></font> don't not use any parenthesis in the search values. Use only the value itself. 
<br>For example, if the search logic is "in", you can type in multiple values separated by commas.
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="35" align="left" valign="top">
<font color=navy>
Use the dropdown list next tp "Search Values" label to select the AND/OR logic to associate search critiria for each colume.
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="20" align="left" valign="top">
<font color=navy>
Select a column to ORDER BY using the radio buttons on the right.
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="20" align="left" valign="top">
<font color=navy>
Select ORDER BY order using ascend/descend dropdown list aboved the radio buttons.
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="25" align="left" valign="top">
<font color=navy>
Select maximum number of return rows.
</font>
</td></tr>
<tr><td valign="top"><image src=<%=imagePath%>/smallball.gif>
<td height="30" align="left" valign="top">
<font color=navy>
<div id="actcontainer"><ul id="navlist"><li><a href="#" style="color:#ffffff;background-color:#8080C0;">View Seleted Columns</a></li></ul></div> button - Click it.
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
