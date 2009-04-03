<%@ include file="/jsp/inc/definitions.inc" %>
<% 
   boolean queryBuilder = Boolean.valueOf(request.getParameter("queryBuilder")).booleanValue();
   if (queryBuilder) {
       request.getRequestDispatcher("/jsp/sql_query_builder_help.jsp").forward(request, response);
       return;
   } 
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/introduction.css>
<style type="text/css">
body {margin-top: 0px;}
</style>
<title>Find table definitions of databases</title>
</head>
<body OnLoad="stopProcessing();">
<center>
<div style='text-align:left;width:740px;padding:10px 0px 0px 5px;margin:10px 0px 0px 0px;border:1px dotted #483D8B;'>
<!--  <TABLE style="width:740px;border:1px solid #707070;"><TR><TD> -->
<!--  <table border=0 width=730px><tr><td colspan=2 align=left></td></tr></table> -->
<span style="color:#2F4F4F;font-size:14px;font-family:arial;font-weight:bold;">
&nbsp;&nbsp;Steps to List/Search Tables:
</span>
<ul style="margin: 15px 15px;padding-left:5px;list-style:circle;">
<li class="listItem">
<strong>Select Schema and Catalog</strong>: then select the type of tables and specify a pattern (optional), then click <B>Get Tables</B> button to list those tables which meet the criterion.
</li>
<li class="listItem">
<strong>Use Patterns</strong>: you may search tables by patterns. For example, pattern BOOK% will list all the tables whose names begin with BOOK, pattern 
%BOOK% will list all the tables whose names contain BOOK, pattern %BOOK will list all the tables whose names end with BOOK, 
pattern %BOOK%TITLE% will list all the tables whose names contain BOOK followed by TITLE, etc.
<p style="margin:10px 0px 0px 0px;padding:0px;">
In other words, <B>patterns</B> are similar to LIKE conditions in SQL statements.
</p>
<p style="margin:10px 0px 0px 0px;padding:0px;">
<B>Note</B>: For Oracle&reg;, all the table names are in upper case. But for some database products, like Sybase&reg;, DB2(UDB)&reg;, MySQL&reg;, Informix&reg;, etc., table names are case sensitive.
</p>
</li>
<li class="listItem">
<strong>Enter Table Work Area</strong>: for each table on the list result, click the table name to enter the <B>Table Work Area</B> of the table, where you can find the detailed information about the table, like column definitions, primary keys, foreign keys, indexes, number of rows in the table, etc.
</li>
<li class="listItem">
<strong>Open in New Windows</strong>: for each table on the list result, click the <image src="<%=imagePath%>/new_window.gif"> icon next to the table name to enter the Table Work Area in a new (pop-up) wondo. Therefore, you can work on multiple tables at the same time.
</li>
<li class="listItem">
<font color=crimson><b>Note:</b></font> 
Tables contaning user defined types are not currently supported, but will be soon.
</li>
</ul>
<span style="color:#2F4F4F;font-size:14px;font-family:arial;font-weight:bold;">
&nbsp;&nbsp;Steps to Build SQL Queries Visually:
</span>
<ul style="margin: 15px 15px;padding-left:5px;list-style:circle;">
<li class="listItem">
<strong>Search/List Tables</strong>: follow the steps above.
</li>
<li class="listItem">
<strong>Choose Tables</strong>: after tables listed, on the table list result panel, use the checkbox on the left to select tables you want to build the query on them.
</li>
<li class="listItem">
<strong>Enter Query Builder</strong>: click "Query Button" button on the table list panel to enter the Query Builder.
</li>
</ul>
<!--  </TD></TR></TABLE> -->
</div>
<br>
<table border=0 width=730><tr>
<td align=left>
<div id="actcontainer">
<ul id="navlist">
<li><a href="javascript:window.history.back();" title="Back to previous page">&nbsp;&nbsp;Back&nbsp;&nbsp;</a></li>
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
