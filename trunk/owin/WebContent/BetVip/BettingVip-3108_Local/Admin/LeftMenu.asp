<html>
<head>
<title>LeftMenu</title>
<link href="/common/CSS/Admin.css" type="text/css" rel="stylesheet">

<style>BODY {
	SCROLLBAR-FACE-COLOR: #f5f5f5; SCROLLBAR-HIGHLIGHT-COLOR: #ffffff; SCROLLBAR-SHADOW-COLOR: #bbbbbb; SCROLLBAR-3DLIGHT-COLOR: #ffffff; SCROLLBAR-ARROW-COLOR: #666666; SCROLLBAR-TRACK-COLOR: #f5f5f5; SCROLLBAR-DARKSHADOW-COLOR: #f5f5f5
}
</style>
</head>
<body style="margin:0" >
<table cellSpacing="0" cellPadding="0" width="190" background="/Images/Admin/right_bg.gif" border="0">
	<tr>
		<td><img src="/Images/Admin/admin_title.gif"></td>
		<td><a href="Index.asp" target="_top"><img src="/Images/Admin/admin_title2.gif" border="0"></a></td></tr>
	<tr>
		<td>&nbsp;</td>
		<td vAlign="top" height="800">
			<table cellSpacing="0" cellPadding="3" width="160" align="center" border="0">

				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr><td bgColor="#ffffff" height="1"></td></tr>
				<tr>
					<td align="middle"><a href="Logout.asp"><font color="#0aa0bb">�α׾ƿ�</font></a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="Edit.asp" target="mainFrame"><font color="#0aa0bb">��й�ȣ����</font></a><br></td>
				</tr>
				<% If Session("SYS_Ssection")=0 Then %>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr><td bgColor="#ffffff" height="1"></td></tr>
				
				<tr>
					<td align="middle" bgColor="#ffffff" height="15"><b>ȸ������</b></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/MemberList.asp" target="mainFrame">ȸ�� ����Ʈ</a><br></td>
				</tr>
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/RainkList.asp" target="mainFrame">������ ��� ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/SmsWrite.asp" target="mainFrame">SMS������ </a><br></td>
				</tr>
				<% If Session("SYS_ID")="IN" Then %>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/SmsList.asp" target="mainFrame">SMS ���븮��Ʈ</a><br></td>
				</tr>
				<% End If %>
				<tr>
					<td align="middle" bgColor="#ffffff" height="15"><b>�ߺ������� ����</b></td>
				</tr>
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/IpList.asp" target="mainFrame">������ ����Ʈ</a><br></td>
				</tr>
				
				<!--
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr><td bgColor="#ffffff" height="1"></td></tr>
				<tr>
					<td align="middle" bgColor="#ffffff" height="15"><b>�� ��ڰ���</b></td>
				</tr>
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/SubAdminList.asp" target="mainFrame">�� ��� ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/SubAdminModify.asp?flag=WRITE" target="mainFrame">�� ��� ���</a><br></td>
				</tr>
				-->
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr><td bgColor="#ffffff" height="1"></td></tr>
				<tr>
					<td align="middle" bgColor="#ffffff" height="15"><b>��������</b></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/CashList.asp?Sect=0" target="mainFrame">������û ����Ʈ</a><br></td>
				</tr>
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/CashList.asp?Sect=1" target="mainFrame">ȯ����û ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/ChCashList.asp?Sect=1" target="mainFrame">����Ʈ��ȯ ����Ʈ</a><br></td>
				</tr>
				<% End If%>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr><td bgColor="#ffffff" height="1"></td></tr>
				<tr>
					<td align="middle" bgColor="#ffffff" height="15"><b>������</b></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/LegList.asp" target="mainFrame">���� ����Ʈ</a><br></td>
				</tr>
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/List.asp?Sect=5" target="mainFrame">�¹��� ����Ʈ</a><br></td>
				</tr>
				<!--
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Member/MPList.asp" target="mainFrame">����������Ʈ���� ����Ʈ</a><br></td>
				</tr>
				-->
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/List.asp?Sect=4" target="mainFrame">�ڵ�ĸ ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/List.asp?Sect=1" target="mainFrame">�߱�(�ڵ�) ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/List.asp?Sect=2" target="mainFrame">�౸(�ڵ�) ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/List.asp?Sect=3" target="mainFrame">��(�ڵ�) ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/List.asp?Sect=6" target="mainFrame">��Ÿ(�ڵ�) ����Ʈ</a><br></td>
				</tr>
				<% If Session("SYS_Ssection")=0 Then %>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/CloseList.asp?ScFlag=2" target="mainFrame">������� ����Ʈ</a><br></td>
				</tr>
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/bMem2.asp?Sect=0" target="mainFrame">�¹��� ���������� ����Ʈ</a><br></td>
				</tr>
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/bMem.asp?Sect=0" target="mainFrame">�ڵ�ĸ ���������� ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/EventbMem.asp?Sect=0" target="mainFrame">�̺�Ʈ ���������� ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Game/bMem.asp?Sect=1" target="mainFrame">����Ϸ� ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr><td bgColor="#ffffff" height="1"></td></tr>
				
				
				<tr>
					<td align="middle" bgColor="#ffffff" height="15"><b>�������</b></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Sum/bSumList.asp" target="mainFrame">���� ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Sum/bList.asp" target="mainFrame">���ó��� ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Sum/bDayList.asp" target="mainFrame">���ں� ���ó��� ����Ʈ</a><br></td>
				</tr>
				<% If Session("SYS_ID")="master" or Session("SYS_ID")="IN" Then %>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Sum/Sum.asp" target="mainFrame">��ü ���</a><br></td>
				</tr>
				<% End If %>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr><td bgColor="#ffffff" height="1"></td></tr>
				<tr>
					<td align="middle" bgColor="#ffffff" height="15"><b>�Խ��� ����</b></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Community/Board/List.asp?TableName=Community_TB&Sect=1" target="mainFrame">���� ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Community/Board/List.asp?TableName=Community_TB&Sect=2" target="mainFrame">�����Խ��� ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Community/Board/List.asp?TableName=Community_TB&Sect=3" target="mainFrame">������ ����Ʈ</a><br></td>
				</tr>
				<% If Session("SYS_ID")="IN" Then %>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Community/Board/InList.asp?TableName=Community_TB&Sect=3" target="mainFrame">dd</a><br></td>
				</tr>
				<% End If %>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="Community/hotnews/List.asp?TableName=Community_TB&Sect=4" target="mainFrame">HOTNEWS ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr><td bgColor="#ffffff" height="1"></td></tr>
				
				
				<tr>
					<td align="middle" bgColor="#ffffff" height="15"><b>������� ����</b></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countMain.asp" target="mainFrame">�⺻���� </a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countYMView.asp?column=cmon&orderby=ASC&emptyStr=&ocolumn=cmon" target="mainFrame">������� ����Ʈ</a><br></td>
				</tr>
				<!--
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countYMView.asp?column=cweek&orderby=ASC&emptyStr=&ocolumn=cweek" target="mainFrame">�ֺ���� ����Ʈ</a><br></td>
				</tr>
				-->
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countYMView.asp?column=cday&orderby=ASC&emptyStr=&ocolumn=cday" target="mainFrame">�Ϻ���� ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<!--
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countYMView.asp?column=chour&orderby=ASC&emptyStr=&ocolumn=chour" target="mainFrame">�ð��뺰��� ����Ʈ</a><br></td>
				</tr>
				
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countYMView.asp?column=csite&orderby=ASC&emptyStr=���ã��&ocolumn=cutCount" target="mainFrame">��������Ʈ��� ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countYMView.asp?column=csearch&orderby=ASC&emptyStr=&ocolumn=cutCount" target="mainFrame">�˻������ ����Ʈ</a><br></td>
				</tr>
								
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countYMView.asp?column=cos&orderby=ASC&emptyStr=�˼�����&ocolumn=cutcount" target="mainFrame">�ü����� ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				<tr>
					<td><img src="/Images/Admin/admin_icon.gif" align="absMiddle"> <a class="menu" href="VisitStatic/countYMView.asp?column=cbrowser&orderby=ASC&emptyStr=�˼�����&ocolumn=cutcount" target="mainFrame">��������� ����Ʈ</a><br></td>
				</tr>
				<tr><td bgColor="#cfcfcf" height="1"></td></tr>
				-->
				<% End If%>
			</table>
		</td>
	</tr>
</table>	
</body>
</html>










