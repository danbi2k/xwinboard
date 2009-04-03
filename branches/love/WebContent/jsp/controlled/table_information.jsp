<%@ include file="/jsp/inc/definitions.inc" %>
<HTML>
<HEAD>
<TITLE>Table Information</TITLE>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
<SCRIPT LANGUAGE="JavaScript">
window.focus();
</SCRIPT>
</HEAD>
<FRAMESET border=0 rows=95,* frameBorder=0 frameSpacing=0>
<FRAME marginHeight=0 marginWidth=0 name=tableIn  src="<%=actionPath%>/SetSchemaCatalog?connId=<%=connId%>&db_name=<%=db_name%>">
<FRAME FRAMEBORDER=0 marginHeight=0 marginWidth=0 name=tableOut src="<%=actionPath%>/TableInfoResult?tableInfoWindow=true&connId=<%=connId%>&db_name=<%=db_name%>">
</FRAMESET></HTML>
