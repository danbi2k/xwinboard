<%@ include file="/jsp/inc/admin_definitions.inc" %>
<% 
   int userCount = PublicAPI.getUserCount();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<title>DB Cruiser Administration: Active Connections</title>
<link rel="stylesheet" type="text/css" href="<%=stylePath%>/basic.css">
<link rel="stylesheet" type="text/css" href="<%=stylePath%>/sortabletable.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
<script type="text/javascript" src="<%=scriptPath%>/common.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/prototype.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/scrollabletable.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/sortabletable.js"></script>
</head>
  
<body background="<%=imagePath%>/<%=info.get("admin_bg")%>" onload="getContent()">
  <center>
  <%@ include file="/jsp/inc/admin_menu.inc" %>
  <p>
  <form NAME=requestForm METHOD=POST ACTION=<%=contextPath%>/action/AdminDisconnect>
  <input type="hidden" name="disconnectAll" value="false">
<span class="adminTitle">Active Connections</span><br>
<p>

    <table style="border:0px;margin-bottom:0px;"><tr><td align="left">
    Number of Active Connections: <span id="countContainer"><%=userCount%></span>
    </td></tr><tr><td>
<% if (userCount == 0) {
       out.println("<table style='border:1px solid grey;'><tr><td align=center>");
       out.println("<span>No active connection found.</span>");
       out.println("</td></tr></table>");
   } else {
%>
<div id="tableContainer" />
<% } %>
    </td></tr></table>
    <p>
<table style="border:0px;width:auto;">
<tr><td><nobr>
<div id="navcontainer">
<ul id="navlist">
<li><a href="javascript:window.history.back();" title="Back to previous page">&nbsp;&nbsp;&nbsp;&lt;&lt;&nbsp;Back&nbsp;&nbsp;&nbsp;</a></li>
<li><a href="javascript:getContent();" title="Refesh the active connections list.">&nbsp;&nbsp;&nbsp;&nbsp;Refresh&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<% if (userCount > 0) { %>
       <li><a class="action" href="javascript:disconnect();" title="Disconnect selected connections">&nbsp;&nbsp;&nbsp;&nbsp;Disconnect Selected Connections&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
       <!-- <li><a href="javascript:disconnectAllOnPage();" title="Disconnect all connections on this page">&nbsp;Disconnect all connections on this page&nbsp;</a></li> -->
       <li><a href="javascript:disconnectAll();" title="Disconnect all connections (on all the pages)">&nbsp;&nbsp;&nbsp;&nbsp;Disconnect All Connections&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<% } %>
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
</center>
</body>

<script type="text/javascript">
function disconnect() { 
	  var idBox = document.requestForm.connId;
      var len = document.requestForm.connId.length;
      var count = 0;
      if (len) { 
          for (i=0; i<idBox.length; i++) { 
               if (idBox[i].checked) count++; 
          } 
      } else { 
          if (idBox.checked) { 
              count = 1; 
          } 
      } 
      if (count == 0) { 
          alert("Please select connection(s) to disconnect.");
      } else { 
          if (confirm("Disconnect seleted connections?")) {
              //closeConnTab();
              document.requestForm.submit(); 
          } 
      } 
} 
function disconnectAllOnPage() {
      var idBox = document.requestForm.connId;
      if (confirm("Disconnect all the connections on this page?")) {
          if (confirm("All the connections on this page will be cut, continue?")) {
              var len = document.requestForm.connId.length;
              if (len) { 
                  for (i=0; i<idBox.length; i++) { 
                       idBox[i].checked = true; 
                  } 
              } else {
                  idBox.checked = true;
              }
              document.requestForm.submit(); 
          } 
      }  
}
function disconnectAll() { 
      if (confirm("Disconnect all the connections?")) {
          if (confirm("All the connections via DB Cruiser will be cut, continue?")) {
              document.requestForm.disconnectAll.value = "true";
              document.requestForm.submit(); 
          } 
      } 
}
function closeConnTab() {
      var len = document.requestForm.connId.length;
      if (len) { 
          for (i=0; i<idBox.length; i++) { 
               if (idBox[i].checked) {
                   window.parent.closeConnById(idBox[i].value);
               } 
          } 
      } else { 
          if (idBox.checked) { 
              window.parent.closeConnById(idBox.value);
          } 
      } 
}
function logout() {
	document.requestForm.action = "<%=contextPath%>/ControlServlet";
	document.requestForm.controller.value = "AdminLogout";
	document.requestForm.submit();
	window.close();
}

function updateContent() {
    var now = new Date();
    //var myAjax = new Ajax.Updater('tableContainer', '<%=actionPath%>/AdminGetUserList?id='+now, { method: 'get', asynchronous: false});
    var myAjax = new Ajax.PeriodicalUpdater('tableContainer', '<%=actionPath%>/AdminGetUserList?id='+now, { method: 'get', asynchronous: false, frequency: 10, decay: 1});
}
function getContent() {
    updateContent();
    var t = new SortableTable(document.getElementById('content'));
}
</script>
</html>