
<!--	#include virtual=/common/asp/UtilityClass.asp		-->
<%
Session("UId")			= ""
Session("UPoint")		= ""
Session("UName")		= ""

Response.Cookies("member")("name") = ""
Response.Cookies("member")("mail") = ""
Response.Cookies("member")("tel") = ""
Response.Cookies("member")("cell") = ""

Response.Cookies("member").Expires = now()-1
Session.Abandon
Call descment("","/","")
%>

