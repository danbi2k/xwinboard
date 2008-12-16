<%	@Language = "VBScript" %>
<%
'	Option Explicit
	Response.expires = 0
	Response.buffer = true


	Dim TableName, id, order, file
	
	TableName	= Request("TableName")
	IntIdx		= Request("Idx")
	fcnt		= Request("fcnt")
	file		= Request("file")
%>

<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=euc-kr;">
	<title><%=file%></title>
	<script language="javascript">
		
		function init()
		{
			var obj = document["img"];
			
			if (!obj.width)
			{
				return;
			}
			
			var theW = obj.width + 28;
			var theH = obj.height + 30;
			
			if (theW >= screen.availWidth)
			{
				theW = screen.availWidth - 50;
			}
			
			if (theH >= screen.availHeight)
			{
				theH = screen.availHeight - 50;
			}
			
			window.resizeTo(theW, theH);
		}
		
	</script>
</head>

<body marginwidth="0" marginheight="0" leftmargin="0" topmargin="0" onload="init();">
<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><a href="javascript:window.close();"><img src="Download.asp?TableName=<%=TableName%>&Idx=<%=IntIdx%>&fcnt=<%=fcnt%>&dcnt=1" border="0" name="img"></a></td>
	</tr>
</table>
</body>
</html>