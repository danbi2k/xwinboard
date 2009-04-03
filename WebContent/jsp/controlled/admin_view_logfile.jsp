<%@ include file="/jsp/inc/admin_definitions.inc" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0"> 
    <title>DB Cruiser Administration: View Log File</title>
    <SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/basic.css">
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
  </head>
  
  <BODY background="<%=imagePath%>/<%=info.get("admin_bg")%>">
  <CENTER>
  <%@ include file="/jsp/inc/admin_menu.inc" %>
  <p>
  <form NAME=requestForm METHOD=POST ACTION=<%=contextPath%>/action/AdminSaveLog>
<span class="adminTitle">DB Druiser Log File</span>
<p>
    <textarea style='width:740;height:400;border:1px solid grey;'><%=FileOpen.getLogFileContent()%></textarea>
<table style="border:0px;width:auto;">
<tr><td><nobr>
<div id="navcontainer">
<ul id="navlist">
<li><a href="javascript:window.history.back();" title="Back to previous page">&nbsp;&nbsp;&nbsp;&nbsp;&lt;&lt;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a href="javascript:document.location.reload();" title="Refesh the page.">&nbsp;&nbsp;&nbsp;&nbsp;Refresh&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a href="javascript:document.requestForm.submit();" title="Save DB Cruiser log to a file">&nbsp;&nbsp;&nbsp;&nbsp;Save As ...&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
</ul>
</div> 
</nobr></td></tr>
</table>
    </form>
<p>
<table style="border:0px;width:748px">
<td><%=PublicAPI.copyrightStr0()%></td>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr></table>
  </CENTER>
  </body>
</html>