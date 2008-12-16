
<!--	#include virtual=/common/asp/Connect.asp			-->
<!--	#include virtual=/common/asp/UtilityClass.asp		-->
<HTML>
<HEAD>
<title>::: 우편번호 검색 :::</title>
</HEAD>
<link rel="stylesheet" href="/common/css/default.css" type="text/css">
<link rel="stylesheet" href="/common/css/style.css" type="text/css">
<style type="text/css">
<!--
body {
	background-color: #f2f2f2;
}
.style1 {	color: #006699;
	font-weight: bold;
}
.style2 {color: #FF6600}
-->
</style>
<BODY bgcolor="#EAEAEA" text="#000000" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0">
	
<TABLE width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor=#1A9BD4>
<FORM name="lfmz" method="post" >
	<TR > 
		<TD align="center" width="30%" bgcolor="#1A9BD4"><b><Font color="FFFFFF">우편번호</b></TD>
		<TD align="center" width="70%" bgcolor="#57B6DF"><b><Font color="FFFFFF">주소</b></TD>
	</TR>
<%
		strDong	= reString(Request.Form("dong"),"sql")
		strFlag	= reString(Request.Form("flag"),"sql")
		fn	= reString(Request("fn"),"sql")
		n1	= reString(Request("n1"),"sql")
		z1	= reString(Request("z1"),"sql")
		z2	= reString(Request("z2"),"sql")	
		If isNone(strDong) Then
%>
				<TR bgcolor=#ffffff>
				<TD colspan="2" align="center"><br>검색동을 입력한 후 검색해 주세요!<br><br></TD>			
				</TR>
<%	
		Else
			SQL = "SELECT zipcode,sido,gugun,dong,ri,bunji FROM zipcode WHERE Dong like '%"& strDong &"%'"
			Set objAdo = New ADOHelp
			Set objRs = objAdo.RunSQLReturnZipRs(SQL)
			If objRs.EOF Then
				arrRsCnt= -1
			Else
				arrRs	= objRs.GetRows()
				arrRsCnt= Ubound(arrRs,2)
			End IF
			Call CloseDB()
			
			If arrRsCnt = -1 Then
%>
				<TR bgcolor=#ffffff>
				<TD colspan="2" align="center"><br>검색 결과가 없습니다.<BR>검색동을 입력한 후 검색해 주세요!<br></TD>
				</TR>
<%
			Else 
				For i=0 TO arrRsCnt 
%>
				<TR bgcolor=#ffffff>
				<TD width="30%" align=center><%=arrRs(0,i)%></TD>
				<TD width="70%">&nbsp;
					<a href="javascript:pastzipcode('<%=getInfo(arrRs(0,i),0,"-")%>','<%=getInfo(arrRs(0,i),1,"-")%>','<%=arrRs(1,i)%>','<%=arrRs(2,i)%>','<%=arrRs(3,i)%>','<%=arrRs(4,i)%>');"><%=arrRs(1,i)%>&nbsp;&nbsp;<%=arrRs(2,i)%>&nbsp;<%=arrRs(3,i)%>&nbsp;<%=arrRs(4,i)%>   </A>
				</TD>
			</TR>
<%		
				Next
			End If
		End If
%>
	</table>
</FORM>
</BODY>
</HTML>
<script language="javascript">
function pastzipcode(z1,z2,s,g,r,d) {
	<% If Flag="MEM" Then%>
		parent.opener.eval('<%=fn%>.<%=z1%>').value = z1;
		parent.opener.eval('<%=fn%>.<%=z1%>').zip02.value = z2;
		parent.opener.eval('<%=fn%>').addr01.value = s + g + r + d;	
	<% Else %>

	<% End If%>
	<% If Not isNone(n1) Then %>
		parent.opener.eval('<%=fn%>.<%=n1%>').focus()
	<% End If%>
	parent.window.self.close();
}

</script>
