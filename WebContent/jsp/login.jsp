<%@ include file="/jsp/inc/definitions.inc" %>
<% 
   int id_size = 20;
   int dbname_size = 25;
   int hostname_size = 45;
   if (browser == null || (browser.indexOf("MSIE") == -1)) { 
	   id_size = 16;
	   dbname_size = 17;
	   hostname_size = 32;
   }
   ArrayList connList = info.getConnectionList();
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link type="text/css" rel=stylesheet href="<%=contextPath%>/styles/basic.css">
<link type="text/css" rel=stylesheet href="<%=contextPath%>/styles/login.css">
<link type="text/css" rel=stylesheet href="<%=contextPath%>/styles/dhtmlwindow.css">

<style type="text/css">
  body {margin-top: 20px;}
</style>
<title>DB Cruiser: Login</title>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html">
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/dhtmlwindow.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
jdbcboxOff = true;
if (window.parent == window.self) {
       window.location = "<%=contextPath%>/jsp/index.jsp";
}
var count = 0;
var drivers = new Array();
function Driver(id, name, product) {   
   this.id   = id;
   this.name = name;
   this.product = product;
}
function setDriver(id, name, product) {
   drivers[count++] = new Driver(id, name, product);
}
<% ArrayList driverList = info.getDrivers();
   if (driverList != null) {
       for (Iterator iter = driverList.iterator(); iter.hasNext();) {
            DriverItem driver = (DriverItem)iter.next();
       
%>
setDriver("<%=driver.getId()%>", "<%=driver.getName()%>", "<%=driver.getProduct()%>");
<%     }
   }
%>

var connCount = 0;
var connArray = new Array();

function ScriptName(userid, passwd, driverClass, connUrl, displayName) {
   this.userid = userid;
   this.passwd = passwd;
   this.driverClass = driverClass;
   this.connUrl = connUrl;
   this.displayName = displayName;
}

function setScript(userid, passwd, driverClass, connUrl, displayName) {
   connArray[connCount++] = new ScriptName(userid, passwd, driverClass, connUrl, displayName);
}
<% if (connList != null) {
       for (Iterator iter = connList.iterator(); iter.hasNext();) {
            ConnectionItem connInfo = (ConnectionItem)iter.next();
            if (!Boolean.valueOf(connInfo.getInactive()).booleanValue()) {
                String userid = connInfo.getDefaultUserid();
			    String passwd = connInfo.getDefaultPassword();
			    String driverClass = connInfo.getDriver();
			    String connUrl = connInfo.getUrl();
			    String displayName = connInfo.getDescription();
			    if (userid == null) userid = "";
			    if (passwd == null) passwd = "";
			    out.println("setScript(\""+userid+"\", \""+passwd+"\", \""+driverClass+"\", \""+connUrl+"\", \""+displayName+"\");");
			}
       }
   }
%>

</SCRIPT>
</head>
<body link=blue vlink=blue alink=blue onLoad="stopProcessing();setValues();changeSize();" onresize="changeSize()">
<center>
<%=PublicAPI.processingDiv(imagePath)%>
<form NAME="login"
      METHOD="POST"
      ACTION="<%=contextPath%>/action/Login"
      ENCTYPE="x-www-form-encoded">
<INPUT TYPE="hidden" NAME="informixserver" value="">
<INPUT TYPE="hidden" NAME="controller" value="Login">
<INPUT TYPE="hidden" NAME="size">
<p>
<% if (message != null) { %>
       <font color=crimson><%= message %></font><br>
<% } %>
<table class="loginOutTable">
<tr><td>

<TABLE ALIGN=center WIDTH=100% HEIGHT=100% BORDER=0 BGCOLOR="#D2E4FC" CELLPADDING=0 CELLSPACING=0>
<tr><td colspan=6>&nbsp;</td></tr>
<TR> 
     <td width=40><nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
     <td align=left colspan="2">
     <nobr><font FACE="Arial" color="#0000A0"><b>User ID</b></font>&nbsp;<INPUT TYPE="text" style="width:140px;border:1px #282828 solid" NAME="userid" VALUE=></nobr>
     <nobr>&nbsp;&nbsp;<font FACE="Arial" color="#0000A0"><b>Password</b></font>&nbsp;<INPUT style="width:140px;border:1px #282828 solid" TYPE="password" NAME="password"></nobr></td>
     <td align=left>
     <button id="connectB" type="button" onmouseover="changeColor('yellow');" onmouseout="changeColor('#C4C4FF');" value="Search the Web" onclick="okok();" style="width:90px; ">Connect</button>
     <!--  <nobr><a href="javascript:okok();" class="cssbutton2" style="width:90px" title="Connect to the database">&nbsp;&nbsp;&nbsp;Connect&nbsp;&nbsp;&nbsp;</a></nobr>-->
     </td>
     <td align=right> 
     <a href="javascript:window.history.back();" class="cssbutton" title="Back to previous page">&lt;Back</a><a href="javascript:helpWindow();" class="cssbutton" title="DB Cruiser login help">Help</a>
     </td>
     <td width=40><nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
</tr>
<TR><TD colspan=6>&nbsp</td></tr>

<TR>
     <td width=40><nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
<td colspan=4>
<table class=connectionTable CELLSPACING=0 width=100%>
<tr><td>
<table border=0 CELLSPACING=0><tr>
     <td align=left valign=top>
     <INPUT TYPE="radio" style="border:0;background-color:#D2E4FC" NAME="login_type" VALUE="from_list"">
     </td>
     <td colspan=4><font FACE="Arial" color="#0000CC"><b> Connect to selected database:</b></font></td>
</tr><tr>
     <td colspan=1>&nbsp;</td>
     <td clospan=3>

<SELECT id="list_dbname" name="list_dbname" style="border:1px solid;width:550px;height:300px;" size="50" OnChange="setUserid(this);" OnClick="setUserid(this); choose(0);"> 
<% if (connList != null) {
       for (Iterator iter = connList.iterator(); iter.hasNext();) {
            ConnectionItem connInfo  = (ConnectionItem)iter.next();
            if (!Boolean.valueOf(connInfo.getInactive()).booleanValue()) {
			    out.println("<option value="+connInfo.getId()+">"+connInfo.getDescription());
			}
       }
   }
%>
     </SELECT></td>
</tr></table>
</td></tr>
</table>
</td>
     <td width=40><nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
</tr>
<TR>
     <td width=40><nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
<td colspan=4>
<table class=productTable CELLSPACING=0 width=100%>
<tr><td>
<table border=0 CELLSPACING=0 align=center width=100%>
<tr>
<td align=left valign=top colspan=4 height=30><nobr>
	 <INPUT TYPE="radio" style="border:0;background-color:#D2E4FC" NAME="login_type" VALUE="manual">
	 <font FACE="Arial" color="#0000CC"><b> Use the following information to connect:</b>
	 </nobr>
</td>
</tr>
<TR> 
     <td width=20>&nbsp;</td>
     <td align=left><nobr><font FACE="Arial" color=navy>Connection URL:</font></nobr></td>
     <td align=left><INPUT OnClick="choose(1);"  TYPE="text" class="inputField" NAME="connURL" VALUE=></td> 
</TR>
<TR> 
     <td width=20>&nbsp;</td>
     <td align=left><nobr><font FACE="Arial" color=navy>JDBC Driver Class:</font></nobr></td>
     <td align=left><INPUT OnClick="choose(1);" TYPE="text" class="inputField" NAME="driverClass" VALUE=></td> 
</TR>
<TR> 
     <td width=20>&nbsp;</td>
     <td align=left><nobr><font FACE="Arial" color=navy>Database Name:</font></nobr></td>
     <td align=left><INPUT OnClick="choose(1);" TYPE="text" class="inputField" NAME="manualDBName" VALUE=></td> 
</TR>
</table>
</td></tr>
</table>

</td>
     <td width=40><nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
</tr>
<TR>
     <td width=40><nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
<td colspan=4>
<table class=productTable CELLSPACING=0 width=100%>
<tr><td>
<div id="shortbox"style="border:0px solid blue;">
<INPUT TYPE="radio" style="border:0;background-color:#D2E4FC" NAME="login_type" VALUE="universal" onclick="displayJdbcBox()">
	 <font FACE="Arial" color="#0000CC"><b> Choose a database product and a JDBC driver to connect:</b></font>
	 <img name=expandImg style="border:0px;" align="bottom" src="<%=imagePath%>/expand.gif" onclick="displayJdbcBox()">
	 <a href="http://maththinking.com/resourceDriver.html" target="_blank" title="Database products and JDBC drivers information"><img style="border:0px;" align="bottom" src="<%=imagePath%>/question.gif"></a>
</div>
<div id="jdbcbox" style="display:none;border:0px;">
<table border=0 CELLSPACING=0 align=center width=100%>
<tr>
     <td align=left valign=top colspan=4 height=30><nobr>
	 <INPUT TYPE="radio" style="border:0;background-color:#D2E4FC" NAME="login_type" VALUE="universal" >
	 <font FACE="Arial" color="#0000CC"><b> Choose a database product and a JDBC driver to connect:</b></font>
	 <img name=expandImg style="border:0px;" align="bottom" src="<%=imagePath%>/collapse.gif" border="0" onclick="hideJdbcBox()">
	 <a href="http://maththinking.com/resourceDriver.html" target="_blank" title="Database products and JDBC drivers information"><img style="border:0px;" align="bottom" src="<%=imagePath%>/question.gif"></a>
	 </nobr></td>
</tr>

<tr> 
     <td width=20>&nbsp;</td>
     <td align=left><nobr><font FACE="Arial" color=navy><nobr>Database Name</nobr></font></nobr></td>
     <td align=left><nobr>
	 <INPUT onclick="choose(3);" TYPE="text" class="inputFieldBase" style="width:180px;"  NAME="dbname" VALUE=>  
	 <font FACE="Arial" color=navy>Server/Hostname</font>
     <INPUT onclick="choose(3);" TYPE="text" class="inputFieldBase" style="width:180" NAME="host" VALUE=>
	 </nobr></td>
</tr>
<TR> 
     <td width=20>&nbsp;</td>
     <td align=left><nobr><font FACE="Arial" color=navy>Database Product:</font></nobr></td>
     <td align=left>
	 <SELECT name="db_product" class="inputFieldBase" style="width:334" OnChange="getDrivers();" OnClick="choose(3);" > 
<% ArrayList producstNames = info.getAllProducts();
   String defaultPorductName = null;
   if (producstNames != null) {
       int size = producstNames.size();
       if (size > 0) {
           defaultPorductName = (String)producstNames.get(0);
       }
       for (int i=0; i<size; i++) {
            String productName = (String)producstNames.get(i);
			if (productName.equals("MSSQLServer")) {
				out.println("<option value="+productName+">Microsoft SQL Server");
			} else if (productName.equals("PointBaseEmbededServerOption")) {
				out.println("<option value="+productName+">PointBase Embeded Server Option");
			} else if (productName.equals("HSQLServer")) {
				out.println("<option value="+productName+">HSQL Database Engine Server");
			} else {
				out.println("<option value="+productName+">"+productName);
			}
       } 
   }
%>
     </SELECT>
     &nbsp;<font FACE="Arial" color=navy>Port Number:</font>&nbsp;<INPUT OnClick="choose(3);" class="inputFieldBase" TYPE="text" SIZE="5" MAXLENGTH=5 NAME="port">
     </td>
</tr>
<TR> 
     <td width=20>&nbsp;</td>
     <td align=left><nobr><font FACE="Arial" color=navy>JDBC Driver:</font></nobr></td>
     <td align=left valign=top>
     <SELECT name="db_driver" class="inputFieldBase" style="width:334" OnClick="choose(3);">
<% if (defaultPorductName != null) {
       if (driverList != null) {
           for (Iterator iter = driverList.iterator(); iter.hasNext();) {
                DriverItem driver = (DriverItem)iter.next();
                String prodName = driver.getProduct();
                if (prodName.equals(defaultPorductName)) {
%>
       
                    <option value="<%=driver.getId()%>"><%=driver.getName()%>
<%              }
            }
        }
    }
%>
     </SELECT></td>
</tr>
</table>
</div>
</td></tr>
</table>
</td>
<td width=40><nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
</TR>
<tr><td colspan=6 style="height:18px">&nbsp;</td></tr>
</TABLE>
</td></tr>
</table>
<p>
<%=PublicAPI.loginCopyrightScript()%>
</form>
<SCRIPT LANGUAGE=JavaScript>
document.onkeydown=submitLoginForm;
function changeSize() {
   var contentBox = document.getElementById("list_dbname");
   var overhead = (jdbcboxOff)?290:360;
   //alert(overhead)
   if (window.innerWidth) { //if browser supports window.innerWidth
       contentBox.style.height=window.innerHeight-overhead;
   } else if (document.all) { //else if browser supports document.all (IE 4+)
       contentBox.style.height=document.body.clientHeight-overhead;
   }
}
function changeColor( bcolor) {
   var connBox = document.getElementById("connectB");
   connBox.style.background= bcolor;
}
function displayJdbcBox() {
   jdbcboxOff = false;
   setDisplay("shortbox","none");
   setDisplay("jdbcbox","block");
   changeSize();
}
function hideJdbcBox() {
   jdbcboxOff = true;
   setDisplay("shortbox","block");
   setDisplay("jdbcbox","none");
   changeSize();
}
function submitLoginForm(evt){
  if(document.all) {
     if(window.event.keyCode == 13){
        checkFields();
     }
  } else {
     if (getUnicode(evt) == 13) {
         checkFields();
     }
  }
}

//document.login.password.focus();
var lType      = document.login.login_type;
var base       = document.login.db_product;
var baseDriver = document.login.db_driver;
var listBase   = document.login.list_dbname;

function backToDriverList() {
   changeDiv();
   lType[1].checked = true;
   base[0].selected = true;
   getDrivers();
}

function changeDiv () {
   toggleInlineDisplay("driverList");
   toggleInlineDisplay("manualAccess");
}

function helpWindow() {
	var helpwin=dhtmlwindow.open('helpbox', 'iframe', '<%=jspPath%>/login_help.jsp', 'Login Help', 'width=750px,height=500px,resize=1,scrolling=1,center=1', 'blue');
}
function adminWindow() {
	var width = 730;
	var winl = (screen.width - width) / 2;
	openPopup("<%=contextPath%>/admin_login.jsp", "admin_panel<%=session.getId()%>", width, 550, 0, winl);
}

function getDrivers() {
   var prod = base.options[base.selectedIndex].value;
   var size = baseDriver.length;
   for (var i=0; i<size; i++) {
        baseDriver.options[i] = null;
   }
   var j = 0;
   for (var i=0; i<count; i++) {
        if (drivers[i].product == prod) {
            var entry = new Option();
            entry.value = drivers[i].id;
            entry.text  = drivers[i].name;
            baseDriver.options[j++] = entry;
        } 
   }
   setDrivers();
}

function setDrivers() {
   var driverValue = getCookie("driverValue")?getCookie("driverValue"):"0";
   var size = baseDriver.length;
   for (var i=0; i<size; i++) {
        if (baseDriver.options[i].value == driverValue) {
            baseDriver.options[i].selected = true;
        }
   }
}

function setUserid(list) {
   var myUserid = new String(connArray[list.selectedIndex].userid);
   if (myUserid != null && myUserid.length > 0) { 
       document.login.userid.value   = myUserid;
   }
   var myPassword = new String(connArray[list.selectedIndex].passwd);
   if (myPassword != null && myPassword.length > 0) { 
       document.login.password.value = myPassword;
   }
   var myDriverClass = new String(connArray[list.selectedIndex].driverClass);
   var myConnUrl = new String(connArray[list.selectedIndex].connUrl);
   var myDisplayName = new String(connArray[list.selectedIndex].displayName);
   document.login.connURL.value = myConnUrl;
   document.login.driverClass.value = myDriverClass;
   document.login.manualDBName.value = myDisplayName;
   
}

function checkFields() {  
   if (document.login.userid.value == "") {
       alert("Please enter User ID.");
       document.login.userid.focus();
       return false;
   }
   if (document.login.password.value == "") {
       if (!confirm("No password specified, continue?")) {
           document.login.password.focus();
           return false;
       } 
   }
   document.login.size.value = screen.width;
   var today   = new Date();
   var expires = new Date();
   expires.setTime(today.getTime() + 60*60*24*365*1000);
   var lTypeIndex = 0;
   var loginType = lType[0].value;
   if (lType[1].checked) {
       lTypeIndex = 1;
       loginType = lType[1].value;
   }
   if (lType[2].checked) {
       lTypeIndex = 2;
       loginType = lType[2].value;
   }
   if (loginType == "universal") {      
       if (!baseDriver.options || !baseDriver.options[baseDriver.selectedIndex]) {
           alert("Please select a JDBC driver.");
           document.login.db_driver.focus();
           return false;
       }
	        
       var dbtype   = base.options[base.selectedIndex].value;
       var dbdriver = baseDriver.options[baseDriver.selectedIndex].text;
	   if (document.login.dbname.value == "") {
		   if (!(dbtype == "Sybase" || dbtype == "MSSQLServer" || dbtype == "HypersonicSQLServer")) {
               alert("Please enter database name.");
               document.login.dbname.focus();
               return false;
		   } 
       }

       var msg = "DB Product: "+dbtype+"\n" +
                 "JDBC Driver: "+dbdriver+"\n" +
                 "DB Host: "+document.login.host.value+"\n" +
                 "Port: "+document.login.port.value+"\n" +
                 "DB Name: "+document.login.dbname.value+"\n" +
                 "User: "+document.login.userid.value;

	   if (dbtype == "Informix") {
           var ifxserv = document.login.informixserver.value;
           ifxserv = prompt("What is the INFORMIXSERVER?", ifxserv);
           while (ifxserv == "" || ifxserv == "null") {
                  alert("Please enter INFORMIXSERVER.");
                  ifxserv = prompt("What is the INFORMIXSERVER?", ifxserv);
           }
           if (confirm("INFORMIXSERVER="+ifxserv)) {
               setCookie("ifxServer", ifxserv,expires);
           } else {
               return false;
           }
       }  
	   //setCookie("host", document.login.host.value,expires);
       //setCookie("port", document.login.port.value,expires);
       //setCookie("dbname", document.login.dbname.value,expires);
       //setCookie("sIndex", base.selectedIndex,expires);  
       //setCookie("driverValue", baseDriver[baseDriver.selectedIndex].value,expires); 
   } else if (loginType == "manual") {
       if (isEmptyString(document.login.connURL.value)) {
	       alert("Please enter the connection URL.");
		   document.login.connURL.focus();
           return false;
	   }
	   if (isEmptyString(document.login.driverClass.value)) {
	       alert("Please enter the JDBC driver class.");
		   document.login.driverClass.focus();
           return false;
	   }
	   setCookie("connURL", document.login.connURL.value,expires);
       setCookie("driverClass", document.login.driverClass.value,expires);
	   if (!isEmptyString(document.login.manualDBName.value)) {
	       setCookie("manualDBName", document.login.manualDBName.value,expires);
	   }
	   /*
	   if (confirm("Do you want add this connection to the Connection List?")) {
	       adminWindow();
	   }*/
   } else {
	   if (!listBase || !listBase.length || listBase.length == 0) {
           if (confirm(addConnMsg)) {
		       adminWindow();
		   } else {
		       lType[1].checked = true;
		   }
           return false;
       }
       var listName = listBase.options[listBase.selectedIndex].text;
       var msg2 = "Database: "+listName+"\n"+
                  "User: "+document.login.userid.value;
	   setCookie("listIndex", listBase.selectedIndex,expires);
   } 
   
   setCookie("lTypeIndex", lTypeIndex,expires); 
   setCookie("userid", document.login.userid.value,expires);  
   startProcessingY(248);
   return document.login.submit();
}

function okok() { checkFields();}

function setValues() {
  document.login.userid.value = getCookie("userid")?getCookie("userid"):"myUser";
  document.login.host.value   = getCookie("host")?getCookie("host"):"myHost";
  document.login.port.value   = getCookie("port")?getCookie("port"):"";
  document.login.dbname.value = getCookie("dbname")?getCookie("dbname"):"myDBName";
  document.login.connURL.value = getCookie("connURL")?getCookie("connURL"):"";
  document.login.driverClass.value = getCookie("driverClass")?getCookie("driverClass"):"";
  document.login.manualDBName.value = getCookie("manualDBName")?getCookie("manualDBName"):"";
  document.login.informixserver.value = getCookie("ifxServer")?getCookie("ifxServer"):"";
  base.selectedIndex = getCookie("sIndex")?getCookie("sIndex"):"0";
  var lTypeIndex = getCookie("lTypeIndex")?getCookie("lTypeIndex"):"0";
  listBase.selectedIndex = getCookie("listIndex")?getCookie("listIndex"):"0";
  lType[lTypeIndex].checked=true;
  getDrivers();
}

var addConnMsg = "There is no connection defined in the list yet.\n\nYou may add connections via DB Cruiser Administration.\nOr use other ways below to connect.\n\nDo you want to add new connections now?";
</Script>
<%=PublicAPI.noRightClick()%>
</center>
</body>
</html>