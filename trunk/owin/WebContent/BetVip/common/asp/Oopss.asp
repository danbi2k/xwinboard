<%

strRefPage =""
strRefPage		= Request.ServerVariables("SCRIPT_NAME") &"?"& Request.ServerVariables("QUERY_STRING")
If isNone(Session("UId")) Then 
%>
	<script language='javascript'>
		window.open('/member/FindIdPwd.asp?flag=1&refPage=<%=server.URLEncode(strRefPage)%>','LI','width=334,height=300')
		opener.location.href='/';
	</script>
<%
Response.Redirect "/"
End If

%>