<%@ include file="/jsp/inc/definitions.inc" %>
<% 
   //String db_product = (String)session.getAttribute("db_product");
   String mark = " ";
   String inStr = "";
   String committed = "true";
   StringBuffer inputStringBuf = (StringBuffer)session.getAttribute(PublicLabel.SQL_WORK_OUTPUT);
   if (inputStringBuf != null) {
       inStr = inputStringBuf.toString();
       mark = "";
       if (inStr.indexOf("Modification has committed") >= 0 || 
           inStr.indexOf("COMMIT executed successfully") >= 0 ||
           inStr.indexOf("ROLLBACK executed successfully") >= 0) {
           committed = "true";
       } else {
           if (inStr.indexOf("<font color=crimson><b>NOT</b></font> <b>been committed</b>") >= 0) {
               committed = "false";
           }
       } 
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
<link rel=stylesheet href=<%=contextPath%>/styles/sw.css>
<title>SQL Work Sheet</title>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
<style>
a {text-decoration:none}
a:hover {color: red}
#SQLScripts {
  width:100%;
  height: 130;
  border: 0px solid navy;
  text-align:left;
  padding: 15px 5px 5px 0px;
}
body {
  margin-bottom: 0px;
  padding-bottom: 0px;
}
</style>
</head>
<!--  <base target=query_out> -->
<body onload="changeSize();refrechQueryResultList()" onresize="changeSize();"> 
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
<td align=left width=200px>
<span class="mainTitle">SQL Work Output</span>
</td>
</tr>
<tr>
<td align=left>
<div id="navcontainer">
<ul id="navlist">
<li><a href="javascript:goBack();" title="Back to previous page" target="_self">Back</a></li>
<li><a href="javascript:goBack();" target="_self" title="Back to SQL Work Area">SQL Work Area</a></li>
<li><a href="javascript:queryResult();" target="_self" title="Display the latest query result in SQL Work Area">Last Result</a></li>
<li><a href="javascript:setAction('Rollback');" target="_self" title="Rollback the data modification">Rollback</a></li>
<li><a href="javascript:setAction('Commit');" target="_self" title="Commit the data modification">Commit</a></li>
<li><a href="<%=actionPath%>/SQLWorkSaveOutput?connId=<%=connId%>" target="_self" title="Save the output to a HTML file">Save</a></li>
</ul>
</div> 
</td>
</tr>
<tr><td colspan=2>
<!--
<TABLE width=100% border=0 cellpadding=0 cellspacing=0>
  
<TR><TD>
<table border=0 cellpadding=0 cellspacing=0 vspace=0 width=100%><tr>
<td align=left valign=bottom><nobr>
       <b>SQL Statements</b> 
</nobr></td> 
</tr></table>
</TD></TR>
<TR><TD align=center>
-->

<DIV ID="SQLScripts" NAME="sqlstatement" WRAP="SOFT"><%=inStr%></DIV>
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

<SCRIPT LANGUAGE="JavaScript"> 
committed = '<%=committed%>';

function goBack() {
  if (committed == 'false') {
      if (confirm('The modification has not been committed or rollback.\nAre you sure you want to leave?')) {
          window.location="<%=contextPath%>/jsp/controlled/sql_work.jsp?connId=<%=connId%>&db_name=<%=db_name%>";
      }
  } else {
      window.location="<%=contextPath%>/jsp/controlled/sql_work.jsp?connId=<%=connId%>&db_name=<%=db_name%>";
  }   
}
<% out.println(PublicAPI.sqlworkScript(imagePath)); %>

function changeSize() {
   //alert('changeSize');
   var topBox = document.getElementById("topContainer");
   var textBox = document.getElementById("SQLScripts");
   //var fileBox = document.getElementById("fileIn");
   var verticalOverHead=105;
   if (window.innerWidth) { //if browser supports window.innerWidth
       topBox.style.width=0.9*window.innerWidth;
       textBox.style.height=window.innerHeight-(verticalOverHead+12);
   } else if (document.all) { //else if browser supports document.all (IE 4+)
       topBox.style.width=0.9*document.body.clientWidth;
       textBox.style.height=document.body.clientHeight-verticalOverHead;
   }
}

function refrechQueryResultList() {
  if (window.top.refrechResultItems) {
      window.top.refrechResultItems();
  } else if (window.opener.top.refrechResultItems) {
      window.opener.top.refrechResultItems();
  }
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
</SCRIPT>
</body>
</html>