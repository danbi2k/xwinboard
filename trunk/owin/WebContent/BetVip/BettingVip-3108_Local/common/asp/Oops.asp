<%

strRefPage =""
strRefPage		= Request.ServerVariables("SCRIPT_NAME") &"?"& Request.ServerVariables("QUERY_STRING")
If isNone(Session("UId")) Then  Call descment("로그인 후 이용해 주세요","/default.asp","")
%>