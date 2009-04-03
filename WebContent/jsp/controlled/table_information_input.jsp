<%@ include file="/jsp/inc/definitions.inc" %>
<% 
   //boolean isNewRequest = Boolean.valueOf(request.getParameter("isNewRequest")).booleanValue();
   boolean hasSchema = ((Boolean)request.getAttribute(PublicLabel.HAS_SCHEMA)).booleanValue();
   boolean hasCatalog = ((Boolean)request.getAttribute(PublicLabel.HAS_CATALOG)).booleanValue();
   String schemas = (String)request.getAttribute(PublicLabel.SCHEMAS);
   String catalogs = (String)request.getAttribute(PublicLabel.CATALOGS);
   String currSchema = (String)request.getAttribute(PublicLabel.CURR_SCHEMA);
   String currCatalog = (String)request.getAttribute(PublicLabel.CURR_CATALOG);
   String tables = (String)request.getAttribute(PublicLabel.TABLES);
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/input.css>
<title>Table Definitions</title>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/choose_rows.js"></SCRIPT>
</head>
<base target=tableOut>
<body OnLoad="setDisplay('rowList','none');setValues();">
<center>
<FORM NAME="inputForm" 
      ACTION="<%=actionPath%>/TableColumnDefinition"
      METHOD="POST" >
<INPUT TYPE="hidden" NAME="actionPath" VALUE="<%=actionPath%>/">
<INPUT TYPE="hidden" NAME="connId" VALUE="<%=connId%>">
<INPUT TYPE="hidden" NAME="processing_bar">
<INPUT TYPE="hidden" NAME="ejb">
<INPUT TYPE="hidden" NAME="query">
<INPUT TYPE="hidden" NAME="tableInfoWindow" value="true">
<INPUT TYPE="hidden" NAME="isNewRequest" value="true">
<INPUT TYPE="hidden" NAME="maxRows" value="0">
<TABLE BORDER=0>

<TR height=35>
<TD align=left valign=bottom><nobr>
<span class=tableInfo>Table</span>
<!--
<INPUT STYLE="font-size:9px;width:200;" TYPE=text NAME=tablename>
-->
<select name="tablename" style="width:235"><%=tables%></select>
<% if (hasSchema) { %>
<span class=tableInfo>Schema</span>
<select name="schema" style="width:150" OnChange="getTables();"> <%=schemas%><option value="all">ALL</select>  
<% } else if (hasCatalog) { %>
<span class=tableInfo>Catalog</span>
<select name="catalog" style="width:150" OnChange="getTables();"> <%=catalogs%><option value="all">ALL</select>
<% } %>
<%=PublicAPI.button2("javascript:refreshTSC();", "_self", "refresh_tiny", imagePath, "Refresh the Schema/Catalog and Table list")%>
</nobr></TD>
<TD align=right valign=bottom><nobr>
<span class="mainTitle">Browse Tables</span>
</nobr></TD>
</TR>
<%=PublicAPI.tableInfoMenu(contextPath)%> 
</TABLE>
<%=PublicAPI.chooseMaxRows(imagePath, "rowList", "setMaxRows")%>
</FORM>
</center>
<%=PublicAPI.fetchTableDiv(imagePath)%>
<SCRIPT LANGUAGE="JavaScript">
var actionPrefix = document.inputForm.actionPath.value;
var today   = new Date()
var expires = new Date()
expires.setTime(today.getTime() + 60*60*24*365*1000)
    
function getTables() {
   document.inputForm.action = actionPrefix+'SetSchemaCatalog';
   document.inputForm.target = "_self";
<% if (hasSchema) { %>
       setCookie("schema", document.inputForm.schema.value,expires);
<% } else if (hasCatalog) { %>
       setCookie("catalog", document.inputForm.catalog.value,expires);
<% } %>
   setTableValues();
   startFetching();
   document.inputForm.submit(); 
}

function refreshTSC() {
   document.inputForm.controller.value = "RefreshTableSchemaCatalog";
   document.inputForm.target = "_self";
   startFetching();
   document.inputForm.submit(); 
}

function showFAQ() {
	alert("Coming soon, please check the newest version.");
}

function setMaxRows(num) {
    document.inputForm.maxRows.value = num;
    check_fields("ViewTable");
	setDisplay("rowList","none");
}

function loadData() {
	var today = new Date();
    var width = 550; 
    var winl = (screen.width - width) / 2; 	centerPopup('<%=actionPath%>ControlServlet?controller=LoadData&tablename='+document.inputForm.tablename.value+'&id='+today.getTime(), 'load_data', width, 410, 0, winl); 
}

function later() {
    alert("This function will be implement later.");
    return false;
}

function setEJB(flag) {
    document.inputForm.ejb.value = flag;
}

function checkFields(act) {
	check_fields(act);
}

function check_fields(act) {
    var table = document.inputForm.tablename.value;
    if (table == "") {
        alert("Please enter table name");
        document.inputForm.tablename.focus();
        return false;
    }
    
	if (parent.tableOut.startProcessing) {
        parent.tableOut.startProcessing();
	}

    setQuery(table);

    document.inputForm.action = actionPrefix+act;
    setCookie("tablename", document.inputForm.tablename.value,expires);
    
<% if (hasSchema) { %>
       setCookie("schema", document.inputForm.schema.value,expires);
<% } else if (hasCatalog) { %>
       setCookie("catalog", document.inputForm.catalog.value,expires);
<% } %>
	
    return document.inputForm.submit();
}

function setQuery(table) {
    var query = "select * from "+table;
    document.inputForm.query.value = query;   
}

function setValues() {
<% if (hasSchema) { %>
       var sschema = document.inputForm.schema;
       for (var i=0; i<sschema.length; i++) {
		    if (sschema.options[i].value == "<%=currSchema%>") {
                sschema.options[i].selected = true;
		    }
       }
<% } else if (hasCatalog) { %>
       var scatalog = document.inputForm.catalog;
       for (var i=0; i<scatalog.length; i++) {
		    if (scatalog.options[i].value == "<%=currCatalog%>") {
                scatalog.options[i].selected = true;
		    }
       }
<% } %>
   setTableValues();
}
var tablename = getCookie("tablename")?getCookie("tablename"):"SCOTT.EMP";
function setTableValues() {
   var sTable = document.inputForm.tablename;
   if (sTable) {
       for (var i=0; i<sTable.length; i++) {
		    if (sTable.options[i].value == tablename) {
                sTable.options[i].selected = true;
		    }
       }
   }
}

</SCRIPT>
</body>
</html>
