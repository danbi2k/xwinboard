<%@ include file="/jsp/inc/definitions.inc" %>
<html>
<head>
<title>Foreign Key Delete/Update Rule</title>
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
<h2>Foreign Key Delete/Update Rule</h2>
<p>
<table class="mars" style="width:650px;margin-top:10px;">
<thead>
<tr>
<th>Name</th>
<th>Value</th>
</tr>
</thead>
<tbody>
<tr>
<td class="itemName">Cascade</td>
<td>
If a primary key has been deleted, delete rows that contain the foreign key.<br>
If a primary key has been updated, change the foreign key to agree with it..
</td>
</tr>
<tr class="even">
<td class="itemName">No Action</td>
<td>
If a primary key has been imported by another table, it cannot be deleted nor updated.
</td>
</tr>
<tr>
<td class="itemName">Set to Null</td>
<td>
If a primary key has been deleted or updated, change the foreign to null.
</td>
</tr>
<tr class="even">
<td class="itemName" style="width:100px;">Set to Default</td>
<td>
If a primary key has been deleted or updated, change the foreign to its default value.
</td>
</tr>
</tbody>
</table>
<p>
<%=PublicAPI.copyrightStr0()%>
</center>
</body>
</html>
