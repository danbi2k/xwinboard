<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String status = (String)request.getAttribute("status");
	String userId = (String)request.getParameter("id");
%>
<html>
<head>
    <title>아이디 중복체크</title>
    <Meta Http-Equiv="Content-Type" Content="Text/Html; Charset=Euc-Kr">
    <Meta Http-Equiv="Imagetoolbar" Content="No">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" content="-1">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
    <link rel="stylesheet" href="common/default.css">
    <script language="JavaScript" src="common/default.js"></script>
	<script language="JavaScript" src="common/member.js"></script>
</head>


<body onload="checkid.id.focus();">

<table width="100%" height="30" style="border-bottom:1 solid #909090" bgcolor="#333333">
<tr><td align="center"><b><img src="images/title_iddualcheck.gif"></td></tr>
</table>

	<table border=0 cellpadding=0 cellspacing=0 width="100%" height="165" bgcolor="#0a0a0a">
	<tr><td align="center" style="line-height:20px;">


<%if (status.equals("empty")) { %>
	<form action="joinMember.aspx" name="checkid" method="get" onsubmit="checkid_form(checkid);return false;">
	<input type="hidden" name="mode" value="checkExistUserId"/>			
	
	아이디를 입력해주세요.<br><br>
	
	<table>
	<tr><td><input class="member" type="text" width=35 height=18 name="id" value="" style='IME-MODE: inactive'></td>
		<td><input type="image" src="images/btn_ok.gif" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';"></td>
	</tr>
	</table>
	</form>
<%} else if (status.equals("dup")) { %>
	<form name="checkid" method="get" onsubmit="checkid_form(checkid);return false;">			
	
	<font style="color:darkorange;"><%=userId%></font>는 사용중입니다.<br>
	다른 아이디를 입력해주세요.</b><br>
	
	<table>
	<tr><td><input class="member" type="text" width=35 height=18 name="id" value="" style='IME-MODE: inactive'></td>
		<td><input type="image" src="images/btn_ok.gif" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';"></td>
	</tr>
	</table>
	</form>
<%} else { %>
	<font style="color:darkorange;"><%=userId%></font> 는 사용 가능한 아이디입니다.<br><br>
	<img src="images/btn_use.gif" onClick="window.opener.SetID('<%=userId%>');self.close();" style="cursor:hand;">
<%} %>

	</td></tr>
	</table>

</td></tr>
</table>

</body>
</html>