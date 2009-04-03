<%@ include file="/jsp/inc/definitions.inc" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<% 
   String productName = (String)request.getAttribute("productName");
   String schemaTerm = (String)request.getAttribute("schemaTerm");
   String numberOfKewords = (String)request.getAttribute("numberOfKewords");
   ArrayList keywordList = (ArrayList)request.getAttribute("keywordList");
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
<link type="text/css" rel=stylesheet href="<%=contextPath%>/styles/dhtmlwindow.css">
<script type="text/javascript" src="<%=contextPath%>/scripts/dhtmlwindow.js"></script>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
<%=PublicAPI.licenseExpired(contextPath) %>
<TITLE>Database Schemas and Catalogs</TITLE>
</HEAD>
<% if (Boolean.valueOf((String)session.getAttribute(PublicLabel.LICENSE_EXPIRED)).booleanValue()) {
	   out.println("<body onload='licenseExpiredWindow();'>");
   } else {
      out.println("<body>");
   }
%>
<center>
<table style="border:0px;height:15px"><tr><td></td></tr></table>
<table style="border:0px;width:748px">
<tr>
<td style="vertical-align:bottom">Database: <span class=mainDB><%=db_name%></span></td>
<td style="text-align:right"><span class=mainTitle>Product Specific SQL Keywords</span></td>
</tr>
<tr><td>&nbsp;</td></tr>
</table>
<form>
<table style="border:0px">
<tr><td>
<table style="border:0px">
<tr>
<td>Product: <span style="color:darkgreen;font-weight:bold"><%=productName%></span></td>
<td style="text-align:right">Number of Keywors: <span style="color:darkgreen;font-weight:bold"><%=numberOfKewords%></span></td>
</tr>
</table>
</td></tr>
<tr><td>
<% if (keywordList.size() == 0) { %>
<table><tr><td>
There is no any SQL keyword.
</td></tr></table>
<% } else { %>
<display:table name="keywordList" class="simple" >
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
</center>
