<!--	#include virtual="/Admin/top.asp"					-->
<%
	IntIdx		= Request("Idx")
	KeyField	= Request("KeyField")
	KeyWord		= Request("KeyWord")
	CurPage		= Request("CurPage")
	CurBlock	= Request("CurBlock")
	Sect		= Request("Sect")
	flag		= Request("flag")
	ScFlag		= Request("ScFlag")
	League		= Request("League")
	hcont		= Request("hCont")
	vcont		= Request("vCont")
	gName		= Request("gName")
	
'	Response.Write hcont &"<BR>"
'	Response.Write vcont &"<BR>"
	
	bName		= "등록"
	ltitle		= "무/핸디캡"
	
	goPage = "List.asp"
If ScFlag = "2" Then 
	Titles = "마감경기"
	goPage = "CloseList.asp"
Else
Select Case Sect
	Case "1" : Titles = "야구(핸디) " : gName = "야구"
	Case "2" : Titles = "축구(핸디) " : gName = "축구"
	Case "3" : Titles = "농구(핸디) " : gName = "농구"
	Case "4" : Titles = "핸디캡"
	Case "5" : Titles = "승무패" : ltitle = "무"
	Case "6" : Titles = "기타(핸디)" : gName = "농구"
	Case Else Titles = "All "
End Select

End If

	Set objCon = getConnection

	If flag = "MODIFY" Then
		bName		= "수정"
		SQL = "SELECT * FROM Game_TB WHERE Idx='"& IntIdx &"' "	
		Set objRs = getRecordSet(objCon, SQL)
		If objRs.EOF or objRs.BOF Then 
			Call CloseDB() : Call descment("잘못된 요청입니다","back","")
		Else
			Sect		= objRs("Sect")				: gName			= objRs("gName")
			gsDate		= objRs("gsDate")			: League		= objRs("League")
			hTname		= objRs("hTname")			: hAllot		= objRs("hAllot")
			hCap		= objRs("hCap")				: HcapAllotl	= objRs("HcapAllotl")
			vTname		= objRs("vTname")			: vAllot		= objRs("vAllot")
			rtel		= objRs("rtel")				: hcont			= objRs("hcont")
			Status		= objRs("Status")			: WriteDay		= objRs("WriteDay")
			vcont		= objRs("vcont")			: Upflag		= objRs("Upflag")
			UpAllot		= objRs("UpAllot")			: events		= objRs("event")
			gResult		= objRs("gResult")
		End If
		objRs.Close
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
		getQuery["ScFlag"]		= '<%=ScFlag%>';
		getQuery["Idx"]			= gId;
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
						<td><font color="#FFFEF6" size="4"><b>[<%=Titles%> 관리]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>

		<tr>
			<td>				
				
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa" align=center>
					
					<form name=regfrm method=post onsubmit="return DefaultFormValidation(this);" action="Write_Prc.asp" >
					<input type=HIDDEN name="CurPage" value="<%=CurPage%>">
					<input type=HIDDEN name="CurBlock" value="<%=CurBlock%>">
					<input type=HIDDEN name="KeyField" value="<%=KeyField%>">
					<input type=HIDDEN name="KeyWord" value="<%=KeyWord%>">
					<input type=HIDDEN name="Idx" value="<%=IntIdx%>">
					<input type=HIDDEN name="flag" value="<%=flag%>">				
					<input type=HIDDEN name="ScFlag" value="<%=ScFlag%>">
					<tr bgcolor="#e0e0e0"><td colspan=10 height=30><b>&nbsp;&nbsp;&nbsp;&nbsp;경기 정보</td></tr>

					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;경기일시</td>
						<td colspan=4 bgcolor="#FFFFFF">
							<select name="year" Information="Required" title="년도" >
								<option value="">==년도==</option>
								
								
<%
							For i=Year(now()) To Year(now())+3
%>								
								<option <%=gSelection(Left(gsDate,4),i,"selected")%> value="<%=i%>"><%=i%></option>
<%
							Next
%>
							</select >년&nbsp;

							<select name="mon" Information="Required" title="월" >
								<option  value="">==월==</option>
<%
							For i=1 To 12
%>								
								<option <%If Not isNone(gsDate) Then %><%=gSelection(mid(gsDate,6,2),right("0"&i,2),"selected")%><%End If%> value="<%=right("0"&i,2)%>"><%=right("0"&i,2)%></option>
<%
							Next
%>
							</select >월&nbsp;

							<select name="day" Information="Required" title="일" >
								<option value="">==일==</option>
<%
							For i=1 To 31
%>								
								<option <%If Not isNone(gsDate) Then %><%=gSelection(mid(gsDate,9,2),right("0"&i,2),"selected")%><%End If%>  value="<%=right("0"&i,2)%>"><%=right("0"&i,2)%></option>
<%
							Next
%>
							</select >일&nbsp;

							<select name="hour" Information="Required" title="시">
								<option value="">==시==</option>
								<option <%=gSelection(mid(gsDate,12,2),"00","selected")%> value="00">00</option>
<%
							For i=1 To 24
%>								
								<option <%=gSelection(mid(gsDate,12,2),right("0"&i,2),"selected")%> value="<%=right("0"&i,2)%>"><%=right("0"&i,2)%></option>
<%
							Next
%>
							</select >시&nbsp;
							
							<select name="min" Information="Required" title="분">
								<option value="">==분==</option>
								<option <%=gSelection(mid(gsDate,15,2),"00","selected")%> value="00">00</option>
<%
							For i=1 To 59
%>								
								<option <%=gSelection(mid(gsDate,15,2),right("0"&i,2),"selected")%> value="<%=right("0"&i,2)%>"><%=right("0"&i,2)%></option>
<%
							Next
%>
							</select >분&nbsp;
						</td>
					</tr>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;종목구분</td>
						<td bgcolor="#FFFFFF">
							<select name="Sect" Information="Required" title="종목구분" >
								<option value="">==선택==</option>
								<option <%=gSelection(Sect,5,"selected")%> value="5">승무패</option>
								<option <%=gSelection(Sect,1,"selected")%> value="1">야구(핸디)</option>
								<option <%=gSelection(Sect,2,"selected")%> value="2">축구(핸디)</option>
								<option <%=gSelection(Sect,3,"selected")%> value="3">농구(핸디)</option>
								<option <%=gSelection(Sect,6,"selected")%> value="6">기타(핸디)</option>
								<!--<option <%=gSelection(Sect,4,"selected")%> value="4">핸디캡</option>-->
							</select>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;종 목</td>
						<td bgcolor="#FFFFFF">									
							<input type=text name=gName size=20 value="<%=gName%>" Information="Required" title="종목" class=text > 
						</td>
					</tr>
					<tr >
						
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;리 그</td>
						<td colspan=4 bgcolor="#FFFFFF"><input type=text name=League size=20 value="<%=League%>" Information="Required" title="리그" class=text > </td>
					</tr>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;승(홈팀)</td>
						<td bgcolor="#FFFFFF"><input type=text name=hTname size=30 value="<%=hTname%>" Information="Required" title="승(홈팀)" class=text > &nbsp;&nbsp;</td>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;배당율</td>
						<td bgcolor="#FFFFFF"><input type=text name=hAllot size=20 value="<%=hAllot%>" Information="Required" title="승(홈팀) 배당율" class=text > &nbsp;&nbsp;</td>
					</tr>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;<%=ltitle%></td>
						<td bgcolor="#FFFFFF"><input type=text name=hCap size=20 value="<%=hCap%>" title="<%=ltitle%>" MaxBytes="100" class=text></td>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;배당율</td>
						<td bgcolor="#FFFFFF"><input type=text name=HcapAllotl size=20 value="<%=HcapAllotl%>" title="핸디캡 배당율" class=text > &nbsp;&nbsp;</td>
					</tr>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;패(원정팀)</td>
						<td bgcolor="#FFFFFF"><input type=text name=vTname size=30 value="<%=vTname%>" Information="Required" title="패(원정팀)" MaxBytes="100" class=text></td>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;배당율</td>
						<td bgcolor="#FFFFFF"><input type=text name=vAllot size=20 value="<%=vAllot%>" Information="Required" title="패(원정팀) 배당율" class=text > &nbsp;&nbsp;</td>
					</tr>
					
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;상태</td>
						<td bgcolor="#FFFFFF">
							<input type=radio name=Status value="1" <%=gSelection(reInt(Status,1),1,"checked")%> > 배팅
							<input type=radio name=Status value="0" <%=gSelection(Status,0,"checked")%> > 마감
							<input type=radio name=Status value="2" <%=gSelection(Status,2,"checked")%> > 마감경기
							<input type=radio name=Status value="4" <%=gSelection(Status,4,"checked")%> onclick="alert('경기결과도 취소로 변경해야\n\n예상적중금액이 실제 적립 됩니다')"> 취소
							<input type=radio name=Status value="3" <%=gSelection(Status,3,"checked")%> > 숨김
							
						</td>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;이벤트 여부</td>
						<td bgcolor="#FFFFFF">
							<input type=radio name=event value="1" <%=gSelection(events,1,"checked")%> > 예
							<input type=radio name=event value="0" <%=gSelection(reInt(events,0),0,"checked")%> > 아니요
						</td>
					</tr>
					<% If flag="MODIFY" Then %>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;배당변경</td>
						<td bgcolor="#FFFFFF">
							<input type=radio name=Upflag value="0" <%=gSelection(Upflag,0,"checked")%> > 아니요
							<input type=radio name=Upflag value="1" <%=gSelection(Upflag,1,"checked")%> > 예
						</td>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;변경값</td>
						<td bgcolor="#FFFFFF">
							<input type=text name=UpAllot size=30 value="<%=UpAllot%>" title="변경값" class=text > &nbsp;&nbsp;
						</td>
					</tr>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;경기결과</td>
						<td <% If Sect<>5 Then %> colspan=4 <% End If %> bgcolor="#FFFFFF"><input type=text name=rtel size=20 value="<%=rtel%>" title="경기결과" MaxBytes="100" class=text></td>
						<% If Sect=5 Then %>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;경기결과</td>
						<td bgcolor="#FFFFFF">
							<input type=radio name=gResult size=20 value="0" <%=gSelection(reInt(gResult,0),0,"checked")%>>경기중
							<input type=radio name=gResult size=20 value="1" <%=gSelection(gResult,1,"checked")%> onclick="alert('경기 결과를 변경하면\n\n관련된 경기모두 적중일 경우\n\n예상적중금액이 실제 적립 됩니다')">승
							<input type=radio name=gResult size=20 value="2" <%=gSelection(gResult,2,"checked")%> onclick="alert('경기 결과를 변경하면\n\n관련된 경기모두 적중일 경우\n\n예상적중금액이 실제 적립 됩니다')">패
							<input type=radio name=gResult size=20 value="3" <%=gSelection(gResult,3,"checked")%> onclick="alert('경기 결과를 변경하면\n\n관련된 경기모두 적중일 경우\n\n예상적중금액이 실제 적립 됩니다')">무
							<input type=radio name=gResult size=20 value="4" <%=gSelection(gResult,4,"checked")%> onclick="alert('경기 결과를 변경하면\n\n관련된 경기모두 적중일 경우\n\n예상적중금액이 실제 적립 됩니다')">취소
							
						</td>
						<% End If %>
					</tr>
					<% End If %>
					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;홈팀 국기</td>
						<td bgcolor="#FFFFFF">
							<table border=0>
								<tr>
								<% For i=1 To 44 %>
									<td><input type=radio name=hcont value="<%=i%>" <%=gSelection(i,hcont,"checked")%>><img src="/flag/<%=right("0"&i,2)%>.gif" width=22 height=14></td>
								<% 
								If i mod 6=0 Then Response.Write "</tr><tr>"
								Next 
								%>
								</tr>
							</table>
						
						</td>
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;원정팀 국기</td>
						<td bgcolor="#FFFFFF">
							<table border=0>
								<tr>
								<% For i=1 To 44 %>
									<td><input type=radio name=vcont value="<%=i%>" <%=gSelection(i,vcont,"checked")%>><img src="/flag/<%=right("0"&i,2)%>.gif" width=22 height=14></td>
								<% 
								If i mod 6=0 Then Response.Write "</tr><tr>"
								Next 
								%>
								</tr>
							</table>
						
						</td>
					</tr>
					

				</table>
			</td>
		</tr>	
		
		<tr>
			<td align=center><br>
				<table border="0" cellspacing="1" cellpadding="0" >

					<tr height="30" >
						
						<td ><input type=submit value="<%=bName%>" ></td>
						<td ><input type=button value="리스트" onclick="MovePage('','<%=goPage%>','','','');" ></td>
						<%If flag="MODIFY" Then%><td ><input type=button value="삭 제" onclick="if(confirm('삭제된 자료는 복구할 수 없습니다.\n\n삭제하시겠습니까?')){MovePage('<%=IntIdx%>','Write_Prc.asp','DELETE','','');}" id=button1 name=button1></td><%End If%>
					</tr>

				</table>
			</td>
		</tr>
		</form>
		<tr><td height=50></td></tr>
				<tr>

			<td >

				<iframe id="member" name="member" src="betUserList.asp?CurPage=1&KeyField=c.Id&Idx=<%=IntIdx%>" width="800" height="50" frameborder="1" marginwidth="0" marginheight="0" scrolling="no" ></iframe>

			</td>

		</tr>
		
	</table>
</body>
</html>
	