<%@ include file="/jsp/inc/definitions.inc" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<% 
   String schemaTerm = (String)request.getAttribute("schemaTerm");
   String catalogTerm = (String)request.getAttribute("catalogTerm");
   ArrayList schemaList = (ArrayList)request.getAttribute("schemaList");
   ArrayList catalogList = (ArrayList)request.getAttribute("catalogList");
   Integer schemaCount = (Integer)request.getAttribute("schemaCount");
   Integer catalogCount = (Integer)request.getAttribute("catalogCount");
   String tablename = (String)request.getAttribute(PublicLabel.TABLENAME);
   if (tablename == null) {
       tablename = request.getParameter(PublicLabel.TABLENAME);
   }
   String display = (String)request.getParameter("display");  
%>
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/fk.css>
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
<TITLE>Database Schemas and Catalogs</TITLE>
</HEAD>

<body>
<center>
<table style="border:0px;height:15px"><tr><td></td></tr></table>
<table style="border:0px;width:665px">
<tr>
<td style="vertical-align:bottom">Database: <span class=mainDB><%=db_name%></span></td>
<td style="text-align:right"><span class=mainTitle>Schemas/Catalogs</span></td>
</tr>
</table>
<form>
<table style="border:0px">
<tr><td>
<table style="border:0px">
<tr><td>&nbsp;</td></tr>
<tr>
<td>Schema Term: <span class=mainDB><%=schemaTerm%></span></td>
<td style="text-align:right">Number of Schems: <span class=mainDB><%=schemaCount.intValue()%></span></td>
</tr>
</table>
</td></tr>
<tr><td>
<% if (schemaList.size() == 0) { %>
<table class="greyTable"><tr><td>
There is no any schema.
</td></tr></table>
<% } else { %>
<display:table name="schemaList"  decorator="com.maththinking.dbcruiser.SchemaDecorator" class="simple" >
    <display:column property="first" title="&nbsp;" style="width:20%"/>
    <display:column property="second" title="&nbsp;" style="width:20%"/>
    <display:column property="third" title="&nbsp;" style="width:20%"/>
    <display:column property="fourth" title="&nbsp;" style="width:20%"/>
    <display:column property="fifth" title="&nbsp;" style="width:20%"/>
</display:table>
<% } %>
</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>
<table style="border:0px">
<tr><td>&nbsp;</td></tr>
<tr>
<td>Catalog Term: <span class=mainDB><%=catalogTerm%></span></td>
<td style="text-align:right">Number of Catalogs: <span class=mainDB><%=catalogCount.intValue()%></span></td>
</tr>
</table>
</td></tr>
<tr><td>
<% if (catalogList.size() == 0) { %>
<table class="greyTable"><tr><td>
There is no any catalog.
</td></tr></table>
<% } else { %>
<display:table name="catalogList"  decorator="com.maththinking.dbcruiser.CatalogDecorator" class="simple" >
    <display:column property="first" title="&nbsp;" style="width:20%"/>
    <display:column property="second" title="&nbsp;" style="width:20%"/>
    <display:column property="third" title="&nbsp;" style="width:20%"/>
    <display:column property="fourth" title="&nbsp;" style="width:20%"/>
    <display:column property="fifth" title="&nbsp;" style="width:20%"/>
</display:table>
<% } %>
</td></tr>
</table>
</form>
<p>
<table style="border:0px;width:660px">
<tr><td colspan=2 height=10></td></tr>
<tr><td colspan=2 style="text-align:center">
<%=PublicAPI.button("javascript:window.history.back();", "_self", "back_small", imagePath)%>
</td></tr>
<tr><td colspan=2 height=10></td></tr>
<tr>
<td><%=PublicAPI.copyrightStr()%></td>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr></table>
</center>
