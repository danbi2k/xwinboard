<%@ include file="/jsp/inc/definitions.inc" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<% 
   String productDetail = (String)request.getAttribute("productDetail");
   String productName = (String)request.getAttribute("productName");
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
<td style="vertical-align:bottom">Database: <span class=mainDB><%=db_name%></span></td>
<td style="text-align:right"><span class=mainTitle>Database Product Information</span></td>
</tr>
<tr><td>&nbsp;</td></tr>
</table>
<form>
<table style="border:0px">
<tr><td style="text-align:center">Product: <span style="color:darkgreen;font-weight:bold"><%=productName%></span></td></tr>
<tr><td>
<table style="border: 1 solid #888888;background-color:#FFFFFF">
<tr><td>
<%=productDetail%>
</td></tr>
</table>
</td></tr>
<tr><td>
<display:table name="productInfo"  class="simple" >
    <display:column property="name" title="Data Name" />
    <display:column property="value" title="Data Size" />
</display:table>
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
