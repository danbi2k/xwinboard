<!--	#include virtual=/common/asp/Connect.asp	-->
<!--	#include virtual=/common/asp/config.asp	-->
<!--	#include virtual=/common/asp/UtilityClass.asp	-->
<!--	#include virtual=/common/asp/MemberClass.asp	-->
<%
	okflag = 0
	flag = IfElse(Request("flag"),"FID")
	If Request("act") = "FIND" Then
		If flag = "FID" Then
			strMail = reString(Request("mail01"),"sql") &"@"& reString(Request("mail02"),"sql")
			Set objRs = RunSQLReturnRs("SELECT * FROM Member_TB WHERE Mail='"& strMail &"' ")
			If objRs.EOF or objRs.BOF Then
				Call descment("1��ġ�ϴ� ������ �����ϴ�. �ٽ��ѹ� Ȯ���� �ּ���.","FindIdPwd.asp","")
			Else
				
				If trim(Request("cell01")&"-"&Request("cell02")&"-"&Request("cell03"))<>trim(objRs("Cell")) Then
					Call descment("2��ġ�ϴ� ������ �����ϴ�. �ٽ��ѹ� Ȯ���� �ּ���.","FindIdPwd.asp","")
					
				Else
					okflag = 1
					strTitle = "���̵�"
					strValue = objRs("Id")
		
				End IF
			End IF
		
		ElseIf flag = "FPWD" Then
			strMail = reString(Request("mail01"),"sql") &"@"& reString(Request("mail02"),"sql")
			Set objRs = RunSQLReturnRs("SELECT * FROM Member_TB WHERE Mail='"& strMail &"' ")
			If objRs.EOF or objRs.BOF Then
				Call descment("1��ġ�ϴ� ������ �����ϴ�. �ٽ��ѹ� Ȯ���� �ּ���.","FindIdPwd.asp","")
			Else
				
				If trim(Request("cell01")&"-"&Request("cell02")&"-"&Request("cell03"))<>trim(objRs("Cell")) Then
					Call descment("2��ġ�ϴ� ������ �����ϴ�. �ٽ��ѹ� Ȯ���� �ּ���.","FindIdPwd.asp","")
					
				ElseIf trim(Request("fid"))<>trim(objRs("Id")) Then
					Call descment("3��ġ�ϴ� ������ �����ϴ�. �ٽ��ѹ� Ȯ���� �ּ���.","FindIdPwd.asp","")
				
				Else
					okflag = 1
					strTitle = "��й�ȣ"
					strValue = objRs("Pwd")

				End IF
			End IF
				
		End IF
		
	End If 
%>	
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<META http-equiv="Pragma" content="no-cache">
<link href="/common/css/style.css" rel="stylesheet" type="text/css">
<link href="/common/css/default.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/js/common.js"></script>
<title>���̵�/���ã��</title>
</HEAD>
<script Language="Javascript">
function right(e) {  // ������ ���콺 ����
if (navigator.appName == "Netscape" && (e.which == 3 || e.which == 2)) {
return false;
} 

}

document.onmousedown=right;
document.onmouseup=right;
if (document.layers) {
window.captureEvents(Event.MOUSEDOWN);
window.captureEvents(Event.MOUSEUP);
window.onmousedown=right;
window.onmouseup=right;
}

function cnj_click() {  
if((event.ctrlKey) && (event.keyCode == 82)) { // Ctrl+R : ���� �ٽ� ���� 
return false;
}

if((event.ctrlKey) && (event.keyCode == 114)) { 
return false;
}


if((event.ctrlKey) && (event.keyCode == 78)) {  
return false;
}

if((event.ctrlKey) && (event.keyCode == 110)) { 
return false;
}

}
if (document.layers) {
document.captureEvents(Event.MouseDown);//protect from keyboard keypress

function keypressed() {
alert("Ű�۵��� �ȵ˴ϴ�.  ^^");  
}
}
document.onmousedown=cnj_click
document.onkeydown=cnj_click
</script>


<BODY style="margin:0" bgcolor=000000 >

<table border="7" width=99% height=230 cellpadding="5" cellspacing="0" align=center>
	<tr>
		<td>
													
													
			<table border="0" cellpadding="0" cellspacing="0" width=99%>
				<tr><td height=10></td></tr>
				<tr>
					<td ><b>�� ���̵�/��й�ȣ ã��</td>
				</tr>
				<tr><td height=10></td></tr>
				<% If reInt(okflag,0) = 0 Then %>
				<tr>
					<td>
						<table border="0" cellpadding="0" cellspacing="0" width=100%>
							<form name=rform action="FindIdPwd.asp" method=post onsubmit="return DefaultFormValidation(this);"  >
							<input type="hidden" name=act value="FIND">
							<tr><td height=2 colspan=10 bgcolor=393839></td></tr>
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
							<tr height=30 >
								<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>����&nbsp;&nbsp;&nbsp;</td>
								<td>&nbsp;
									<input type=radio name=flag value="FID" <%=gSelection(flag,"FID","checked")%> onclick="location.href='FindIdPwd.asp?flag=FID'">���̵� ã��
									<input type=radio name=flag value="FPWD" <%=gSelection(flag,"FPWD","checked")%> onclick="location.href='FindIdPwd.asp?flag=FPWD'">��й�ȣ ã��
								</td>
							</tr>
							<% If flag = "FPWD" Then %>
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
							<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
							<tr height=30 >
								<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>���̵�&nbsp;&nbsp;&nbsp;</td>
								<td>&nbsp;
									<input type=text name="fid" Information="Required" MaxBytes="15" title="���̵�" class=input11>
								</td>
							</tr>
							<% End If %>
																
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
							<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
							<tr height=30 >
								<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>�̸���&nbsp;&nbsp;&nbsp;</td>
								<td>&nbsp;
									<input type=text name="mail01" Information="Required" MaxBytes="30" title="�̸���" size=12 class=input11> <font color=FFFFFF>@ <input type=text size=12 Information="Required" MaxBytes="50" title="�̸���" name="mail02" class=input11>  
									<select class=select1 onchange="rform.mail02.value=this.value" name="mail03">
										<option value="" selected>�����Է�</option>
										<option value="naver.com">���̹�</option>
										<option value="nate.com">����Ʈ</option>
										<option value="dreamwiz.com">�帲����</option>
										<option value="yahoo.co.kr">�����ڸ���</option>
										<option value="empal.com">���Ľ�</option>
										<option value="orgio.net">��������</option>
										<option value="weppy.com">����</option>
										<option value="unitel.co.kr">������</option>
										<option value="chollian.net">õ����</option>
										<option value="korea.com">�ڸ��ƴ���</option>
										<option value="freechal.com">����ç</option>
										<option value="hitel.net">������</option>
										<option value="hotmail.com">�ָ���</option>
									</select>
								</td>
							</tr>
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
							<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
							<tr height=30 >
								<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>�޴��� ��ȣ&nbsp;&nbsp;&nbsp;</td>
								<td>&nbsp;
									<input type=text size=4 name=cell01 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="�޴�����ȣ" maxlength=4 class=input11> <font color=FFFFFF>- <input type=text size=4 name=cell02 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="�޴�����ȣ" maxlength=4 class=input11> - <input type=text size=4 name=cell03 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="�޴�����ȣ" maxlength=4 class=input11>
								</td>
							</tr>
																
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
							<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
						</table>
					</td>
				</tr>
													
				<tr><td height=10></td></tr>
				<tr>
					<td align=center>
						<table border="0" cellpadding="0" cellspacing="0" width=100%>
																
								<td align=center>
									<input type=submit class=btn6 value="�� ��" id=submit1 name=submit1>
									<input type=button class=btn8 value="�� ��" onclick="window.self.close();" id=button1 name=button1>
								</td>
							</tr>
																
						</table>
					</td>
				</tr>
				</form>									
													
													
				<% Else %>
				<tr>
					<td>
						<table border="0" cellpadding="0" cellspacing="0" width=100%>
							<tr><td height=2 colspan=10 bgcolor=393839></td></tr>
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
							<tr height=30 >
								<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b><%=strTitle%>&nbsp;&nbsp;&nbsp;</td>
								<td>&nbsp;<%=strValue%></td>
							</tr>
																
																
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
							<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
						</table>
					</td>
				</tr>
													
				<tr><td height=10></td></tr>
				<tr>
					<td align=center>
						<table border="0" cellpadding="0" cellspacing="0" width=100%>
																
								<td align=center>
									<input type=button class=btn8 value="�ٽð˻�" onclick="location.href='FindIdPwd.asp?flag=<%=flag%>';">
									<input type=button class=btn8 value="�� ��" onclick="window.self.close();" >
								</td>
							</tr>
																
						</table>
					</td>
				</tr>
				
				<% End If %>
				
			</table>
									
		</td>
	</tr>							
</table>
</body>
</html>
							