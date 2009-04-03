<%@ include file="/jsp/inc/definitions.inc" %>
<% 
   String adminPage = (String)session.getAttribute("adminPage");
   if (adminPage != null) {
	   //request.getRequestDispatcher(adminPage).forward(request, response);
	   response.sendRedirect(request.getContextPath()+adminPage);
       return;
   }
%>
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<TITLE>DB Cruiser Administration</TITLE>
<link rel=stylesheet href=<%=contextPath%>/styles/basic.css>
<link rel=stylesheet href=<%=contextPath%>/styles/admin.css>
<link type="text/css" rel=stylesheet href="<%=contextPath%>/styles/dhtmlwindow.css">
<style>
 body {
   margin:50px 0px 0px 0px;
 }
</style>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/dhtmlwindow.js"></SCRIPT>
<SCRIPT Language="JavaScript" SRC="<%=contextPath%>/scripts/common.js"></SCRIPT>
</HEAD>
<BODY background="<%=imagePath%>/<%=info.get("admin_bg")%>" OnLoad=""><CENTER>
<img src=<%=imagePath%>/dbcruiser_admin.gif border=0>
<div style="margin:50px 50px 50px 50px;padding:30px 0px 25px 0px;width:425px;border:3px solid #478F8F;">
<% if (message != null) { %>
       <font color=crimson><%= message %></font><p>
<% } %>      
<font size=+1 color=#0000CC>Please Login</font>

<form NAME="login"
      METHOD="POST"
      ACTION="<%=contextPath%>/action/AdminLogin"
      ENCTYPE="x-www-form-encoded">
<INPUT TYPE="hidden" NAME="controller" value="AdminLogin">
<table border=0>
<tr>
<td><FONT COLOR="navy"><B>User ID:</B></FONT> </td>
<td><INPUT TYPE="text" style="width:180px;border:1px solid grey;" NAME="admin_user"></td>
</tr><tr>
<td><FONT COLOR="navy"><B>Password:</B></FONT> </td>
<td><INPUT TYPE="password" style="width:180px;border:1px solid grey;" NAME="admin_pass" MAXLENGTH=30></td>
</tr>
</table>
<p>
<table border=0>
<tr><td>
<div id="navcontainer">
<ul id="navlist">
<li><a href="javascript:window.history.back();" title="Back to previous page">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a href="javascript:contactWindow();" title="Contact DB Cruiser Administration">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Contact&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<li><a class="action" href="javascript:checkFields();" title="Login into the DB Cruiser Administration panel">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Login&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
</ul>
</div> 
</td></tr>
</table>
<p>
</FORM>
</div>
<table style="border:0px;width:400px">
<tr>
<td><%=PublicAPI.copyrightStr6()%></td>
</tr></table>
</BODY>
</HTML>
<SCRIPT LANGUAGE=JavaScript>
document.onkeydown=submitLoginForm;
function submitLoginForm(evt){
  if(document.all) {
     if(window.event.keyCode == 13){
        checkFields();
     }
  } else {
     if (getUnicode(evt) == 13) {
         checkFields();
     }
  }
}
function checkFields() {
   if (document.login.admin_user.value == "") {
	   alert("Please Enter User ID.");
       document.login.admin_user.focus();
   } else if (document.login.admin_pass.value == "") {
       alert("Please Enter Password.");
       document.login.admin_pass.focus();
   } else {
	   document.login.submit();
   }
}
function resetFields() {
   document.login.admin_user.value = "";
   document.login.admin_pass.value = "";
}
function contactWindow(){
  contactwin=dhtmlwindow.open('contactbox', 'iframe', '<%=actionPath%>/AdminContact', 'DB Cruiser Administration Contact', 'width=350px,height=100px,resize=1,scrolling=1,center=0', 'blue');
}
</SCRIPT>

