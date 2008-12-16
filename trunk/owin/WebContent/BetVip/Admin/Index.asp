
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/config.asp			-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<!--	#include virtual=/common/asp/SysOops.asp		-->
<html>
<head>
<title> 관리자</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" type="text/css" href="style/style.css">
</head>

<frameset rows="1*" cols="19%, 81%" border="0">
<frame name=left src="LeftMenu.asp" border=0 scrolling="yes" noresize>
<frameset rows="4%, 96%" cols="1*">
<frame name="header" src="ReFlash.asp" scrolling="no" border=0 >
	<% If Session("SYS_Ssection")=0 Then %>
	<frame name=mainFrame src="member/MemberList.asp" border=0 scrolling="yes" noresize>
	<% Else %>
	<frame name=mainFrame src="Game/List.asp?Sect=5" border=0 scrolling="yes" noresize>
	<% End If %>
	
</frameset><noframes>
<body >
</body>
</noframes>
</frameset>
</html>


