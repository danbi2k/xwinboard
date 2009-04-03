<%@ include file="/jsp/inc/definitions.inc" %>
<% String fieldname = request.getParameter("fieldname"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<TITLE>Choose Date Format</TITLE>
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/login.css>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/dhtmlwindow.js"></SCRIPT>
</HEAD>
<BODY>
<center>
<FORM NAME="chooseForm" METHOD="POST">
<table border=0>
<tr><td>
<b>Date and Time patterns:</b>
</td></tr>
<tr><td>
<% if (browser.indexOf("MSIE") == -1) { %>
<SELECT NAME="selectList" SIZE=13>
<% } else { %>
<SELECT NAME="selectList" style="width:215" OnClick=":pick();" SIZE=12>
<% } %>
<OPTION>yyyy-MM-dd
<OPTION>yyyy-MM-dd HH:mm:ss
<OPTION>yyyy-MM-dd hh:mm:ss a
<OPTION>yyyy-MM-dd HH:mm:ss.SSS
<OPTION>yyyy-MM-dd hh:mm:ss.SSS a
<OPTION>MM/dd/yyyy
<OPTION>MM/dd/yyyy HH:mm:ss
<OPTION>MM/dd/yyyy hh:mm:ss a
<OPTION>MM/dd/yyyy HH:mm:ss.SSS
<OPTION>MM/dd/yyyy hh:mm:ss.SSS a
<OPTION>MM/dd/yy
<OPTION>MM/dd/yy HH:mm:ss
<OPTION>MM/dd/yy hh:mm:ss a
<OPTION>MM/dd/yy HH:mm:ss.SSS
<OPTION>MM/dd/yy hh:mm:ss.SSS a
<OPTION>HH:mm:ss
<OPTION>hh:mm:ss a
<OPTION>HH:mm:ss.SSS
<OPTION>hh:mm:ss.SSS a
<OPTION>dd/MM/yy
<OPTION>dd/MM/yy HH:mm:ss
<OPTION>dd/MM/yy hh:mm:ss a
<OPTION>dd/MM/yy HH:mm:ss.SSS
<OPTION>dd/MM/yy hh:mm:ss.SSS a
<OPTION>dd/MM/yyyy
<OPTION>dd/MM/yyyy HH:mm:ss
<OPTION>dd/MM/yyyy hh:mm:ss a
<OPTION>dd/MM/yyyy HH:mm:ss.SSS
<OPTION>dd/MM/yyyy hh:mm:ss.SSS a
<OPTION>yy/MM/dd
<OPTION>yy/MM/dd HH:mm:ss
<OPTION>yy/MM/dd hh:mm:ss a
<OPTION>yy/MM/dd HH:mm:ss.SSS
<OPTION>yy/MM/dd hh:mm:ss.SSS a
<OPTION>yyyy/MM/ddyy
<OPTION>yyyy/MM/ddyy HH:mm:ss
<OPTION>yyyy/MM/ddyy hh:mm:ss a
<OPTION>yyyy/MM/ddyy HH:mm:ss.SSS
<OPTION>yyyy/MM/ddyy hh:mm:ss.SSS a
</SELECT>
</td></tr>
<tr><td>
<%=PublicAPI.button("javascript:dhtmlwindow.close(window.parent.selectwin);", "_self", "close_window", imagePath)%>
<%=PublicAPI.button(jspPath+"date_format.html", "date_format", "help", imagePath)%>
<%=PublicAPI.button("javascript:pick();", "_self", "ok", imagePath)%>
</td></tr>
</table>
</FORM>
</center>
</BODY>
</HTML>
<%=PublicAPI.chooseSelectScript(fieldname)%>
