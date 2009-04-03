<%@ include file="/jsp/inc/definitions.inc" %>
<% 
   //String db_product = (String)session.getAttribute("db_product");
   String mark = " ";
   String input_string = (String)session.getAttribute("input_string");
   if (input_string == null) {
       input_string = "";
       mark = "";
   }
%>

<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/input.css>
<link rel=stylesheet href=<%=contextPath%>/styles/fk.css>
<link rel=stylesheet href=<%=contextPath%>/styles/menu.css>
<link type="text/css" rel=stylesheet href="<%=contextPath%>/styles/dhtmlwindow.css">
<script type="text/javascript" src="<%=contextPath%>/scripts/common.js" ></script>
<script type="text/javascript" src="<%=contextPath%>/scripts/dhtmlwindow.js" ></script>
<script type="text/javascript" src="<%=contextPath%>/scripts/prototype.js" ></script>
<%=PublicAPI.licenseExpired(contextPath) %>
<style type="text/javascript">
a {text-decoration:none}
a:hover {color: red}

.actbutton{
color: #ffffff;
background-color: #8080C0;
border-style: outset;
}

body {
  margin-bottom: 0px;
  padding-bottom: 0px;
}
</style>
<title>SQL Work Sheet</title>
</head>
<% if (Boolean.valueOf((String)session.getAttribute(PublicLabel.LICENSE_EXPIRED)).booleanValue()) {
	   out.println("<body onload='changeSize();licenseExpiredWindow();' onresize='changeSize();'>");
   } else {
       out.println("<body onload='changeSize();' onresize='changeSize();'>");
   }
%>
<center>
<%=PublicAPI.processingDiv(imagePath)%>
<form NAME   = "in_form"
      METHOD = "POST"
      ACTION = "<%=actionPath%>/SQLWork";
>
<INPUT TYPE="hidden" NAME="connId" value="<%=connId%>">
<INPUT TYPE="hidden" NAME="processing_bar" value="false">
<INPUT TYPE=hidden NAME="execute_action">
<INPUT TYPE=hidden name=instring value="<%= mark %>">
<INPUT TYPE=hidden name=string_to_save>
<INPUT TYPE=hidden name=statement>
<INPUT TYPE=hidden name=fromSqlWorkWindow value=true>
<INPUT TYPE=hidden name=tablename value="SQLWork">
<INPUT TYPE=hidden name="display_rows" value="100">

<INPUT TYPE=hidden name=file_to_save value="sql_work_input.txt">
<table width=90% border=0 cellpadding=0 cellspacing=0 id="topContainer" name="topContainer">
<tr height=35>
<td align=left>
  <span class="mainTitle">SQL Work Area</span>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <span class="tableInfo">Database:</span>
  <span class="mainDB"><%=db_name%></span>
</td>
</tr>
<tr><td>
<div id="navcontainer">
<ul id="navlist">
<li><input type="checkbox" NAME="auto_commit" CHECKED VALUE="true"> <span style="font-size:12;">Auto Commit&nbsp;</span>&nbsp;</li>
<li><a href="javascript:window.history.back();" title="Back to previous page" target="_self">Back</a></li>
<li><a href="<%=contextPath%>/jsp/controlled/sql_work_output.jsp?connId=<%=connId%>&db_name=<%=db_name%>" target="_self" title="View last output of execution">Output</a></li>
<li><a href="javascript:historyPopup(750, 550);" target="_self" title="View all the SQL statements executed before">History</a></li>
<li><a href="javascript:helpWindow();" title="Display the help for SQL Work Area">Help</a></li>
<li><a href="javascript:checkFields();" target="_self" style="color:#ffffff;background-color:#8080C0;" title="Execute all or highlighted SQL statements">Execute</a></li>
<li><a href="javascript:setAction('Rollback');" target="_self" title="Rollback the data modification">Rollback</a></li>
<li><a href="javascript:setAction('Commit');" target="_self" title="Commit the data modification">Commit</a></li>
<li><a href="javascript:clearStatement();" target="_self" title="Clear all the statements">Clear</a></li>
<li><a href="javascript:saveToFile();" target="_self" title="Save SQL statements to a local file">Save</a></li>
<li><a href="javascript:uploadInput();" target="_self" title="Open an SQL script file">Open</a></li>
<li><INPUT id="fileIn" TYPE="file" style="width:0px;height:19px;border:1px solid grey;" size="1" NAME="filename" onchange="uploadInput()"></li>
</ul>
</div> 
</td></tr>
<tr><td>
<TABLE width=100% BORDER=0>
<!--  
<TR><TD>
<table border=0 cellpadding=0 cellspacing=0 vspace=0 width=100%><tr>
<td align=left valign=bottom><nobr>
       <b>SQL Statements</b> 
</nobr></td> 
</tr></table>
</TD></TR>
-->
<TR><TD align=center>
<textarea id="SQLScripts" style="width:100%;height:130px;word-wrap:soft;border:1px solid grey;" NAME="sqlstatement" WRAP="soft"><%=input_string%></textarea>
</TD></TR>
</TABLE>
</td></tr>
<tr><td>
<table style="border:0px;padding:0px;margin:0px;width:748px">
<tr>
<td><%=PublicAPI.copyrightStr()%></td>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr></table>
</td></tr>
</table>
</FORM>
</center>
<%=PublicAPI.getHighlightedScript()%>
<script language="javascript">
<% out.println(PublicAPI.sqlworkScript(imagePath)); %>

function helpWindow() {
	var helpwin=dhtmlwindow.open('helpbox', 'iframe', '<%=jspPath%>/sql_work_help.jsp', 'SQL Work Area Help', 'width=750px,height=400px,resize=1,scrolling=1,center=1', 'blue');
}
function changeSize() {
   //alert('changeSize');
   var topBox = document.getElementById("topContainer");
   var textBox = document.getElementById("SQLScripts");
   var fileBox = document.getElementById("fileIn");
   //topBox.style.width=200;
   if (window.innerWidth) { //if browser supports window.innerWidth
       topBox.style.width=0.9*window.innerWidth;
       textBox.style.height=window.innerHeight-106;
       //fileBox.style.width=window.innerWidth-600;
   } else if (document.all) { //else if browser supports document.all (IE 4+)
       topBox.style.width=0.9*document.body.clientWidth;
       textBox.style.height=document.body.clientHeight-105;
       //fileBox.style.width=document.body.clientWidth-650;
   }
}

function clearStatement() {
   document.in_form.sqlstatement.value = "";
   document.in_form.sqlstatement.focus();
}

function setAction(act) {
   restoreTextSize();
   document.in_form.execute_action.value = act;
   document.in_form.processing_bar.value = "false";
   document.in_form.submit();
}

function queryResult() {
   document.in_form.action="<%=actionPath%>/TableLastQueryResult";
   document.in_form.submit();
   document.in_form.action="<%=actionPath%>/SQLWork";
}

function saveToFile() {
   document.in_form.action ="<%=actionPath%>/SaveToFile";
   document.in_form.string_to_save.value=document.in_form.sqlstatement.value;
   document.in_form.submit();
   document.in_form.action = "<%=actionPath%>/SQLWork";
<% if (browser != null && ((browser.indexOf("MSIE 5.5") != -1) || (browser.indexOf("MSIE 6") != -1))) { %>
       //setTimeout("saveAnnounce()", 6000);
       //document.location.reload();
<% } %>
   //return false;
}

function saveAnnounce() {
	var msg = "If something doesn't function properly after saving statements, \n"+
		      "please click \"SQL Work Area\" on the left-hand menu bar, \n"+
		      "or click the \"Refresh\" or \"Reload\" button of the browser."; 
	alert(msg);
}

function uploadInput() {
    document.in_form.action = "<%=actionPath%>/SQLWorkOpenSQL";
    document.in_form.target = "_self";
    document.in_form.encoding = "multipart/form-data";
    
    if (document.in_form.filename.value == "") {
        alert("No file specified.\n\nUse \"Browse...\" button to select an input file.");
        document.in_form.filename.focus();
    } else {  
        document.in_form.submit();
    }
}

function historyPopup(width, height, top, left) {
   var url = '<%=actionPath%>/SQLWorkHistory?history_name=sql_work_history&history_title=SQL%20Work%20History&formname=in_form&fieldname=sqlstatement';
   historywin=dhtmlwindow.open('historybox', 'iframe', url, 'SQL Work History', 'width=750px,height=480px,resize=1,scrolling=1,center=0', 'blue');
}

qrtdBase = document.in_form.display_rows;
acBase   = document.in_form.auto_commit;

function checkFields() { 
	restoreTextSize();
    document.in_form.execute_action.value = "";   
    if (document.in_form.sqlstatement.value == "") {
        alert("Please enter SQL statement");
        document.in_form.sqlstatement.focus();
        return false;
    }
	var stmt = trimLead(document.in_form.sqlstatement.value);
	stmt.toLowerCase();
    //document.in_form.controller.value="SQLWork";
    var today   = new Date()
    var expires = new Date()
    expires.setTime(today.getTime() + 60*60*24*365*1000)
    setCookie("sqlstatement", document.in_form.sqlstatement.value,expires);
    //setCookie("qrtdIndex", qrtdBase.selectedIndex,expires);
	if (acBase.checked == true) {
        setCookie("acBaseChecked", "true", expires);
	} else {
        setCookie("acBaseChecked", "false", expires);
	}
	//if ((stmt.indexOf("select") == 0) || (stmt.indexOf("update") == 0) || (stmt.indexOf("delete") == 0)) {
		//if (parent.query_out.startProcessing) {
	        //parent.query_out.startProcessing();
	    //}
	//}
	startProcessing();
	if (getHighlighted(document.in_form.sqlstatement) == "") document.in_form.statement.value = document.in_form.sqlstatement.value;
	else document.in_form.statement.value = getHighlighted(document.in_form.sqlstatement);
    document.in_form.submit(); 
}

if (document.in_form.instring.value == "" ) {
    var sqlstatement = getCookie("sqlstatement")?getCookie("sqlstatement"):"select * from hr.employees";
    document.in_form.sqlstatement.value = sqlstatement;
}
qrtdBase.selectedIndex = getCookie("qrtdIndex")?getCookie("qrtdIndex"):"5";
var acBaseCheckedValue = getCookie("acBaseChecked")?getCookie("acBaseChecked"):"false";
if (acBaseCheckedValue == "true") {
    acBase.checked = true;
} else {
    acBase.checked = false;
}
<% if (Boolean.valueOf(info.get("use_float_menu")).booleanValue()) { %>
function fillSql() {
   var myAjax = new Ajax.Request('<%=contextPath%>/scripts/hr.sql',   
                   {  method:'get',     
                      onSuccess: function(transport){       
                         var response = transport.responseText || "select * from hr.employees; select * from hr.departments;"; 
                         var textBox = document.getElementById("SQLScripts");
                         textBox.value = response;
                      },     
                      onFailure: function(){ alert('Something went wrong...'); 
                      }   
                    });
}
fillSql();
<% } %>
</script>
</body>
</html>