<%@ include file="/jsp/inc/definitions.inc" %>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/input.css>
<title>Stored Procedures</title>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
</head>
<base target=tableListContent>
<body onload="changeSize()" onresize="changeSize()"> 
<center>

<FORM NAME="in_form" 
      ACTION="<%=contextPath%>/action/ProcedureList"
      target="tableListContent"
      METHOD="POST" >
<INPUT TYPE="hidden" NAME="connId" value="<%=connId%>">
<INPUT TYPE="hidden" NAME="processing_bar" value="true">
<INPUT TYPE="hidden" NAME="display_rows" value="100">
<table width=740 border=0 cellpadding=0 cellspacing=0>
<tr height=40>
<td align=left>
  <span class=tableInfo>Database:</span>
  <span class="mainDB"><%=db_name%></span>
</td>
<td align=right>
  <span class="mainTitle">Stored Procedures</span>
</td>
</tr>
</table>
<table width=740 BORDER=0>
<tr>
<td align=left><nobr>
    <span class="actionlabel">Schema:</span>
    <select name="schema" style="font-size:9px;width:210px;"><option value="all">ALL <%= PublicAPI.schemaList(connId) %></select>
	</nobr></td>
	<td align=left><nobr>
	<span class="actionlabel">Catalog:</span>
	<select name="catalog" style="font-size:9px;width:210px;"><option value="all">ALL <option value="">Without Catalog<%= PublicAPI.catalogList(connId) %></select>
	</nobr></td>
	<td align=right><nobr>
    <span class="actionlabel">Pattern:</span>
 <INPUT TYPE="text" style="font-size:9px;width:100px;" NAME="pattern" VALUE="%">
 <%=PublicAPI.button("javascript:checkFields();", "_self", "go", imagePath)%>
 <%=PublicAPI.button2(jspPath+"/procedure_list_output.jsp", "tableListContent", "help_icon", imagePath, "Show help on SQL Work Area")%>
</nobr></td>
</tr></table>

</FORM>
<iframe id='tableListContent' name='tableListContent' src='<%=actionPath%>/ProcedureListResult?connId=<%=connId%>&db_name=<%=db_name%>' frameborder='0' style='padding;margin:0px -20px 0px 0px;width:780px;height:400px;'></iframe>
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
document.in_form.pattern.focus();
schemaBase = document.in_form.schema;
catalogBase = document.in_form.catalog;
function checkFields() {  
    if ((document.in_form.pattern.value == "") || (document.in_form.pattern.value == " ")) {
		if (confirm('No pattern specified. Continue?')) {
			document.in_form.pattern.value = "%";
			submitRequest();
		} else {
            document.in_form.pattern.focus();
		}
    } else {
		submitRequest();
    }
}

function submitRequest() {
	var today   = new Date()
        var expires = new Date()
        expires.setTime(today.getTime() + 60*60*24*365*1000)
        setCookie("pattern", document.in_form.pattern.value,expires);
        setCookie("schemaIndex", schemaBase.selectedIndex,expires);
        setCookie("catalogIndex", catalogBase.selectedIndex,expires);
        //setCookie("rtdIndex", document.in_form.display_rows.selectedIndex,expires);
		if (window.tableListContent.startProcessing) {
	        window.tableListContent.startProcessing();
	    }
        document.in_form.submit();
}

var pattern = getCookie("pattern")?getCookie("pattern"):"%";
document.in_form.pattern.value = pattern;
var schemaIndex = getCookie("schemaIndex")?getCookie("schemaIndex"):"0";
if (schemaIndex < schemaBase.length) {
    schemaBase.selectedIndex = schemaIndex;
}
var catalogIndex = getCookie("catalogIndex")?getCookie("catalogIndex"):"0";
if (catalogIndex < catalogBase.length) {
    catalogBase.selectedIndex = catalogIndex;
}
document.in_form.display_rows.selectedIndex = getCookie("rtdIndex")?getCookie("rtdIndex"):"5";
</SCRIPT>

</body>
</html>
