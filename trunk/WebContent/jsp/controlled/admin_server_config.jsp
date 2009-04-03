<%@ include file="/jsp/inc/admin_definitions.inc" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<% 
   String floatMenuBgColor = info.get("float_menu_color");
   if (floatMenuBgColor == null || floatMenuBgColor.trim().length() == 0)
       floatMenuBgColor = "";
   String header_color = info.get("header_color");
   if (header_color == null || header_color.trim().length() == 0)
       header_color = "";
   String resultBgColor = info.get("result_bgcolor");
   if (resultBgColor == null || resultBgColor.trim().length() == 0)
       resultBgColor = "";
   String default_display_size = info.get("default_display_size");
   if (default_display_size == null || default_display_size.trim().length() == 0) 
       default_display_size = "10";
%>
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<TITLE>DB Cruiser Administration -- Global Configuration</TITLE>
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/basic.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
<style>
 body {
   margin:30px 0px 0px 0px;
 }
 input select {
         border: 1px solid #888;
         padding: 2px 5px 2px 5px;
    }
</style>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
</HEAD>
<BODY background="<%=imagePath%>/<%=info.get("admin_bg")%>" OnLoad="setValues();">
<CENTER>
<%@ include file="/jsp/inc/admin_menu.inc" %>
<p>
<span class="adminTitle">Global Configuration</span>
<p>
<% if (message != null) out.println(message); %>
<FORM NAME=inputForm METHOD=POST ACTION="<%=contextPath%>/action/AdminModifyServerConfig">
<INPUT TYPE="hidden" NAME="controller" value="ModifyServerConfig">
<div style='text-align:left;width:720px;padding:15px 0px 15px 50px;margin:20px 0px 10px 0px;border:1px dotted #483D8B;background-color:#F0F8FF;'>
<table style="width:700px;border:none;">
<tr>
<!--
<td><FONT FACE=Arial COLOR="navy">Servlet Prefix</FONT></td>
<td colspan=3><INPUT TYPE="text" SIZE=25 NAME="servletPrefix" VALUE="<%=info.get("servlet_prefix")%>"></td>
</tr><tr>
<td><FONT FACE=Arial COLOR="navy">JSP Prefix</FONT></td>
<td colspan=3><INPUT TYPE="text" SIZE=25 NAME="jspPrefix" VALUE="<%=info.get("jsp_prefix")%>"></td>
</tr><tr>
-->
<td><FONT FACE=Arial COLOR="navy">Global Background</FONT></td>
<td><SELECT NAME="dbcruiser_bg">
<jsp:include page="/jsp/inc/background.html" flush="true" />
</SELECT></td>
<td><FONT FACE=Arial COLOR="navy">Debugging Level</FONT></td>
<td><SELECT NAME="debug" style="width:115">
    <option value="ALL">ALL
    <option value="TRACE">TRACE
    <option value="DEBUG">DEBUG 
    <option value="INFO">INFO 
    <option value="WARN">WARN 
    <option value="ERROR">ERROR 
    <option value="FATAL">FATAL
    <option value="OFF">OFF
    </SELECT>
</td>
</tr><tr>
<td><FONT FACE=Arial COLOR="navy">Admin Background</FONT></td>
<td><SELECT NAME="admin_bg">
<jsp:include page="/jsp/inc/background.html" flush="true" />
</SELECT></td>
<td><nobr><FONT FACE=Arial COLOR="navy">Session Timeout</FONT></nobr></td>
<td><SELECT NAME="timeout"  style="width:115">
    <option value=Default>Default
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
<td><FONT FACE=Arial COLOR="navy">Menu Style</FONT></td>
<td>
<SELECT NAME="dbcruiser_menu_bg">
<option>markermenu
<option>bevelmenu
<option>buttonmenu
</SELECT>
</td>
<td><FONT FACE=Arial COLOR="navy">Default Display Size</FONT></td>
<td><select NAME="defaultDisplaySize" style="width:115">
     <option>15</option>
     <option>30</option>
     <option>50</option>
     <option>100</option>
	 </select>
</td>
</tr><tr>
<td><FONT FACE=Arial COLOR="navy">Result Header Color</FONT></td>
<td valign=bottom>
<INPUT TYPE="text" NAME="header_color" VALUE="<%=header_color%>" style="width:73">
<%=PublicAPI.button("javascript:chooseColor('header_color');", "_self", "choose", imagePath, 1)%>
</td>
<td><FONT FACE=Arial COLOR="navy">Result Background</FONT></td>
<td valign=bottom>
<INPUT TYPE="text" NAME="result_bgcolor" VALUE="<%=resultBgColor%>" style="width:60">
<%=PublicAPI.button("javascript:chooseColor('result_bgcolor');", "_self", "choose", imagePath, 2)%>
</td>
</tr><tr>
<td><FONT FACE=Arial COLOR="navy">Float Menu Bg Color</FONT></td>
<td valign=bottom>
<INPUT TYPE="text" NAME="float_menu_color" VALUE="<%=floatMenuBgColor%>" style="width:73">
<%=PublicAPI.button("javascript:chooseColor('float_menu_color');", "_self", "choose", imagePath, 3)%>
</td>
<!-- <td><FONT FACE=Arial COLOR="navy">Use Float Menu</FONT></td>  -->
<td><FONT FACE=Arial COLOR="navy">Use Demo Mode</FONT></td>
<td><SELECT NAME="use_float_menu" style="width:115">
    <option value="false">No
	<option value="true">Yes
    </SELECT>
</td>
</tr><tr>
<td><FONT FACE=Arial COLOR="navy">Admin User ID</FONT></td>
<td><INPUT TYPE="text" SIZE=19 NAME="admin_user" VALUE="<%=info.get("admin_user")%>"></td>
<!-- </tr><tr> -->
<td><FONT FACE=Arial COLOR="navy">Admin Password</FONT></td>
<td><INPUT TYPE="password" SIZE=19 NAME="admin_pass" MAXLENGTH=30 VALUE="<%=info.get("admin_pass")%>"></td>
</tr><tr>
<td><FONT FACE=Arial COLOR="navy">Admin Phone</FONT></td>
<td><INPUT TYPE="text" SIZE=19 NAME="admin_phone" VALUE="<%=info.get("admin_phone")%>"></td>
<td><FONT FACE=Arial COLOR="navy">Admin Pager</FONT></td>
<td><INPUT TYPE="text" style="width:200px" NAME="admin_pager" VALUE="<%=info.get("admin_pager")%>"></td>
</tr><tr>
<td><FONT FACE=Arial COLOR="navy">Admin Mobile</FONT></td>
<td><INPUT TYPE="text" SIZE=19 NAME="admin_mobile" MAXLENGTH=30 VALUE="<%=info.get("admin_mobile")%>"></td>
<td><FONT FACE=Arial COLOR="navy">Admin Email</FONT></td>
<td><INPUT TYPE="text" style="width:200px" NAME="admin_email" MAXLENGTH=50 VALUE="<%=info.get("admin_email")%>"></td>
</tr><tr>
<td><FONT FACE=Arial COLOR="navy">Config File</FONT></td>
<td colspan=3>
<%=info.getConfigFileLocation() %>
</td>
</tr><tr>
<td><FONT FACE=Arial COLOR="navy">License File</FONT></td>
<td colspan=3>
<%=info.getLicenseFileLocation() %>
</td>
</tr><tr>
<td colspan=4>

<table style="width:630px;">
<tr><td colspan=2><FONT COLOR="navy"><B>Character Large Object (CLOB) Display Size:</B></FONT></td>
</tr>
<tr>
<td><NOBR>
<FONT FACE=Arial COLOR="navy">Initial Size:</FONT>
<SELECT NAME="clob_initial_display_size">
<option value=1000>1K
<option value=2000>2K
<option value=3000>3K
<option value=4000>4K
<option value=5000>5K
<option value=6000>6K
<option value=7000>7K
<option value=8000>8K
<option value=9000>9K
<option value=10000>10K
<option value=20000>20K
<option value=30000>30K
<option value=40000>40K
<option value=50000>50K
<option value=60000>60K
<option value=70000>70K
<option value=80000>80K
<option value=90000>90K
<option value=100000>100K
</SELECT> 
</NOBR>
</td>
<td><NOBR>&nbsp;
<FONT FACE=Arial COLOR="navy">Maximum Size:</FONT>
<SELECT NAME="clob_maximum_display_size">
<option value=200000>200K
<option value=300000>300K
<option value=400000>400K
<option value=500000>500K
<option value=600000>600K
<option value=700000>700K
<option value=800000>800K
<option value=900000>900K
<option value=900000>900K
<option value=1000000>1MB
</SELECT>
</NOBR>
</td>
</tr>
</table>

</td>

</tr>
</table>
</div>
<table style="border:0px;width:auto;">
<tr><td><nobr>
<div id="navcontainer">
<ul id="navlist">
<li><a href="javascript:window.history.back();" title="Back to previous page">&nbsp;&nbsp;&nbsp;&nbsp;&lt;&lt;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a href="javascript:document.location.reload();" title="Refesh the page.">&nbsp;&nbsp;&nbsp;&nbsp;Refresh&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a href="javascript:helpWindow();" title="Refesh the page.">&nbsp;&nbsp;&nbsp;&nbsp;Help&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a class="action" href="javascript:checkFields();" title="Save changes to the server">&nbsp;&nbsp;&nbsp;&nbsp;Save Changes&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
</ul>
</div> 
</nobr></td></tr>
</table>
</FORM>
<table style="border:0px;width:748px;margin-top:10px;">
<td><%=PublicAPI.copyrightStr0()%></td>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr></table>
</CENTER></BODY>
</HTML>

<SCRIPT LANGUAGE="JavaScript">
function helpWindow() {
	var width = 760;
	var winl = (screen.width - width) / 2;
	openPopup2("<%=contextPath%>/admin_server_config_help.html", "server_config_help", width, 550, 0, winl);
}

function logout() {
	document.inputForm.controller.value = "AdminLogout";
	document.inputForm.submit();
	window.close();
}

function checkFields() {
	check_fields();
}

function check_fields() {
	if (document.inputForm.admin_user.value == "") {
		alert("Please enter Admin User ID.");
        document.inputForm.admin_user.focus();
		return false;
	}
	if (!checkChars(document.inputForm.admin_user.value)) {
		return false;
	}
	if (document.inputForm.admin_pass.value == "") {
		alert("Please enter Admin password.");
        document.inputForm.admin_pass.focus();
		return false;
	}
	if (!checkChars(document.inputForm.admin_pass.value)) {
		return false;
	}
	if (confirm("Save server configuration?")) {
        document.inputForm.submit();
	}
}

function checkChars(str) {
	if ((str.indexOf("&") != -1) || (str.indexOf("<") != -1) || (str.indexOf(">") != -1) || (str.indexOf("\"") != -1)) {
		alert("Value can not contain character &, <, > or \"");
		return false;
	}
	return true;
}

function setValues() {
	var sdebug = document.inputForm.debug;
    for (var i=0; i<sdebug.length; i++) {
		 if (sdebug.options[i].value == "<%=info.get("debug")%>") {
             sdebug.options[i].selected = true;
		 }
    }
	var sclob_maximum_display_size = document.inputForm.clob_maximum_display_size;
    for (var i=0; i<sclob_maximum_display_size.length; i++) {
		 if (sclob_maximum_display_size.options[i].value == "<%=info.get("clob_maximum_display_size")%>") {
             sclob_maximum_display_size.options[i].selected = true;
		 }
    }
	var sclob_initial_display_size = document.inputForm.clob_initial_display_size;
    for (var i=0; i<sclob_initial_display_size.length; i++) {
		 if (sclob_initial_display_size.options[i].value == "<%=info.get("clob_initial_display_size")%>") {
             sclob_initial_display_size.options[i].selected = true;
		 }
    }
	/*
	var sjavaDev = document.inputForm.javaDev;
    for (var i=0; i<sjavaDev.length; i++) {
		 if (sjavaDev.options[i].value == "<%=info.get("java_dev")%>") {
             sjavaDev.options[i].selected = true;
		 }
    }
	var sconfigPanel = document.inputForm.configPanel;
    for (var i=0; i<sconfigPanel.length; i++) {
		 if (sconfigPanel.options[i].value == "<%=info.get("config_panel")%>") {
             sconfigPanel.options[i].selected = true;
		 }
    }*/
	var sdefaultDisplaySize = document.inputForm.defaultDisplaySize;
    for (var i=0; i<sdefaultDisplaySize.length; i++) {
		 if (sdefaultDisplaySize.options[i].text == "<%=default_display_size%>") {
             sdefaultDisplaySize.options[i].selected = true;
		 }
    }
	var sdbcruiser_bg = document.inputForm.dbcruiser_bg;
    for (var i=0; i<sdbcruiser_bg.length; i++) {
		 if (sdbcruiser_bg.options[i].text == "<%=info.get("dbcruiser_bg")%>") {
             sdbcruiser_bg.options[i].selected = true;
		 }
    }
	var sadmin_bg = document.inputForm.admin_bg;
    for (var i=0; i<sadmin_bg.length; i++) {
		 if (sadmin_bg.options[i].text == "<%=info.get("admin_bg")%>") {
             sadmin_bg.options[i].selected = true;
		 }
    }
	var sdbcruiser_menu_bg = document.inputForm.dbcruiser_menu_bg;
    for (var i=0; i<sdbcruiser_menu_bg.length; i++) {
		 if (sdbcruiser_menu_bg.options[i].text == "<%=info.get("dbcruiser_menu_bg")%>") {
             sdbcruiser_menu_bg.options[i].selected = true;
		 }
    }
	/*
	var sheader_color = document.inputForm.header_color;
    for (var i=0; i<sheader_color.length; i++) {
		 if (sheader_color.options[i].value == "<%=info.get("header_color")%>") {
             sheader_color.options[i].selected = true;
		 }
    }*/
	var sessionTimeout = document.inputForm.timeout;
    for (var i=0; i<sessionTimeout.length; i++) {
		 if (sessionTimeout.options[i].value == "<%=info.get("session_timeout")%>") {
             sessionTimeout.options[i].selected = true;
		 }
    }
	/*
	var rBgcolor = document.inputForm.result_bgcolor;
    for (var i=0; i<rBgcolor.length; i++) {
		 if (rBgcolor.options[i].value == "<%=info.get("result_bgcolor")%>") {
             rBgcolor.options[i].selected = true;
		 }
    }*/
	var useFloatMenu = document.inputForm.use_float_menu;
    for (var i=0; i<useFloatMenu.length; i++) {
		 if (useFloatMenu.options[i].value == "<%=info.get("use_float_menu")%>") {
             useFloatMenu.options[i].selected = true;
		 }
    }
}
</SCRIPT>

<%=PublicAPI.chooseColorScript2(jspPath)%>
