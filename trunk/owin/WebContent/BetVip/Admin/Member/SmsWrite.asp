
<!--	#include virtual="/Admin/top.asp"					-->
<%
	Set objRs = RunSQLReturnRs("SELECT TOP 1 SumCnt FROM Sms_TB Order By Idx DESC")
	If Not objRs.EOF Then SCnt = objRs(0) : Call CloseDB()
		c = 0
	d = 0
	flag = Request("flag")
	Cells = ""
	If Request("flag")="All" THen
		Set objRs = RunSQLReturnRs("SELECT Cell FROM Member_TB ")
		If Not objRs.EOF Then 
			
			Do Until objRs.EOF
				If Not isNone(replace(objRs("Cell"),"-","")) Then Cells = replace(objRs("Cell"),"-","")&","&Cells
			c = c+1
			objRs.MoveNext
			Loop
		End If
		Call CloseDB()
		
	ElseIf Request("flag")="SAll" THen
		Set objRs = RunSQLReturnRs("SELECT Cell FROM Member_TB WHERE Seceid=0 ")
		If Not objRs.EOF Then 
			
			Do Until objRs.EOF
				If Not isNone(replace(objRs("Cell"),"-","")) Then Cells = replace(objRs("Cell"),"-","")&","&Cells
			d = d+1
			objRs.MoveNext
			Loop
		End If
		Call CloseDB()
	
	End If
%>
<script language='javascript'>
	function SmsSend() {
		var frmss = document.frms
		if(!trim(frmss.ReceiverList.value)) {
			alert("수신자(전화번호) 은(는) 필수항목입니다.");
			frmss.ReceiverList.focus();return;
		}
		if(!trim(frmss.SendMsg.value)) {
			alert("내용 은(는) 필수항목입니다.");
			frmss.SendMsg.focus();return;
		}
		
		
		if(parseInt('<%=SCnt%>')==0) {	
			if(confirm('남은 SMS잔여갯수가 없습니다.\n보내시겠습까?')) {
			
			} else {
				return;
			}
		}
		
		frmss.UserData2.value=frmss.SendMsg.value;
//		alert(frmss.UserData2.value);
		document.frms.submit();
	}

</script>
	<body onload="window.focus();">
	<script language='javascript' src=/common/js/common.js></script>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="30" background="/Images/Admin/top1_bg.gif"></td></tr>
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" valign="middle">
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[SMS 보내기]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<TABLE WIDTH=100% BORDER=0 cellspacing="1" cellpadding="3" bgcolor="#aaaaaa">
					<form name="frms" action="http://asp.smsgo.co.kr/remote/Regist/" method="post" >
					<input type="hidden" name="SUserId" value="okbet365">				<% ' 아이디 %>
					<input type="hidden" name="ReturnURL" value="<%=CONF_DOMAIN_NAME%>/Sms_Return.asp">		<% ' 메세지 전송 후 돌아올 URL ( 단 NORETURN - 리턴되지 않음, XML - XML로 리턴 )  %>
					<input type="hidden" name="ReservedChk" value="0">		<% ' 메세지 발송 형태 (즉시 : 0 / 예약 : 1 ) %>
					<input type="hidden" name="ServiceAC" value="KBBIGYPYYU">			<% ' 서비스 인증 번호 ( SMSGO 에서 발급받은 서비스 인증 번호 ) %>
					<input type="hidden" name="UserData2" value="">
					<TR >
						<TD bgcolor="#e0e0e0" width=25%>남은 SMS전송갯수</TD>
						<TD bgcolor="#FFFFFF" width=75%><%=formatnumber(reInt(SCnt,0),[])%> 개</TD>
					</TR>
					<TR >
						<TD bgcolor="#e0e0e0">옵션</TD>
						<TD bgcolor="#FFFFFF">
							<input type="radio" name="flag" value="" <%=gSelection(flag,"","checked")%> onclick="location.href='SmsWrite.asp';">입력
							<input type="radio" name="flag" value="SAll" <%=gSelection(flag,"SAll","checked")%> onclick="location.href='SmsWrite.asp?flag=SAll';">정상회원만(<%=d%>명)
							<input type="radio" name="flag" value="All" <%=gSelection(flag,"All","checked")%> onclick="location.href='SmsWrite.asp?flag=All';">중지회원 포함(전체회원)(<%=c%>명)
						</TD>
					</TR>
					<% If Not isNone(flag) THen %>
					<TR >
						<TD bgcolor="#e0e0e0">수신자(전화번호)</TD>
						<TD bgcolor="#FFFFFF" style="word-break:break-all;">
						<input type="hidden" name="ReceiverList" value="<%=Cells%>" class=input2>
						<% ' 수신번호 (다수에게 전송할 경우 콤마(,) 로 구분 -  ex) 0123456789,0134567890,0145678901 ) %>
						<%=Cells%>
						</TD>
					</TR>
					<% Else %>
					<TR >
						<TD bgcolor="#e0e0e0">수신자(전화번호)</TD>
						<TD bgcolor="#FFFFFF">
						<% ' 수신번호 (다수에게 전송할 경우 콤마(,) 로 구분 -  ex) 0123456789,0134567890,0145678901 ) %>
						<input type="text" name="ReceiverList" value="<%=Cells%>" class=input2> 다수에게 전송할 경우 콤마(,) 로 구분 -  ex) 0123456789,0134567890,0145678901
						</TD>
					</TR>
					<% End If %>
					<TR >
						<TD bgcolor="#e0e0e0">회신번호</TD>
						<TD bgcolor="#FFFFFF">
							<input type="text" name="CallbackPhoneNo" value="" class=input2>	<% ' 회신번호 (숫자만 가능 최대 14자리) %>
						</TD>
					</TR>
					<TR>
						<TD bgcolor="#e0e0e0">내 용</TD>
						<TD bgcolor="#FFFFFF">
						<% ' 전송 메세지 (80Bytes 이내) %>
						<textarea name=SendMsg style="width:290;height:130" Information="Required" MaxBytes="80" title="내용"></textarea>
						</TD>
					</TR>

				</TABLE>
			</td>
		</tr>
		<tr>
			<td>
				<TABLE WIDTH=100% BORDER=0 cellspacing="1" cellpadding="3" >

					<TR>
						<TD colspan=10 align=center> <input type=button value="발 송"  onclick="SmsSend();"><input type=button value="취 소" onclick="window.self.close();" id=button1 name=button1></TD>
					</TR>
					</form>
				</TABLE>
			</td>
		</tr>
	</table>
</BODY>
</HTML>
