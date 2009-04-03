<%@ include file="/jsp/inc/definitions.inc" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<% 
   String productName = (String)request.getAttribute("productName");
   ArrayList numericList = (ArrayList)request.getAttribute("numericList");
   ArrayList timeDateList = (ArrayList)request.getAttribute("timeDateList");
   ArrayList systemcList = (ArrayList)request.getAttribute("systemcList");
   ArrayList stringList = (ArrayList)request.getAttribute("stringList");
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
<TITLE>Connection Information</TITLE>
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
<td style="vertical-align:bottom">Product: <span class=mainDB><%=productName%></span></td>
<td style="text-align:right"><span class=mainTitle>Product Built-in Functions</span></td>
</tr>
<tr><td>&nbsp;</td></tr>
</table>
<form>
<table style="border:0px">
<tr><td><span style="font-weight:bold">Numeric Functions:</span><td></tr>
<tr><td>
<% if (numericList.size() == 0) { %>
<table class="greyTable"><tr><td>
There is no any numeric function for product <%=productName%>.
</td></tr></table>
<% } else { %>
<display:table name="numericList" class="simple" >
    <display:column property="first" title="&nbsp;" style="width:20%"/>
    <display:column property="second" title="&nbsp;" style="width:20%"/>
    <display:column property="third" title="&nbsp;" style="width:20%"/>
    <display:column property="fourth" title="&nbsp;" style="width:20%"/>
    <display:column property="fifth" title="&nbsp;" style="width:20%"/>
</display:table>
<% } %>
</td></tr>
<tr><td>&nbsp;<td></tr>
<tr><td><span style="font-weight:bold">Time and Date Functions:</span><td></tr>
<tr><td>
<% if (timeDateList.size() == 0) { %>
<table class="greyTable"><tr><td>
There is no any time and date function for product <%=productName%>.
</td></tr></table>
<% } else { %>
<display:table name="timeDateList" class="simple" >
    <display:column property="first" title="&nbsp;" style="width:20%"/>
    <display:column property="second" title="&nbsp;" style="width:20%"/>
    <display:column property="third" title="&nbsp;" style="width:20%"/>
    <display:column property="fourth" title="&nbsp;" style="width:20%"/>
    <display:column property="fifth" title="&nbsp;" style="width:20%"/>
</display:table>
<% } %>
</td></tr>
<tr><td>&nbsp;<td></tr>
<tr><td><span style="font-weight:bold">System Functions:</span><td></tr>
<tr><td>
<% if (systemcList.size() == 0) { %>
<table class="greyTable"><tr><td>
There is no any system function for product <%=productName%>.
</td></tr></table>
<% } else { %>
<display:table name="systemcList" class="simple" >
    <display:column property="first" title="&nbsp;" style="width:20%"/>
    <display:column property="second" title="&nbsp;" style="width:20%"/>
    <display:column property="third" title="&nbsp;" style="width:20%"/>
    <display:column property="fourth" title="&nbsp;" style="width:20%"/>
    <display:column property="fifth" title="&nbsp;" style="width:20%"/>
</display:table>
<% } %>
</td></tr>
<tr><td>&nbsp;<td></tr>
<tr><td><span style="font-weight:bold">String Functions:</span><td></tr>
<tr><td>
<% if (stringList.size() == 0) { %>
<table class="greyTable"><tr><td>
There is no any string function for product <%=productName%>.
</td></tr></table>
<% } else { %>
<display:table name="stringList" class="simple" >
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
