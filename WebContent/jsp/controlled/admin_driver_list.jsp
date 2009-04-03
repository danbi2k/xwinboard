<%@ include file="/jsp/inc/admin_definitions.inc" %>
<% 
   //ArrayList drivers = info.getDrivers(); 
   request.setAttribute("driverList", info.getDrivers());
%>
<html>
<head>
<title>DB Cruiser Administration -- JDBC Driver List</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/basic.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/dhtmlwindow.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
<link rel="stylesheet" type="text/css" href="<%=stylePath%>/sortabletable.css">
<script type="text/javascript" src="<%=scriptPath%>/common.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/dhtmlwindow.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/prototype.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/scrollabletable.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/sortabletable.js"></script>
</head>
<body background="<%=imagePath%>/<%=info.get("admin_bg")%>" onload="getContent();">
<CENTER>
<%@ include file="/jsp/inc/admin_menu.inc" %>
<p>
<span class="adminTitle">JDBC Driver List</span>
<form name"=driver_list" method="post" action="<%=jspPath%>/controlled/admin_driver_detail.jsp">
<input TYPE="hidden" NAME="controller" value="AdminLogout"/>

<div style="width:735px;margin-bottom:10px;padding:5px;padding-bottom:0px;border:1px solid #888888;text-align:left;">
<p>The JDBC drivers listed below are only those which supported by the 3rd method to connect to databases via DB Cruiser. Please see <a href="javascript:helpWindow();" title="DB Cruiser login help"><span style="color:#0000FF;">Login Help</span></a> for the details 
(look for the 3rd method: "Choose a database product and a JDBC driver to connect").
</p>
<p>
That means, even your drivers are not on the list below, you can still connect to the databases via DB Cruiser. For further information of database products and JDBC drivers, check <a href="http://maththinking.com/resourceDriver.html" target="_blank" title="Database products and JDBC drivers information"><span style="color:#0000FF;">here</span></a>
</p>
</div>

<table style="border:0px">
<tr><td>
Number of Drivers: <span id="countContainer"></span>.
</td></tr>
<tr><td align=center>
<div id="tableContainer"/>
</td></tr></table>
<p>
<table style="border:0px;width:auto;">
<tr><td><nobr>
<div id="navcontainer">
<ul id="navlist">
<li><a href="javascript:window.history.back();" title="Back to previous page">&nbsp;&nbsp;&nbsp;&nbsp;&lt;&lt;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a href="javascript:document.location.reload();" title="Refesh the page.">&nbsp;Refresh&nbsp;</a></li>
<li><a class="action" href="javascript:view();" title="Save DB Cruiser log to a file">&nbsp;View Detail&nbsp;</a></li>
</ul>
</div> 
</nobr></td></tr>
</table>
</form>
<p>
<table style="border:0px;width:748px">
<td><%=PublicAPI.copyrightStr0()%></td>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr></table>
</body>
<script type="text/javascript">
<!--
function helpWindow() {
	var helpwin=dhtmlwindow.open('helpbox', 'iframe', '<%=jspPath%>/login_help.jsp', 'Login Help', 'width=750px,height=500px,resize=1,scrolling=1,center=1', 'blue');
}
function chosen() {
    var choosed = false;
	var len = document.driver_list.id.length;
	if (len) {
	    for (var i=0; i<len; i++) {
		     if (document.driver_list.id[i].checked == true) {
				 choosed = true;
				 break;
			 }
        }
    }
	return choosed;
}

function view() {
	if (chosen()) {
        document.driver_list.submit();
	} else {
		alert("Please select a JDBC driver to view.");
	}
}
function getContent() {
    var now = new Date();
    var myAjax = new Ajax.Updater('tableContainer', '<%=actionPath%>/AdminGetDriverList?id='+now, { method: 'get', asynchronous: false});
    var t = new SortableTable(document.getElementById('content'));
    <% if (browser != null && (browser.toUpperCase().indexOf("MSIE") > 0 || browser.toUpperCase().indexOf("FIREFOX") > 0)) { %>
           var t = new ScrollableTable(document.getElementById('content'), 300, 730);
    <% } %>
    var myCountAjax = new Ajax.Updater('countContainer', '<%=actionPath%>/ListCount?name=driverCount&id='+now, { method: 'get'});
}
//-->
</script>
</html>