<%

strRefPage =""
strRefPage		= Request.ServerVariables("SCRIPT_NAME") &"?"& Request.ServerVariables("QUERY_STRING")
If isNone(Session("UId")) Then  Call descment("�α��� �� �̿��� �ּ���","/default.asp","")
%>