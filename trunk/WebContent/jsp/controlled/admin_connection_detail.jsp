<%@ include file="/jsp/inc/admin_definitions.inc" %>
<% 
   String conn_id = request.getParameter("id"); 
   ArrayList connList = info.getConnectionList();
   ConnectionItem connInfo = null;
   for (Iterator iter = connList.iterator(); iter.hasNext();) {
        ConnectionItem cInfo = (ConnectionItem)iter.next();
		if (cInfo.getId().equals(conn_id)) {
			connInfo = cInfo;
		}	
   }
%>
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/basic.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
<style type="text/css">
      body {
        margin:30px 0px 0px 0px;
      }
      input select {
         border: 1px solid #888;
         padding: 2px 5px 2px 5px;
      }
</style>
<TITLE>DB Cruiser Administration -- Connection Detail</TITLE>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
</HEAD>
<BODY background="<%=imagePath%>/<%=info.get("admin_bg")%>" OnLoad="setValues();">
<CENTER>
<%@ include file="/jsp/inc/admin_menu.inc" %>
<br>
<FORM NAME=detail METHOD=POST ACTION="<%=contextPath%>/action/AdminModifyConnDetail">
<input type="hidden" NAME="id" value="<%=conn_id%>">
<input type="hidden" NAME="type" value="modify">
<%  if (connInfo != null) { %>
    <span class="adminTitle">Edit Connection</span>
<%  } else { %>
   <span class="adminTitle">Add New Connection</span>
<%  } %>
<p>
<% if (message != null) out.println(message); %>
<p>
<div style='text-align:left;width:730px;padding:15px 10px 15px 20px;margin:20px 0px 10px 0px;border:1px dotted #483D8B;background-color:#F0F8FF;'>
    <table align=center style="width:710px;border:none;">
    <tr>    
		<td><nobr><FONT FACE=Arial COLOR="navy">Connection Name</FONT></nobr></td>
		<td colspan=3><input type="text" NAME="display_name" style="width:400px;" ></td>
	</tr><tr>
        <td><FONT FACE=Arial COLOR="navy">Display Name</FONT></td>
	    <td><input type="text" SIZE=20 MAXLENGTH=25 NAME="short_name" ></td>
		<td><nobr>&nbsp;<FONT FACE=Arial COLOR="navy">Session Timeout</FONT></nobr></td>
        <td><SELECT NAME="timeout" style="width:142">
		                   <option value=Default>Default
		                   <option value=600>10 min
		                   <option value=1200>20 min
                           <option value=1800>30 min
						   <option value=3600>60 min
						   <option value=5400>90 min
						   <option value=7200>120 min
						   <option value=9000>150 min
						   <option value=10800>180 min
						   <option value=12600>210 min
						   <option value=14400>240 min
						   <option value=18000>300 min
						   <option value=21600>360 min
						   <option value=25200>420 min
						   <option value=28800>480 min
						   <option value=32400>540 min
						   <option value=36000>600 min
                           <option value="-1">Never
	        </SELECT>
        </td>
	</tr><tr>
        <td><FONT FACE=Arial COLOR="navy">Database Product</FONT></td>
<% if (browser != null && (browser.indexOf("MSIE") != -1)) { %>
	    <td><input type="text" SIZE=20 NAME="product"></td>
<% } else { %>
        <td><input type="text" SIZE=15 NAME="product"></td>
<% }  %>
     <td colspan=2><nobr>&nbsp;<FONT FACE=Arial COLOR="navy">Allow CLOB as Character String</FONT></nobr>&nbsp;
	     <SELECT NAME="allowClobAsString" style="width:65"><OPTION value=false>False<OPTION value=true>True</SELECT>
	 </td>
	</tr><tr>
        <td><FONT FACE=Arial COLOR="navy">Driver Class</FONT></td>
<% if (browser != null && (browser.indexOf("MSIE") != -1)) { %>
	    <td colspan=3><input type="text" NAME="driver" SIZE=60 ></td>
<% } else { %>
        <td colspan=3><input type="text" NAME="driver" SIZE=45 ></td>
<% }  %>
	</tr><tr>
	    <td><FONT FACE=Arial COLOR="navy">Connection URL</FONT></td>
<% if (browser != null && (browser.indexOf("MSIE") != -1)) { %>
	    <td colspan=3><input type="text" NAME="url" SIZE=60 ></td>
<% } else { %>
        <td colspan=3><input type="text" NAME="url" SIZE=45 ></td>
<% }  %>
	</tr><tr>
        <td><FONT FACE=Arial COLOR="navy">Conntion Type</FONT></td>
	    <td colspan=3>
		    <SELECT NAME="conn_type" style="width:375">
		    <option value="1">Category 1
		    <option value="2">Category 2
		    <option value="3">Category 3	        
	        <option value="sybase_jconnect2_v5">Sybase JConnect for JDBC 5.x (jdbc2), Version 5
	        <option value="sybase_jconnect2_v4">Sybase JConnect for JDBC 5.x (jdbc2), Version 4
			<option value="weblogic.jdbc.mssqlserver4.Driver">weblogic.jdbc.mssqlserver4.Driver
<!--
			<option>com.mysql.jdbc.Driver
	        <option>org.gjt.mm.mysql.Driver
-->
	        </SELECT></td>
	</tr><tr>
        <td><FONT FACE=Arial COLOR="navy">Updatable Result</FONT></td>
        <td><SELECT NAME="editableRow"><OPTION value=true>True<OPTION value=false>False</SELECT></td>
		<td><nobr><FONT FACE=Arial COLOR="navy">Display Font Size</FONT></nobr></td>
		<td>
            <SELECT NAME="display_font_size" style="width:142"><OPTION value="11">Default
			<%=PublicAPI.fontSizeList()%>
			</SELECT>
		</td>
	</tr><tr>
	    <td><FONT FACE=Arial COLOR="navy">Use Conn. Pool</FONT></td>
        <td><SELECT NAME="use_conn_pool"><OPTION value=false>False<OPTION value=true>True</SELECT></td>
		<td><nobr><FONT FACE=Arial COLOR="navy">Conn. Pool Size</FONT></td>
		<td>
            <SELECT NAME="conn_pool_size" style="width:142">
            <option value=2>2<option value=3>3<option value=4>4<option value=5>5
			<option value=6>6<option value=7>7<option value=8>8<option value=9>9<option value=10>10
			<option value=11>11<option value=12>12<option value=13>13<option value=14>14<option value=15>15
			<option value=16>16<option value=17>17<option value=18>18<option value=19>19<option value=20>20
			<option value=30>30<option value=40>40<option value=50>50
			</SELECT></nobr>
		</td>
    </tr><tr>
    <td><FONT FACE=Arial COLOR="navy">Disabled</FONT></td>
    <td>
    <SELECT NAME="inactive">
    <option value=false>False<option value=true>True
	</SELECT>
	</td>
	<td><font FACE=Arial COLOR="navy">Max Result Size</font></td>
	<td>
    <select name="max_result_size">
    <option value="5000">5000</option>
    <option value="10000">10000</option>
    <option value="20000">20000</option>
    <option value="30000">30000</option>
    <option value="40000">40000</option>
    <option value="50000">50000</option>
    <option value="60000">60000</option>
    <option value="70000">70000</option>
    <option value="80000">80000</option>
    <option value="90000">90000</option>
    <option value="100000">100000</option>
    <option value="0">Unlimited</option>
	</select>
	</td>
	</tr><tr>
        <td><FONT FACE=Arial COLOR="navy">Default UserID</FONT></td>
<% if (browser != null && (browser.indexOf("MSIE") != -1)) { %>
	    <td><input type="text" SIZE=20 NAME="default_userid" ></td>
<% } else { %>
        <td><input type="text" SIZE=15 NAME="default_userid" ></td>
<% } %>
	<!-- </tr><tr> -->
        <td><FONT FACE=Arial COLOR="navy">Default Password</FONT></td>
<% if (browser != null && (browser.indexOf("MSIE") != -1)) { %>
	    <td><input type="password" style="width:140" NAME="default_password" ></td>
<% } else { %>
        <td><input type="password" SIZE=12 NAME="default_password" ></td>
<% } %>
	</tr>	
	</table>
</div>
	<p>
<table style="border:0px;width:auto;">
<tr><td><nobr>
<div id="navcontainer">
<ul id="navlist">
<li><a href="javascript:window.history.back();" title="Back to previous page">&nbsp;&nbsp;&nbsp;&nbsp;&lt;&lt;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a href="javascript:document.location.reload();" title="Refesh the page.">&nbsp;&nbsp;&nbsp;&nbsp;Refresh&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a href="javascript:helpWindow();" title="Help for the connection detail.">&nbsp;&nbsp;&nbsp;&nbsp;Help&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<%  if (connInfo == null) { %>
<li><a href="javascript:addConnection();" title="Save the new connection">&nbsp;&nbsp;&nbsp;&nbsp;Save&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<%  } else { %>
<li><a href="javascript:deleteConnection();" title="Delete This Connection">&nbsp;&nbsp;&nbsp;&nbsp;Delete This Connection&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a href="javascript:saveAsConnection();" title="Save this connection as a new connection">&nbsp;&nbsp;&nbsp;&nbsp;Save As a New Connection&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a class="action" href="javascript:modifyConnection();" title="Save the modification of the connection">&nbsp;&nbsp;&nbsp;&nbsp;Save Changes&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<%  } %>
</ul>
</div> 
</nobr></td></tr>
</table>
</FORM>
<table style="border:0px;width:748px;margin-top:10px;">
<td><%=PublicAPI.copyrightStr0()%></td>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr></table>
</CENTER>
</BODY>
</HTML>

<SCRIPT LANGUAGE="JavaScript">
<!--
function helpWindow() {
	var width = 700;
	var winl = (screen.width - width) / 2;
	openPopup2("<%=contextPath%>/conn_config_help.html", "connection_detail_help", width, 550, 0, winl);
}

function setValues() {
<%  if (connInfo != null) { 
	    String default_userid = connInfo.getDefaultUserid();
		String default_password = connInfo.getDefaultPassword();
%>
    document.detail.display_name.value = "<%=connInfo.getDescription()%>";
    document.detail.short_name.value = "<%=connInfo.getDisplayName()%>";
	document.detail.product.value = "<%=connInfo.getProduct()%>";
	document.detail.driver.value = "<%=connInfo.getDriver()%>";
	document.detail.url.value = "<%=connInfo.getUrl()%>";
	document.detail.default_userid.value = "<%=((default_userid==null)?"":default_userid)%>";
	document.detail.default_password.value = "<%=((default_password==null)?"":default_password)%>";
	var conntype = document.detail.conn_type;
    for (var i=0; i<conntype.length; i++) {
		 if (conntype.options[i].value == "<%=connInfo.getConnectionType()%>") {
             conntype.options[i].selected = true;
		 }
    }
	var editable = document.detail.editableRow;
    for (var i=0; i<editable.length; i++) {
		 if (editable.options[i].value == "<%=connInfo.getEditableRow()%>") {
             editable.options[i].selected = true;
		 }
    }
	var displayFont = document.detail.display_font_size;
    for (var i=0; i<displayFont.length; i++) {
		 if (displayFont.options[i].value == "<%=connInfo.getDisplayFontSize()%>") {
             displayFont.options[i].selected = true;
		 }
    }
	var sessionTimeout = document.detail.timeout;
    for (var i=0; i<sessionTimeout.length; i++) {
		 if (sessionTimeout.options[i].value == "<%=connInfo.getSessionTimeout()%>") {
             sessionTimeout.options[i].selected = true;
		 }
    }
	var useConnPool = document.detail.use_conn_pool;
    for (var i=0; i<useConnPool.length; i++) {
		 if (useConnPool.options[i].value == "<%=connInfo.getUseConnectionPool()%>") {
             useConnPool.options[i].selected = true;
		 }
    }
	var connPoolSise = document.detail.conn_pool_size;
    for (var i=0; i<connPoolSise.length; i++) {
		 if (connPoolSise.options[i].value == "<%=connInfo.getConnectionPoolSize()%>") {
             connPoolSise.options[i].selected = true;
		 }
    }
	var clobAsString = document.detail.allowClobAsString;
    for (var i=0; i<clobAsString.length; i++) {
		 if (clobAsString.options[i].value == "<%=connInfo.getAllowClobAsString()%>") {
             clobAsString.options[i].selected = true;
		 }
    }
    var inactiveStr = document.detail.inactive;
    for (var i=0; i<inactiveStr.length; i++) {
		 if (inactiveStr.options[i].value == "<%=connInfo.getInactive()%>") {
             inactiveStr.options[i].selected = true;
		 }
    }
    var maxResultSizeStr = document.detail.max_result_size;
    for (var i=0; i<maxResultSizeStr.length; i++) {
		 if (maxResultSizeStr.options[i].value == "<%=connInfo.getMaxResultSize()%>") {
             maxResultSizeStr.options[i].selected = true;
		 }
    }
<%  } %>
}

function addConnection() {
	if (checkFields()) {
	    if (confirm("Add this new connection?")) {
            document.detail.type.value="insert";
	        document.detail.submit();
		}
	}
}

function saveAsConnection() {
	if (checkFields()) {
	    if (confirm("Save as a new connection with specified information?")) {
            document.detail.type.value="insert";
	        document.detail.submit();
		}
	}
}

function modifyConnection() {
	if (checkFields()) {
	    if (confirm("Save the modification of this connection?")) {
            document.detail.type.value="modify";
	        document.detail.submit();
		}
	}
}
function deleteConnection() {
	if (confirm("Delete this connection?")) {
        document.detail.type.value="delete";
	    document.detail.submit();
	}
}
function checkFields() {
	if (document.detail.display_name.value == "") {
		alert("Please enter display name.");
		return false;
	}
	if (!checkChars(document.detail.display_name.value)) {
		return false;
	}
	if (document.detail.short_name.value == "") {
		alert("Please enter a short description of the connection.");
		return false;
	}
	if (!checkChars(document.detail.short_name.value)) {
		return false;
	}
	if (document.detail.product.value == "") {
		alert("Please enter database product.");
		return false;
	}
	if (!checkChars(document.detail.product.value)) {
		return false;
	}
	if (document.detail.driver.value == "") {
		alert("Please enter JDBC driver class.");
		return false;
	}
	if (!checkChars(document.detail.driver.value)) {
		return false;
	}
	if (document.detail.url.value == "") {
		alert("Please enter connection URL.");
		return false;
	}
	if (!checkChars(document.detail.url.value)) {
		return false;
	}
	return true;
}
function checkChars(str) {
	if ((str.indexOf("&") != -1) || (str.indexOf("<") != -1) || (str.indexOf(">") != -1) || (str.indexOf("\"") != -1)) {
		alert("Value can not contain character &, <, > or \"");
		return false;
	}
	return true;
}
//-->
</SCRIPT>

