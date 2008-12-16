<!--	#include virtual="/Admin/top.asp"						-->
<!--	#include virtual="/common/asp/MemberClass.asp"			-->
<%
	strId		= Request("Id")
	Sect		= Request("Sect")
	CurPage		= Request("CurPage")
	CurBlock	= Request("CurBlock")
	KeyField	= Request("KeyField")
	KeyWord		= Request("KeyWord")
	Flag		= Request("flag")
	refPage		= IfElse(Request("refPage"),"MemberList.asp")
	If Flag = "MODIFY" Then
		Cash	= replace(Request("Point"),",","")
		TCash	= NowMileage(strId, "Point") '마일리지 정보
		If reInt(Cash,0) <> reInt(TCash,0) Then
		SQL1 = "INSERT INTO Cash_TB (Id,RCash,TCash,ResultCash,Comment,Status,Type,InDay) VALUES('"& strId &"','"& Cash &"','"& TCash &"','"& Cash &"','관리자 캐쉬교정',1,8,getDate())"
		RunSQL(SQL1)
		End If
		SQLs = "UPDATE Member_TB Set Name='"& reString(Request("Names"),"sql") &"', Point = '"& Cash &"',Seceid = '"& Request("Seceid") &"',CDepos = '"& reString(Request("CDepos"),"sql") &"',BankN = '"& reString(Request("BankN"),"sql") &"',BankNum = '"& reString(Request("BankNum"),"sql") &"',RDepos = '"& reString(Request("RDepos"),"sql") &"' WHERE Id='"& strId &"'"
		RunSQL(SQLs)
		
		Call CloseDB()
		Call descment("수정되었습니다.","Modify.asp?Id="&strId&"&CurPage="&CurPage&"&CurBlock="&CurBlock&"&KeyField="&KeyField&"&KeyWord="&KeyWord&"&Sect="&Sect ,"")
	End If
	
	If Flag = "MODIFYSC" Then
		RunSQL("UPDATE Member_TB Set Seceid='"& replace(Request("senum"),",","") &"' WHERE Id='"& strId &"'")
		Call CloseDB()
		Call descment("수정되었습니다.","Modify.asp?Id="&strId&"&CurPage="&CurPage&"&CurBlock="&CurBlock&"&KeyField="&KeyField&"&KeyWord="&KeyWord&"&Sect="&Sect ,"")
	End If

	If Flag = "DELETE" Then
		Call MemberDel(strId)
		Call CloseDB()
		Call descment("삭제되었습니다.","MemberList.asp?CurPage="&CurPage&"&CurBlock="&CurBlock&"&KeyField="&KeyField&"&KeyWord="&KeyWord&"&Sect="&Sect ,"")
	End If
		
	SQL = "SELECT * FROM Member_TB WHERE Id='"& strId &"'"
	Set objRs = RunSQLReturnRs(SQL)
	If objRs.EOF or objRs.BOF Then
		Call CloseDB()
		Call descment("삭제된 회원정보입니다.","back","")		
	End If
%>
<script language='javascript' src=/common/js/common.js></script>
<script language='javascript' src=/common/js/goList.js></script>
<script language='javascript'>
	function MovePage(gId, goP, gfl, gSe, gfrm) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["Id"]			= gId;
		getQuery["senum"]		= gSe;
		getQuery["flag"]		= gfl;
		action(gfrm,goP);
	}

		
</script>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="30" background="/Images/Admin/top1_bg.gif"></td></tr>
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" valign="middle">
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[회원관리]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
	
		<tr>
			<td><br>
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa">
					<tr bgcolor="#e0e0e0"><td colspan=10 height=30><b>&nbsp;&nbsp;&nbsp;&nbsp;회원정보</td></tr>
					<form name=frms method=post action="Modify.asp" onsubmit="return DefaultFormValidation(this);" >
					<input type=hidden name=flag value="MODIFY">
					<input type=hidden name=CurPage value="<%=CurPage%>">
					<input type=hidden name=CurBlock value="<%=CurBlock%>">
					<input type=hidden name=KeyField value="<%=KeyField%>">
					<input type=hidden name=KeyWord value="<%=KeyWord%>">
					<input type=hidden name=id value="<%=strId%>">

					<tr >
						<td width="16%" bgcolor="#e0e0e0">&nbsp;&nbsp;아이디</td>
						<td bgcolor="#FFFFFF"><%=strId%></td>
					</tr>
					<tr>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;성 명</td>
						<td bgcolor="#FFFFFF"><input type=text name=Names size=10 class=input4 value="<%=objRs("Name")%>" Information="Required" MaxBytes="10" title="성명"  ></td>
					</tr>
					<tr>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;비밀번호</td>
						<td bgcolor="#FFFFFF"><%=objRs("Pwd")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;이메일</td>
						<td bgcolor="#FFFFFF"><%=objRs("mail")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;휴대번호</td>
						<td bgcolor="#FFFFFF"><%=objRs("cell")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;충,환전 정보</td>
						<td bgcolor="#FFFFFF">
							<table border=0 cellpadding=0 cellspacing=2>
								<tr>
									<td>충전시 입금자명&nbsp;</td>
									<td><input type=text name=CDepos value="<%=objRs("CDepos")%>" Information="Required" MaxBytes="15" title="충전 시 입금자 명" class=input4> </td>
								</tr>
								<tr>
									<td>환전시 계좌정보&nbsp;</td>
									<td>
									<select name="BankN"  Information="Required" title="거래은행">
										<option value="" selected>선택</option>
										<option <%=gSelection(objRs("BankN"),"신한","selected")%> value="신한">신한</option>
										<option <%=gSelection(objRs("BankN"),"국민","selected")%> value="국민">국민</option>
										<option <%=gSelection(objRs("BankN"),"주택","selected")%> value="주택">주택</option>
										<option <%=gSelection(objRs("BankN"),"농협중앙","selected")%> value="농협중앙">농협중앙</option>
										<option <%=gSelection(objRs("BankN"),"단위농협","selected")%> value="단위농협">단위농협</option>
										<option <%=gSelection(objRs("BankN"),"우리","selected")%> value="우리">우리</option>
										<option <%=gSelection(objRs("BankN"),"조흥","selected")%> value="조흥">조흥</option>
										<option <%=gSelection(objRs("BankN"),"외환","selected")%> value="외환">외환</option>
										<option <%=gSelection(objRs("BankN"),"하나","selected")%> value="하나">하나</option>
										<option <%=gSelection(objRs("BankN"),"한미","selected")%> value="한미">한미</option>
										<option <%=gSelection(objRs("BankN"),"제일","selected")%> value="제일">제일</option>
										<option <%=gSelection(objRs("BankN"),"서울","selected")%> value="서울">서울</option>
										<option <%=gSelection(objRs("BankN"),"기업","selected")%> value="기업">기업</option>
										<option <%=gSelection(objRs("BankN"),"평화","selected")%> value="평화">평화</option>
										<option <%=gSelection(objRs("BankN"),"우체국","selected")%> value="우체국">우체국</option>
										<option <%=gSelection(objRs("BankN"),"경남","selected")%> value="경남">경남</option>
										<option <%=gSelection(objRs("BankN"),"광주","selected")%> value="광주">광주</option>
										<option <%=gSelection(objRs("BankN"),"대구","selected")%> value="대구">대구</option>
										<option <%=gSelection(objRs("BankN"),"부산","selected")%> value="부산">부산</option>
										<option <%=gSelection(objRs("BankN"),"산업","selected")%> value="산업">산업</option>
										<option <%=gSelection(objRs("BankN"),"수협","selected")%> value="수협">수협</option>
										<option <%=gSelection(objRs("BankN"),"전북","selected")%> value="전북">전북</option>
										<option <%=gSelection(objRs("BankN"),"제주","selected")%> value="제주">제주</option>
										<option <%=gSelection(objRs("BankN"),"씨티","selected")%> value="씨티">씨티</option>
										<option <%=gSelection(objRs("BankN"),"암로","selected")%> value="암로">암로</option>
										<option <%=gSelection(objRs("BankN"),"도이치","selected")%> value="도이치">도이치</option>
										<option <%=gSelection(objRs("BankN"),"HSBC","selected")%> value="HSBC">HSBC</option>
										<option <%=gSelection(objRs("BankN"),"상와","selected")%> value="상와">상와</option>
										<option <%=gSelection(objRs("BankN"),"BOA","selected")%> value="BOA">BOA</option>
										<option <%=gSelection(objRs("BankN"),"새마을","selected")%> value="새마을">새마을</option>
										<option <%=gSelection(objRs("BankN"),"신용협동","selected")%> value="신용협동">신용협동</option>
										<option <%=gSelection(objRs("BankN"),"상호저축","selected")%> value="상호저축">상호저축</option>
									</select>
										&nbsp;&nbsp;계좌번호
										<input type=text name=BankNum value="<%=objRs("BankNum")%>" Information="Required" MaxBytes="25" title="계좌번호" size=30 class=input4>
										&nbsp;&nbsp;예금주
										<input type=text name=RDepos value="<%=objRs("RDepos")%>" Information="Required" MaxBytes="15" title="예금주" size=10 class=input4>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;SMS수신여부</td>
						<td bgcolor="#FFFFFF"><%If objRs("gSMS")="1" Then%>수신<%Else%>거부<%End If%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;가입일</td>
						<td bgcolor="#FFFFFF"><%=objRs("WriteDay")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;가입당시 아이피</td>
						<td bgcolor="#FFFFFF"><%=objRs("Writeip")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;최초 로그인</td>
						<td bgcolor="#FFFFFF"><%=objRs("Flogin")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;최초로그인 아이피</td>
						<td bgcolor="#FFFFFF"><%=objRs("FloginIp")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;마지막 로그인</td>
						<td bgcolor="#FFFFFF"><%=objRs("Llogin")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;마지막 아이피</td>
						<td bgcolor="#FFFFFF"><%=objRs("LloginIp")%></td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;방문횟수</td>
						<td bgcolor="#FFFFFF"><%=formatnumber(objRs("Visitnum"),[])%> 회</td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;회원상태</td>
						<td bgcolor="#FFFFFF">
							<input type=radio name="Seceid" value="0" <%=gSelection(objRs("Seceid"),0,"checked")%> >정상
							<input type=radio name="Seceid" value="1" <%=gSelection(objRs("Seceid"),1,"checked")%> >이용중지
							<input type=radio name="Seceid" value="2" <%=gSelection(objRs("Seceid"),2,"checked")%> >IP차단
						
						</td>
					</tr>
					<tr>	
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;회원도메인</td>
						<td bgcolor="#FFFFFF"><%=objRs("VipFlag")%></td>
					</tr>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;현재보유 캐쉬</td>
						<td bgcolor="#FFFFFF"><input type=text name=Point size=10 class=input4 value="<%=formatnumber(objRs("Point"),[])%>" onkeyup="if(event.keyCode>40 || event.keyCode<33)this.value=MoneyFormat(this.value)"  Information="Required" MaxBytes="10" title="현재보유캐쉬"  OnKeydown="onlyNumber();"  >원</td>
					</tr>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;현재보유 포인트</td>
						<td bgcolor="#FFFFFF"><%=formatnumber(objRs("APoint"),[])%> 원&nbsp;&nbsp;<!--<input type=button value="적립게임 내역보기" class="btn1"  onclick="MM_winopen('../Game/MisPGameList.asp?Id=<%=strId%>','MPGL','width=980,height=400,scrollbars=1');" >--></td>
					</tr>					
				</table>
			</td>
		</tr>
		<tr>
			<td align=center><br>
				<table border="0" cellspacing="1" cellpadding="0" >

					<tr height="30" >
						<td ><input type=submit value="수정"  id=submit1 name=submit1></td>
						<td ><input type=button value="리스트" onclick="MovePage('','<%=refPage%>','','','');"></td>
						<td ><input type=button value="중 지" onclick="MovePage('<%=strId%>','Modify.asp','MODIFYSC',1,'');" ></td>
						<td ><input type=button value="중지해제" onclick="MovePage('<%=strId%>','Modify.asp','MODIFYSC',0,'');"  id=button2 name=button2></td>
						<td ><input type=button value="삭 제" onclick="if(confirm('삭제된 회원은 복구할 수 없습니다.\n\n삭제하시겠습니까?')){MovePage('<%=strId%>','Modify.asp','DELETE','','');}" id=button1 name=button1></td>
					</tr>
				</form>
				</table>
			</td>
		</tr>
		<tr>
			<td >
				<iframe id="member" name="member" src="SubModifyList.asp?CurPage=1&Id=<%=strId%>" width="800" height="50" frameborder="1" marginwidth="0" marginheight="0" scrolling="no" ></iframe>
			</td>
		</tr>
		<tr><td height=50></td></tr>
		<tr>
			<td >
				<iframe id="mplist" name="mplist" src="SubMPList.asp?CurPage=1&Id=<%=strId%>" width="800" height="50" frameborder="1" marginwidth="0" marginheight="0" scrolling="no" ></iframe>
			</td>
		</tr>
	</table>
</body>
</html>
<%
Call CloseDB()
%>
	