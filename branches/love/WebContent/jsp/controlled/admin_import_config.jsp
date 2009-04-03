<%@ include file="/jsp/inc/admin_definitions.inc" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 
<html>
  <head>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0"> 
    <title>My JSP 'admin_server_info.jsp' starting page</title>
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/basic.css">
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/displaytag.css">
    <style>
      body {
        margin:30px 0px 0px 0px;
     } 
    </style>
  </head>
  
  <BODY background="<%=imagePath%>/<%=info.get("admin_bg")%>"><CENTER>
<%@ include file="/jsp/inc/admin_menu.inc" %>
<p>
<span class="adminTitle">Import Configuration</span>
<p>
<form name="inForm"
      action="<%=actionPath%>/AdminImportConfigFile"
      method="post"
      enctype="multipart/form-data"
      onsubmit="return uploadInput();">
      <div style='text-align:left;width:720px;padding:15px 0px 15px 10px;margin:20px 0px 10px 0px;border:1px dotted #483D8B;background-color:#F0F8FF;'>
      <table style="margin: 15px 15px 15px 15px;width:680px;border:none;">
      <tr>
      <td>
      <ul style="margin: 15px 0px 15px 15px;padding-left:10px;">
      <li class="listItem">The file to upload must be a valid dbcruiser_config.xml</li>
      <li class="listItem">Any invaliad file uploaded could cause DB Cruiser stop working or malfunction.</li>
      <li class="listItem">In the case the file uploaded is not a valid dbcruiser_config.xml, please upload a correct file <strong>immediately</strong>.</li>
      <li class="listItem">The application (DB Cruiser) will try to save the original configuration file as dbcruiser_config.xml.bak in the same directory/folder. But it's not always successful - it depends on the system settings on the server.</li>
      <li>The configuration file: 
      <input type="file" name="filename" size="70">
      </li>
      </ul>
      </div>
      </td>
      </tr>
      </table>
      </div>
      <p>
      <input type=submit value="Replace Current Configuration with the Selected File">
</form>
<table style="border:0px;height:50px;"><tr><td>&nbsp;</td></tr></table>
<table style="border:0px;width:745px">
<td align=left>
<div id="actcontainer">
<ul id="navlist">
<li><a href="javascript:window.history.back();" title="Back to previous page">&nbsp;&nbsp;&nbsp;&nbsp;&lt;&lt;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
 </ul>
 </div>
 </td>
<td><%=PublicAPI.copyrightStr0()%></td>
<td align=right><%=PublicAPI.button("javascript:printPage();", "_self", "printpage", imagePath)%></td>
</tr></table>
    </CENTER>
  </body>
</html>

<SCRIPT LANGUAGE="JavaScript"> 
function uploadInput() {
    if (document.inForm.filename.value == "") {
        alert("No file specified.\n\nUse \"Browse...\" button to select a DB Cruiser configuration file.");
        document.inForm.filename.focus();
        return false;
    } 
     
    if (!confirm("The current configuration will be lost, continue?")) {
         return false;
    } 
    return true;
}
</SCRIPT> 