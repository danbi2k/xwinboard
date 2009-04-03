<%@ include file="/jsp/inc/definitions.inc" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<% 
   //boolean isConnInfo = Boolean.valueOf(request.getParameter("isConnInfo")).booleanValue();
   boolean isWelcome = Boolean.valueOf(request.getParameter("welcome")).booleanValue();
   //String title = (isConnInfo)?"Connection Information":"About DB Cruiser";
   //String subtitle = (isConnInfo)?"About DB Cruiser":"Connection Information";
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
%>
<HTML> 
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/fk.css>
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/dhtmlwindow.css">
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/dhtmlwindow.js"></SCRIPT>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
<%=PublicAPI.licenseExpired(contextPath) %>
<%=PublicAPI.welcome(contextPath) %>
<TITLE>Connection Information</TITLE>
</HEAD>
<% if (Boolean.valueOf((String)session.getAttribute(PublicLabel.LICENSE_EXPIRED)).booleanValue()) {
       if (isWelcome) {
           out.println("<body onload='licenseExpiredWindow();welcomedWindow();'>");
       } else {
	       out.println("<body onload='licenseExpiredWindow();'>");
	   }
   } else {
       if (isWelcome) {
           out.println("<body onload='welcomedWindow();'>");
       } else {
           out.println("<body>");
       }
   }
%>
<center>
<table style="border:0px;height:15px"><tr><td></td></tr></table>
<table style="border:0px;width:748px">
<tr>
<td style="vertical-align:bottom">Database: <span class=mainDB><%=db_name%></span></td>
<td style="text-align:right"><span class=mainTitle>Connection Details</span></td>
</tr>
<tr><td>&nbsp;</td></tr>
</table>
<form>
<table style="border:0px">
<tr><td>
<display:table name="connInfo"  class="simple" >
    <display:column property="name" title="Attribute" style="width:200px"/>
    <display:column property="value" title="Value" />
</display:table>
</td></tr>
</table>
</form>
<p>
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
<table style="border:0px;width:748px">
<td align=left>
<div id="actcontainer">
<ul id="navlist">
<li><a href="javascript:window.history.back();" title="Back to previous page">&nbsp;<<&nbsp;Back&nbsp;&nbsp;</a></li>
 </ul>
 </div>
 &nbsp;&nbsp;&nbsp;&nbsp;
 </td>
<td><%=PublicAPI.copyrightStr0()%></td>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr></table>
<% if (isWelcome) {
   }
%>
</center>
