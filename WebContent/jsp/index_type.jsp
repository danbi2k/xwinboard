<%@ include file="/jsp/inc/definitions.inc" %>
<% 
%>
<html>
<head>
<title>Table Index Types</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/basic.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
<link type="text/css" rel=stylesheet href="<%=contextPath%>/styles/dhtmlwindow.css">
<link rel="stylesheet" type="text/css" href="<%=stylePath%>/sortabletable.css">
</head>
<body>
<center>
<h2>Table Index Types</h2>
<P>
<table class="mars" style="width:650px;margin-top:10px;">
<thead>
<tr>
<th>Name</th>
<th>Value</th>
</tr>
</thead>
<tbody>
<tr>
<td class="itemName">Statistic</td>
<td>-- indentifies table statistics that are returned in conjunction with a table's index description.</td>
</tr>
<tr class="even">
<td class="itemName">Hashed</td>
<td>-- indentifies this index as a hashed index.</td>
</tr>
<tr>
<td class="itemName">Clustered</td>
<td>-- indentifies this index as a clustered index.</td>
</tr>
<tr class="even">
<td class="itemName">Other</td>
<td>-- indentifies this index as some other style of index.</td>
</tr>
</tbody>
</table>
<p>
<%=PublicAPI.copyrightStr0()%>
</center>
</body>
</html>
