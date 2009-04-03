<%@ include file="/jsp/inc/definitions.inc" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>DB Cruiser - Web Based Database Access Tool</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link type="text/css" rel="stylesheet" href="<%=contextPath%>/styles/main.css" />
	<link type="text/css" rel="stylesheet" href="<%=contextPath%>/styles/dhtmlwindow.css" />
	<script type="text/javascript" src="<%=contextPath%>/scripts/dhtmlwindow.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/scripts/prototype.js" ></script>
    <script type="text/javascript" src="<%=contextPath%>/scripts/scriptaculous.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/scripts/main.js"></script>
    <script type="text/javascript">
       contextPath = '<%=contextPath%>';
    </script>
  </head>
  
<body class='indexBody' onLoad='initialize()' leftmargin=0 topmargin=0>
<TABLE border='0' cellspacing='0' cellpadding='0' width='100%' height='100%'>
<TR height='1'>
<td>
<table border='0' cellspacing='0' cellpadding='0' width='100%'>
<tr>
<TD valign='bottom' width='100'><A href='jsp/login.jsp' target='site'><IMG src='images/dbcruiser.gif' align='top' hspace=0 vspace=0 border='0' alt='DB Cruiser'></A>
</TD>
<TD>
<table border='0' cellspacing='0' cellpadding='0' width='100%'>
<TR  height='3'>
<!--  
<TD valign='bottom' style='font-size:2px' width='50%'>
<A href='maps/index.html' style='color:white; font-size: 2pt'>&nbsp;</A><IFRAME name='loader' width='1' height='1' FRAMEBORDER=0 SCROLLING=no></IFRAME><IFRAME name='WWHHelp' width='1' height='1' FRAMEBORDER=0 SCROLLING=no></IFRAME>
</TD>
-->
<TD valign="top" align="right" style='font-family:Sans,Arial;font-size:10px;color:#569e7f'>
<table class="topMenuTable" cellpadding=0 cellspacing=0 border=0 > 
<tr align="right" bgcolor=#E8EBF4 > <td id=showMenuTd style='display:none;padding:0'> 
<td class="topMenuItem" onclick="addNewConn()" title="Connect to new database">Add new connection</td> 
<td ><img width=1 height=16 src='<%=imagePath%>/TopSep.gif'></td> 
<td class="topMenuItem" onclick='closeAllConns()' title="Disconnect all database connections"> Disconnect all </td> 
<td><img width=1 height=16 src='<%=imagePath%>/TopSep.gif'></td>
<td class="topMenuItem" onclick='admin()' title="DB Cruiser Administration Panel"> Administration </td> 
<td><img width=1 height=16 src='<%=imagePath%>/TopSep.gif'></td>
<td class="topMenuItem" onclick='contactWindow()' title="Contact DB Cruiser Administration"> Contact </td> 
<td><img width=1 height=16 src='<%=imagePath%>/TopSep.gif'></td>
<td class="topMenuItem" onclick='about()' title="Information about DB Cruiser.">About&nbsp;</td> 
</tr>
</table> 
<!--  
<nobr>
... access SQL databases via web browers&nbsp;|
<A href='<%=contextPath%>/jsp/login.jsp' target='site' style='color:#569e7f'>Add connection</A> |
<A href='javascript:closeAllConns();' target='_self' style='color:#569e7f'>Disconnect all</A> |
<A href='<%=contextPath%>/jsp/admin_login.jsp' target='site' class="topMenuItem">Admin</A> |
<A href='<%=contextPath%>/action/About' target='site' style='color:#569e7f'>About</A>&nbsp;&nbsp;&nbsp;
</nobr>
-->
</TD>
</TR>
<TR height='12'>
<TD VALIGN='bottom' style='padding-left: 7px'>
<TABLE border='0' cellspacing='0' cellpadding='0'>
<TR id='connTabRow'>
<!--  <TD>&nbsp;</TD>-->
<TD valign='top' class='tabNew' title='connect to new databases' onclick="site.location.href='jsp/login.jsp';">
<NOBR>Click to add<br>new connections</NOBR>
</TD>
</TR>
</TABLE>
</TD>
</TR>
</table>
</TD>
</tr>
</table>
</td>
<TR>
<TD style='height:10px;width:100%;padding: 1px 6px 0px 2px; font-family: Arial; font-size:11px; color: #404040; background:#D2E4FC' align='right' colspan='2'><!-- replace white with #c8d7e3 -->
<!-- 
<A id='relatedLink' class='toolbarButton' style='display:none' onClick='showRelated();return false;' href='#'>Essential Links</A>
&nbsp;
<A id='searchLink' class='toolbarButton' style='display:none;color:#A00000' target='site' href='search.html'>Search Code and Forums (beta)</A>
&nbsp;
<A class='toolbarButton' target='site' href='history.html'>Recently Viewed</A>
-->
</TD>
</TR>
<TR height='99%' bgcolor='#D2E4FC'><!-- replace white with #c8d7e3 -->
<TD colspan='3'>
<TABLE id='mainPanel' cellspacing='0' cellpadding='0' border='0' width='100%' height='100%'>
<TR>
<TD width="160" valign=top style='padding: 2px 2px 2px 7px'>
<TABLE width='100%' height='100%' cellspacing='0' cellpadding='0' border='0'>
<!--
<TR height='10'>
<TD class='tocLabel'>
Search in <SPAN id='searchIn'>&nbsp;</SPAN>
</TD>
</TR>
<TR height='10'>
<TD>
<INPUT type='text' id='keys1' size='23'>
</TD>
</TR>

<TR height='10' style='display:none'>
<TD class='tocSmall'>
<SPAN id='searchWhat'>&nbsp;</SPAN>
</TD>
</TR>

<TR height='2'>
<TD class='tocLabel'>
</TD>
</TR>
-->
<!--  
<TR height='10'>
<TD class='tocLabel'>or Browse</TD>
</TR>
-->
<TR height='99%'>
<TD valign='top'>
<IFRAME id='tocFrame' name='tocFrame' src='toc.html' width='100%' height='99%' class='contentFrame' frameborder='0'></IFRAME>
</TD>
</TR>
</TABLE>
</TD>
<TD id='movable' width='5' class='movable' valign='middle'>
<!--  
.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.
-->
</TD>
<TD style='padding: 2px 6px 0px 2px'>
<IFRAME id='siteFrame' name='site' src='jsp/login.jsp' width='100%' height='99%' class='contentFrame' frameborder='0'></IFRAME>
</TD>
</TR>
</TABLE>
</TD>
</TR>
</TABLE>
<!--<TABLE id="menu" class="menu" style='display:none' cellspacing='0' cellpadding='0' border='0'>-->
<TABLE id="menu" class="menu" cellspacing='0' cellpadding='0' border='0'>
</TABLE>
<div id="adminLogin" style="border:10px solid blue;position:absolute;visibility:hidden;left:77; top:77; width:400; height:300; clip:rect(0,381,381,0); background:#FFF;">
 <iframe src="<%=contextPath%>/jsp/admin_login.jsp" width="377" height="377" marginwidth="0" marginheight="0" frameborder="no" scrolling="yes" style="border-width:2px; border-color:#333; background:#FFF; border-style:solid;">
 </iframe>
</div>
</body>
</HTML>

