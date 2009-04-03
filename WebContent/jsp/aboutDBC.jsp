<%@ include file="/jsp/inc/definitions.inc" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/basic.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
<link type="text/css" rel=stylesheet href="<%=contextPath%>/styles/dhtmlwindow.css">
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/dhtmlwindow.js"></SCRIPT>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
<TITLE>About DB Cruiser</TITLE>
<%=PublicAPI.licenseExpired(contextPath) %>
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
<td style="vertical-align:bottom">&nbsp; <span class=mainDB>&nbsp;</span></td>
<td style="text-align:right"><span class=mainTitle>About DB Cruiser</span></td>
</tr>
<tr><td>&nbsp;</td></tr>
</table>

<table style="border:0px;width:650px">
<tr><td><span style="font-weight:bold">Version and License:</span></td></tr>
<tr><td>
<display:table name="dbcruiserInfo"  class="simple" >
    <display:column property="name" title="&nbsp;" style="width:365px"/>
    <display:column property="value" title="&nbsp;" />
</display:table>
</td></tr>
</table>

<table style="border:0px;width:650px">
<tr><td style="height:30px">&nbsp;</td></tr>
<tr><td><span style="font-weight:bold">Contact Information:</span></td></tr>
<tr><td>
<display:table name="dbcruiserContact"  class="simple" >
    <display:column property="name" title="&nbsp;" style="width:365px"/>
    <display:column property="value" title="&nbsp;" />
</display:table>
</td></tr>
</table>

<table style="border:0px;width:560px">
<tr><td style="height:30px">&nbsp;</td></tr>
<tr><td><span style="font-weight:bold">Product Information:</span></td></tr>
<tr><td>
<display:table name="dbcruiserResource"  class="simple" >
    <display:column property="name" title="&nbsp;" style="width:365px"/>
    <display:column property="value" title="&nbsp;" />
</display:table> 
</td></tr>
<tr><td style="height:40px">&nbsp;</td></tr>
</table>
<p>
<table style="border:0px;width:748px">
<tr>
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
<script>
function contactWindow(){
  contactwin=dhtmlwindow.open('contactbox', 'iframe', '<%=actionPath%>/AdminContact', 'DB Cruiser Administration Contact', 'width=350px,height=100px,resize=1,scrolling=1,center=0', 'blue');
}
</script>
</body>
</HTML>