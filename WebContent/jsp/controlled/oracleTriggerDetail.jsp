<%@ include file="/jsp/inc/definitions.inc" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<% 
   ArrayList triggerList = (ArrayList)session.getAttribute("triggerList");
   OracleTriggerDetailBean detailBean = (OracleTriggerDetailBean)request.getAttribute("detailBean"); 
   int pageSize = 20;
   try {
       pageSize = Integer.parseInt(info.get("default_display_size"));
   } catch(Exception e) {
       pageSize = 20;
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
<link type="text/css" rel=stylesheet href="<%=contextPath%>/styles/dhtmlwindow.css">
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/dhtmlwindow.js"></SCRIPT>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
<TITLE>Trigger Details</TITLE>
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
<td style="vertical-align:bottom">Database: <span class=mainDB><%=db_name%></span></td>
<td style="text-align:right"><span class=mainTitle>Trigger Details</span></td>
</tr>
<tr><td>&nbsp;</td></tr>
</table>
<form>
<table style="border:0px">
<tr><td>

<TABLE class="greyTable" cellspacing=0>
<tr>
<td class="greyCellBottomRightBorder" style="width:15%"><span style="color:navy;font-weight:bold">Name:</span></td>
<td class="greyCellBottomRightBorder"><%=detailBean.getTriggerName()%></td>
<td class="greyCellBottomRightBorder" style="width:17%"><span style="color:navy;font-weight:bold">Owner:</span></td>
<td class="greyCellBottomBorder"  ><%=detailBean.getOwner()%></td>
</tr>
<tr>
<td class="greyCellBottomRightBorder" style="width:15%"><span style="color:navy;font-weight:bold">Event:</span></td>
<td class="greyCellBottomRightBorder" ><%=detailBean.getTriggeringEvent()%></td>
<td class="greyCellBottomRightBorder" style="width:17%"><span style="color:navy;font-weight:bold">Type:</span></td>
<td class="greyCellBottomBorder" ><%=detailBean.getTriggerType()%></td>
</tr>
<tr>
<td class="greyCellBottomRightBorder" style="width:15%"><span style="color:navy;font-weight:bold">Table Name:</span></td>
<td class="greyCellBottomRightBorder" ><%=detailBean.getTableName()%></td>
<td class="greyCellBottomRightBorder" style="width:17%"><span style="color:navy;font-weight:bold">Table Owner:</span></td>
<td class="greyCellBottomBorder" ><%=detailBean.getTableOwner()%></td>
</tr>
<tr>
<td class="greyCellBottomRightBorder" style="width:15%"><span style="color:navy;font-weight:bold">Table Type:</span></td>
<td class="greyCellBottomRightBorder" ><%=detailBean.getBaseObjectType()%></td>
<td class="greyCellBottomRightBorder" style="width:17%"><span style="color:navy;font-weight:bold">Column Name:</span></td>
<td class="greyCellBottomBorder" ><%=detailBean.getColumnName()%></td>
</tr>
<tr>
<td class="greyCellRightBorder" style="width:15%"><span style="color:navy;font-weight:bold">Status:</span></td>
<td class="greyCellRightBorder" ><%=detailBean.getStatus()%></td>
<td class="greyCellRightBorder" style="width:17%"><span style="color:navy;font-weight:bold">Action Type:</span></td>
<td ><%=detailBean.getActionType()%></td>
</tr>
</TABLE>

</td></tr>
<tr><td colspan=4>&nbsp;</td></tr>
<tr>
<td colspan=4><span style="color:navy;font-weight:bold">Description</span></td>
</tr>
<tr>
<td colspan=4>
<table style="border-width:1px;border-style:solid;border-color:grey;background-color:#F4F4FD" CELLPADDING=0 CELLSPACING=0>
<tr><td>
<%=detailBean.getDescription()%>
</td></tr>
</table>
</td>
</tr>
<tr><td colspan=4>&nbsp;</td></tr>
<tr>
<td colspan=4><span style="color:navy;font-weight:bold">Trigger Body:</span></td>
</tr>
<tr>
<td colspan=4>
<textarea style="border:1px solid grey;width:748px;background-color:#F4F4FD">
<%=detailBean.getTriggerBody()%>
</textarea>
</td>
</tr>
</table>
</form>
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
</body>
</HTML>

