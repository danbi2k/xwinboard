<%@ include file="/jsp/inc/definitions.inc" %>
<% 
    //boolean queryBuilder = Boolean.valueOf(request.getParameter("queryBuilder")).booleanValue();
    //String db_product = (String)session.getValue("db_product");
    boolean isWelcome = Boolean.valueOf(request.getParameter("welcome")).booleanValue();
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/basic.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/input.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/dhtmlwindow.css">
<script type="text/javascript" src="<%=contextPath%>/scripts/dhtmlwindow.js"></script>
<script type="text/javascript" src="<%=contextPath%>/scripts/common.js"></script>
<%=PublicAPI.licenseExpired(contextPath) %>
<%=PublicAPI.welcome(contextPath) %>
<title>List Tables</title>
</head>
<base target=tableListContent>
 
<% if (Boolean.valueOf((String)session.getAttribute(PublicLabel.LICENSE_EXPIRED)).booleanValue()) {
       if (isWelcome) {
           out.println("<body onload='changeSize();licenseExpiredWindow();welcomedWindow();' onresize='changeSize()'>");
       } else {
	       out.println("<body onload='changeSize();licenseExpiredWindow();' onresize='changeSize()'>");
	   }
   } else {
       if (isWelcome) {
           out.println("<body onload='changeSize();welcomedWindow();' onresize='changeSize()'>");
       } else {
           out.println("<body onload='changeSize()' onresize='changeSize()'>");
       }
   }
%>
<center>
<form NAME="in_form" 
      ACTION="<%=actionPath%>/TableList"
      target="tableListContent"
      METHOD="POST" >
<input TYPE="hidden" NAME="connId" value="<%=connId%>">
<input TYPE="hidden" NAME="processing_bar" value="true">
<input TYPE="hidden" NAME="display_rows" value="100">
<table width=740px border=0 cellpadding=0 cellspacing=0>
<tr height=30>
<td align=left>
  <span class=tableInfo>Database:</span>
  <span class="mainDB"><%=db_name%></span>
</td>
<td align=right>
  <span class="mainTitle">Table Explorer</span>
</td>
</tr>
</table>
<% if (browser.indexOf("MSIE") > 0) {%>
<div style='width:740px;padding:5px 10px 5px 10px;margin:0px;border:1px dotted #483D8B;'>
<% } else {%>
<div style='width:720px;padding:5px 10px 5px 10px;margin:0px;border:1px dotted #483D8B;'>
<% } %>
<TABLE BORDER=0 width=710px align=center>
<TR>

<td align=left><nobr>

	<span class="actionlabel">Schema:</span>
    <select name="schema" style="font-size:9px;width:260px;"><option value="all">ALL <%= PublicAPI.schemaList(connId) %></select> 
	</nobr></td>
   <td align=right><nobr>
   
        
        
	    <span class="actionlabel">Type:</span>
        <select name="type" style="font-size:9px;width:200px;"><option value="all">ALL <%= PublicAPI.typeList(connId) %></select>
</nobr></td> 
<td align=right>
<a href="<%=jspPath%>/table_list_output.jsp" target="tableListContent" class="cssbutton" style="width:100px">&nbsp;&nbsp;&nbsp;&nbsp;Help&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
</td>  
</TR>
<TR>
<td valign=botttom align=left><nobr>	
	<span class="actionlabel">Catalog:</span>
    <select name="catalog" style="font-size:9px;width:260px;"><option value="all">ALL <%= PublicAPI.catalogList(connId) %></select> 
	</nobr></td>
    <td valign="botttom" align="right">
    <span class="actionlabel">Pattern:</span>
    <INPUT TYPE="text" style="font-size:9px;width:200px;" NAME="pattern" VALUE=> 
</td>
<td align=right>
<a href="javascript:checkFields();" target="_self" class="cssactionbutton">Get Tables</a>
</td>  
</TR>
</TABLE>
</div>
</form>
<iframe id='tableListContent' name='tableListContent' src='<%=actionPath%>/TableListResult?connId=<%=connId%>&queryBuilder=<%=request.getParameter("queryBuilder")%>' frameborder='0' style='margin:-10px -20px 0px 0px;width:780px;height:350px;'></iframe>
</center>

<SCRIPT LANGUAGE="JavaScript">
function changeSize() {
   var contentBox = document.getElementById("tableListContent");
   var overhead = 140;
   if (window.innerWidth) { //if browser supports window.innerWidth
       contentBox.style.height=window.innerHeight-overhead;
   } else if (document.all) { //else if browser supports document.all (IE 4+)
       contentBox.style.height=document.body.clientHeight-overhead;
   }
}
schemaBase = document.in_form.schema;
typeBase   = document.in_form.type;
rtdBase    = document.in_form.display_rows;
catalogBase = document.in_form.catalog;
function checkFields()
{
    var today   = new Date();
    var expires = new Date();
    expires.setTime(today.getTime() + 60*60*24*365*1000);
    setCookie("schemaIndex", schemaBase.selectedIndex,expires);
    setCookie("typeIndex",   typeBase.selectedIndex,expires);
    //setCookie("rtdIndex",    rtdBase.selectedIndex,expires);
    setCookie("pattern",     document.in_form.pattern.value,expires);
    setCookie("catalogIndex", catalogBase.selectedIndex,expires);
	
	if (window.tableListContent.startProcessing) {
	    window.tableListContent.startProcessing();
	}
    return document.in_form.submit();
}

var schemaIndex = getCookie("schemaIndex")?getCookie("schemaIndex"):"0";
if (schemaIndex < schemaBase.length) {
    schemaBase.selectedIndex = schemaIndex;
}
var typeIndex   = getCookie("typeIndex")?getCookie("typeIndex"):"0";
if (typeIndex < typeBase.length) {
    typeBase.selectedIndex   = typeIndex;
}
var rtdIndex    = getCookie("rtdIndex")?getCookie("rtdIndex"):"5";
if (rtdIndex < rtdBase.length) {
    rtdBase.selectedIndex = rtdIndex;
}
var catalogIndex = getCookie("catalogIndex")?getCookie("catalogIndex"):"0";
if (catalogIndex < catalogBase.length) {
    catalogBase.selectedIndex = catalogIndex;
}
var pattern     = getCookie("pattern")?getCookie("pattern"):"";
document.in_form.pattern.value = pattern;

</SCRIPT>

</body>
</html>
