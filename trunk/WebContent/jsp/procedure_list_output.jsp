<%@ include file="/jsp/inc/definitions.inc" %>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/introduction.css>
<title>Stored Procedures</title>
</head>
<body OnLoad="stopProcessing();">
<center>

<div style='text-align:left;width:740px;padding:10px 10px 10px 10px;margin:20px 0px 0px 0px;border:1px dotted #483D8B;'>
<span style="color:#2F4F4F;font-size:14px;font-family:arial;font-weight:bold;">
&nbsp;&nbsp;Steps to list/search stored procedures:
</span>
<ul style="margin: 15px 15px;padding-left:5px;list-style:circle;">
<li class="listItem">
<strong>Select Schema and Catalog</strong>: then specify a pattern (optional), then click <B>Go</B> button to list those stored procedures which meet the criterion.
</li>
<li class="listItem">
<strong>Use Patterns</strong>: you may search procedures by patterns. For example, BOOK% will list all the procedures whose names begin with BOOK, %BOOK% will list all 
the procedures whose names contain BOOK, %BOOK will list all the procedures whose names end with BOOK, %BOOK%TITLE% will list all the 
procedures whose names contain BOOK then TITLE, etc.
<p style="margin:10px 0px 0px 0px;padding:0px;">
In other words, <B>patterns</B> are similar to LIKE conditions in SQL statements.
</p>
<p style="margin:10px 0px 0px 0px;padding:0px;">
<B>Note</B>: For Oracle&reg;, all the stored procedure names are in upper case. But for some database products, like Sybase&reg;, DB2(UDB)&reg;, MySQL&reg;, Informix&reg;, etc., stored procedure names are case sensitive.
</p>
</li>
<li class="listItem">
<strong>Veiw Definition</strong>: for each stored procedure on the list result, click the stored procedure name to view the definition of the stored procedure.
</li>
<li class="listItem">
<strong>Veiw Source Code</strong>: if the "View Source" link appears, click it to view the source code of the stored procedure.
</li>
<li class="listItem">
<strong>Open in New Windows</strong>: for each stored procedure on the list result, click the <image src="<%=imagePath%>/new_window.gif"> icon next to the stored procedure name or the "View Source" link to view the content in a new (pop-up) wondo. Therefore, you can work on multiple stored procedures at the same time.
</li>
</ul>
</div>
<br>
<table border=0 width=730><tr>
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
<%=PublicAPI.processingDiv(imagePath)%>
</body>
</html>
