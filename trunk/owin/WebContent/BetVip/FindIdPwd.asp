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
				Call descment("1일치하는 정보가 없습니다. 다시한번 확인해 주세요.","FindIdPwd.asp","")
			Else
				
				If trim(Request("cell01")&"-"&Request("cell02")&"-"&Request("cell03"))<>trim(objRs("Cell")) Then
					Call descment("2일치하는 정보가 없습니다. 다시한번 확인해 주세요.","FindIdPwd.asp","")
					
				Else
					okflag = 1
					strTitle = "아이디"
					strValue = objRs("Id")
		
				End IF
			End IF
		
		ElseIf flag = "FPWD" Then
			strMail = reString(Request("mail01"),"sql") &"@"& reString(Request("mail02"),"sql")
			Set objRs = RunSQLReturnRs("SELECT * FROM Member_TB WHERE Mail='"& strMail &"' ")
			If objRs.EOF or objRs.BOF Then
				Call descment("1일치하는 정보가 없습니다. 다시한번 확인해 주세요.","FindIdPwd.asp","")
			Else
				
				If trim(Request("cell01")&"-"&Request("cell02")&"-"&Request("cell03"))<>trim(objRs("Cell")) Then
					Call descment("2일치하는 정보가 없습니다. 다시한번 확인해 주세요.","FindIdPwd.asp","")
					
				ElseIf trim(Request("fid"))<>trim(objRs("Id")) Then
					Call descment("3일치하는 정보가 없습니다. 다시한번 확인해 주세요.","FindIdPwd.asp","")
				
				Else
					okflag = 1
					strTitle = "비밀번호"
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
<title>아이디/비번찾기</title>
</HEAD>
<script Language="Javascript">
function right(e) {  // 오른쪽 마우스 금지
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
if((event.ctrlKey) && (event.keyCode == 82)) { // Ctrl+R : 문서 다시 읽음 
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
alert("키작동이 안됩니다.  ^^");  
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
					<td ><b>▒ 아이디/비밀번호 찾기</td>
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
								<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>구분&nbsp;&nbsp;&nbsp;</td>
								<td>&nbsp;
									<input type=radio name=flag value="FID" <%=gSelection(flag,"FID","checked")%> onclick="location.href='FindIdPwd.asp?flag=FID'">아이디 찾기
									<input type=radio name=flag value="FPWD" <%=gSelection(flag,"FPWD","checked")%> onclick="location.href='FindIdPwd.asp?flag=FPWD'">비밀번호 찾기
								</td>
							</tr>
							<% If flag = "FPWD" Then %>
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
							<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
							<tr height=30 >
								<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>아이디&nbsp;&nbsp;&nbsp;</td>
								<td>&nbsp;
									<input type=text name="fid" Information="Required" MaxBytes="15" title="아이디" class=input11>
								</td>
							</tr>
							<% End If %>
																
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
							<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
							<tr height=30 >
								<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>이메일&nbsp;&nbsp;&nbsp;</td>
								<td>&nbsp;
									<input type=text name="mail01" Information="Required" MaxBytes="30" title="이메일" size=12 class=input11> <font color=FFFFFF>@ <input type=text size=12 Information="Required" MaxBytes="50" title="이메일" name="mail02" class=input11>  
									<select class=select1 onchange="rform.mail02.value=this.value" name="mail03">
										<option value="" selected>직접입력</option>
										<option value="naver.com">네이버</option>
										<option value="nate.com">네이트</option>
										<option value="dreamwiz.com">드림위즈</option>
										<option value="yahoo.co.kr">야후코리아</option>
										<option value="empal.com">엠파스</option>
										<option value="orgio.net">오르지오</option>
										<option value="weppy.com">웹피</option>
										<option value="unitel.co.kr">유니텔</option>
										<option value="chollian.net">천리안</option>
										<option value="korea.com">코리아닷컴</option>
										<option value="freechal.com">프리챌</option>
										<option value="hitel.net">하이텔</option>
										<option value="hotmail.com">핫메일</option>
									</select>
								</td>
							</tr>
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
							<tr><td height=1 colspan=10 bgcolor=393839></td></tr>
							<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
							<tr height=30 >
								<td width=100 bgcolor=4A494A align=right><font color=9C9A9C><b>휴대폰 번호&nbsp;&nbsp;&nbsp;</td>
								<td>&nbsp;
									<input type=text size=4 name=cell01 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="휴대폰번호" maxlength=4 class=input11> <font color=FFFFFF>- <input type=text size=4 name=cell02 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="휴대폰번호" maxlength=4 class=input11> - <input type=text size=4 name=cell03 Information="Required" MaxBytes="4" TextFormat="ONLYNUMBER" OnKeydown="onlyNumber();" title="휴대폰번호" maxlength=4 class=input11>
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
									<input type=submit class=btn6 value="검 색" id=submit1 name=submit1>
									<input type=button class=btn8 value="닫 기" onclick="window.self.close();" id=button1 name=button1>
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
									<input type=button class=btn8 value="다시검색" onclick="location.href='FindIdPwd.asp?flag=<%=flag%>';">
									<input type=button class=btn8 value="닫 기" onclick="window.self.close();" >
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
							