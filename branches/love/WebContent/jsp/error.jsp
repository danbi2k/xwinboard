<%@ include file="/jsp/inc/definitions.inc" %>
<% 
   String error_msg = (String)request.getAttribute("error_msg");
   if (error_msg == null) {
       error_msg = "Unknown";
   }
   String display = (String)request.getParameter("display");
%>
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/introduction.css>
<TITLE>Error Message</TITLE>
</HEAD>
<body link=blue vlink=blue alink=blue OnLoad="stopProcessing();">
<center>
<table border="0" cellpadding="0" cellspacing="0" width=740>
<tr><td>&nbsp;</td></tr>
<tr><td align=center><font color=navy size=+1><b>Error Occured in Processing Your Request:</b></font></td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td align=center>
<table style='border:1px solid black;' cellpadding="5" cellspacing="0" width=100%>
<tr><td>
<%= error_msg %>
</td></tr>
</table>
</td></tr>
<tr><td>&nbsp;</td></tr>
</table>
<p>

<% if (!Boolean.valueOf(display).booleanValue()) { 
	   out.println(PublicAPI.processingDiv(imagePath));
   }
%>

<table style="border:0px;width:740px"><tr>
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
</html>

