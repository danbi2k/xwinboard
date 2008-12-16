
<%

strRefPage		= ""
strRefPage		= Request.ServerVariables("SCRIPT_NAME") &"?"& Request.ServerVariables("QUERY_STRING")
If isNone(Session("SYS_ID")) Then Call descMentPage("","top.location.href='/Admin/Login.asp';","")
%>