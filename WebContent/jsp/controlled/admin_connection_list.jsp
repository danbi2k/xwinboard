<%@ include file="/jsp/inc/admin_definitions.inc" %>
<html>
<head>
<title>DB Cruiser Administration -- Connection List</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel="stylesheet" type="text/css" href="<%=stylePath%>/basic.css">
<link rel="stylesheet" type="text/css" href="<%=stylePath%>/sortabletable.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
<script type="text/javascript" src="<%=scriptPath%>/common.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/prototype.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/scrollabletable.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/sortabletable.js"></script>
</head>
<body background="<%=imagePath%>/<%=info.get("admin_bg")%>" onload="getContent();">
<center>
<%@ include file="/jsp/inc/admin_menu.inc" %>
<p>
<span class="adminTitle">Manage Connection List</span><br>
<% if (message != null) out.println(message); %>
<FORM NAME=conn_list METHOD=POST ACTION="<%=jspPath%>/controlled/admin_connection_detail.jsp">
<INPUT TYPE="hidden" NAME="controller" value="ModifyConnDetail">
<INPUT TYPE="hidden" NAME="type" value="delete">
<table style="border:0px;">
<tr>
<td>Number of Connections: <span id="countContainer"></span></td>
</tr>
<tr><td>
<div id="tableContainer"/>
</td></tr>
<!-- <tr><td align="right"><font color=#990033>(click the column title to sort)</font></td></tr> -->
</table>
<table style="border:0px;width:auto;">
<tr><td><nobr>
<div id="navcontainer">
<ul id="navlist">
<li><a href="javascript:window.history.back();" title="Back to previous page">&nbsp;&nbsp;&nbsp;&nbsp;&lt;&lt;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a href="javascript:document.location.reload();" title="Refesh the page.">&nbsp;&nbsp;&nbsp;&nbsp;Refresh&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a href="javascript:addConnection();" title="Add new connections">&nbsp;&nbsp;&nbsp;&nbsp;Add connection&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a href="javascript:cloneConnection();" title="Clone the selected connection">&nbsp;&nbsp;&nbsp;&nbsp;Clone Connection&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a href="javascript:deleteConnection();" title="Delete the selected connection">&nbsp;&nbsp;&nbsp;&nbsp;Delete Connection&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a class="action" href="javascript:viewConnection();" title="Edit the selected connection detail">&nbsp;&nbsp;&nbsp;&nbsp;Edit/View Connection&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
</ul>
</div> 
</nobr></td></tr>
</table>
</FORM>
<p>
<table style="border:0px;width:748px">
<td><%=PublicAPI.copyrightStr0()%></td>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr></table>
</CENTER></body>

<SCRIPT LANGUAGE="JavaScript">
<!--
function chosen() {
    var choosed = false;
	var len = document.conn_list.id.length;
	if (len) {
	    for (var i=0; i<len; i++) {
		     if (document.conn_list.id[i].checked == true) {
				 choosed = true;
				 break;
			 }
        }
    } else {
		if (document.conn_list.id.checked == true) {
			choosed = true;
		}
    }
	return choosed;
}

function deleteConnection() {
    if (chosen()) {
		if (confirm("Delete selected connection?")) {
			document.conn_list.type.value="delete";
            document.conn_list.action = "<%=contextPath%>/action/AdminModifyConnDetail";
	        document.conn_list.submit();
		}
	} else {
		alert("Please select a connection to delete.");
	}
}

function cloneConnection() {
    if (chosen()) {
		document.conn_list.type.value="clone";
        document.conn_list.action = "<%=contextPath%>/action/AdminModifyConnDetail";
	    document.conn_list.submit();
	} else {
		alert("Please select a connection to clone.");
	}
}
    
function viewConnection() {
	if (chosen()) {
	    document.conn_list.submit();
	} else {
		alert("Please select a connection to edit.");
	}
}

function veiwSelectedConnection(selectedId) {
    window.location = "<%=jspPath%>/controlled/admin_connection_detail.jsp?id="+selectedId;
}

function addConnection() {
	var len = document.conn_list.id.length;
    if (len) {
	    for (var i=0; i<len; i++) {
		     document.conn_list.id[i].checked = false;
        }
    } else {
		document.conn_list.id.checked = false;
	}
    document.conn_list.submit();
}

function getContent() {
    var now = new Date();
    var myAjax = new Ajax.Updater('tableContainer', '<%=actionPath%>/AdminGetConnList?id='+now, { method: 'get', asynchronous: false});
    var t = new SortableTable(document.getElementById('content'));
    <% if (browser != null && (browser.toUpperCase().indexOf("MSIE") > 0 || browser.toUpperCase().indexOf("FIREFOX") > 0)) { %>
           var t = new ScrollableTable(document.getElementById('content'), 400, 730);
    <% } %>
    var myCountAjax = new Ajax.Updater('countContainer', '<%=actionPath%>/ListCount?name=conntionCount&id='+now, { method: 'get'});
}
//-->
</SCRIPT>
</html>
