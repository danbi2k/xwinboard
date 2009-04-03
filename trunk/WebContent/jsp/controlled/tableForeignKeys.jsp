<%@ include file="/jsp/inc/definitions.inc" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%  
   String tablename = (String)request.getAttribute(PublicLabel.TABLENAME);
   if (tablename == null) {
       tablename = request.getParameter(PublicLabel.TABLENAME);
   }
   Integer count = (Integer)request.getAttribute("count");
   Integer count2 = (Integer)request.getAttribute("count2");
   String mark = (String)session.getAttribute("session_mark");
   String display = (String)request.getParameter("display");  
%>
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/basic.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
<link type="text/css" rel=stylesheet href="<%=contextPath%>/styles/dhtmlwindow.css">
<link rel="stylesheet" type="text/css" href="<%=stylePath%>/sortabletable.css">
<script type="text/javascript" src="<%=contextPath%>/scripts/dhtmlwindow.js"></script>
<script type="text/javascript" src="<%=contextPath%>/scripts/common.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/prototype.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/scrollabletable.js"></script>
<script type="text/javascript" src="<%=scriptPath%>/sortabletable.js"></script>
<%=PublicAPI.refrechTableVisitedList() %>
<%=PublicAPI.licenseExpired(contextPath) %>
<TITLE><%=tablename%> - Foreign Keys</TITLE>
</HEAD>
<% if (Boolean.valueOf((String)session.getAttribute(PublicLabel.LICENSE_EXPIRED)).booleanValue()) {
	   out.println("<body onload='stopProcessing();licenseExpiredWindow();refrechVisitedTableList();'>");
   } else {
       out.println("<body onload='stopProcessing();refrechVisitedTableList();'>");
   }
%>
<center>
<p>
<% if (Boolean.valueOf(display).booleanValue()) { 
       out.println("<table style=\"border:0px;height:12px\"><tr><td></td></tr></table>"); 
       out.println(PublicAPI.menu(contextPath, tablename, "", connId, browser, db_name));
   } else {
	   out.println(PublicAPI.processingDiv(imagePath));
   }
   out.println(PublicAPI.printTitle(display, tablename, "Foreign Keys"));
%> 
<form>
<input type=hidden name=tablename value=<%=tablename%>>
<table style="border:0px">
<tr><td><span style="color:navy;font-weight:bold">Imported (Parent) Keys</span> (total <span id="countContainer"><%=count.intValue()%></span>)</td></tr>
<tr><td>
<% if (count == null || count.intValue() == 0) { %>
<table class="greyTable"><tr><td>
The table does not have any parent key.
</td></tr></table>
<P>
<% } else { %>
<div id="tableContainer"><%=(String)request.getAttribute("data")%></div>
<% } %>
</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td><span style="color:navy;font-weight:bold">Exported (Child) Keys</span> (total <span id="countContainer"><%=count2.intValue()%></span>)</td></td></tr>
<tr><td>
<% if (count2 == null || count2.intValue() == 0) { %>
<table class="greyTable"><tr><td>
The table does not have any child key.
</td></tr></table>
<P>
<% } else { %>
<div id="tableContainer"><%=(String)request.getAttribute("data2")%></div>
<% } %>
</td></tr>
</table>
</form>
<p>
<table style="border:0px;width:760px">
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
<script type="text/javascript">
function getTable(url) {
     window.location = getFullURL(url);
}
function getFullURL(url) {
      var prefix =  "<%=actionPath%>/TableForeignKeys?connId=<%=connId%>&db_name="+escape('<%=db_name%>')+"&tablename=";
      var today = new Date();
      var postfix = '&display=true&id='+today.getTime();
      return prefix+url+postfix;
}
function popUp(url, name, width, height, top, left) {
      var mark = "<%=mark%>";
      var winProperty = 'resizable=1,scrollbars=1,titlebar=yes,menubar=no,toolbar=yes,location=no,width='+width+',height='+height+',top='+top+',left='+left;
      var modify = new String(name);
      var newname = modify.replace(/\\$/g,"ZQ");
      var newWin = open(getFullURL(url),mark+newname,winProperty);
      newWin.focus();
}
function ruleWindow() {
	var rulewin=dhtmlwindow.open('rulebox', 'iframe', '<%=jspPath%>/foreign_key_delete_rule.jsp', 'Foreign Key Delete/Update Rule', 'width=700px,height=200px,resize=1,scrolling=1,center=0', 'blue');
}
var t = new SortableTable(document.getElementById('content'));
var t2 = new SortableTable(document.getElementById('content2'));
</script>
</html>
