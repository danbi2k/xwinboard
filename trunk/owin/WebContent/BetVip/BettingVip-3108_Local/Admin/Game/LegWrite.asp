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
	bName		= "등록"
	ltitle		= "무/핸디캡"
	Set objCon = getConnection

	If flag = "MODIFY" Then
		bName		= "수정"
		SQL = "SELECT * FROM Leag_TB WHERE Idx='"& IntIdx &"' "	
		Set objRs = getRecordSet(objCon, SQL)
		If objRs.EOF or objRs.BOF Then 
			Call CloseDB() : Call descment("잘못된 요청입니다","back","")
		Else
			Sect		= objRs("Sect")			: gName			= objRs("gName")
			League		= objRs("League")
			hcont		= objRs("hcont")		: vcont		= objRs("vcont")
		End If
		objRs.Close
		ElseIf flag = "WRITEACT" Then		SQL = "INSERT INTO Leag_TB (Sect, League, hcont, vcont, gName) VALUES('"& Request("Sect") &"','"& reString(Request("League"),"sql") &"','"& Request("hcont") &"','"& Request("vcont") &"','"& reString(Request("gName"),"sql") &"') "		RunSQL(SQL)
		Call descment("","LegList.asp","")					
	ElseIf flag = "MODIFYACT" Then		SQL = "UPDATE Leag_TB Set Sect='"& Request("Sect") &"',League='"& reString(Request("League"),"sql") &"',hcont='"& Request("hcont") &"',vcont='"& Request("vcont") &"',gName='"& reString(Request("gName"),"sql") &"' WHERE Idx='"& IntIdx &"'"		RunSQL(SQL)
		Call descment("수정 되었습니다.","LegList.asp","")
			ElseIf flag = "DELETE" Then		RunSQL("DELETE FROM Leag_TB WHERE Idx='"& IntIdx &"'")		Call descment("삭제되었습니다.","LegList.asp","")		
	End If		If flag = "MODIFY" Then 
		flag = "MODIFYACT"	ElseIf flag = "WRITE" Then 		flag = "WRITEACT"	End If
	
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
						<td><font color="#FFFEF6" size="4"><b>[리그 관리]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>

		<tr>
			<td>				
				
				<table width="790" border="0" cellspacing="1" cellpadding="3" bgcolor="#aaaaaa" align=center>
					
					<form name=regfrm method=post onsubmit="return DefaultFormValidation(this);" action="LegWrite.asp" >
					<input type=HIDDEN name="CurPage" value="<%=CurPage%>">
					<input type=HIDDEN name="CurBlock" value="<%=CurBlock%>">
					<input type=HIDDEN name="KeyField" value="<%=KeyField%>">
					<input type=HIDDEN name="KeyWord" value="<%=KeyWord%>">
					<input type=HIDDEN name="Idx" value="<%=IntIdx%>">
					<input type=HIDDEN name="flag" value="<%=flag%>">				
					<tr bgcolor="#e0e0e0"><td colspan=10 height=30><b>&nbsp;&nbsp;&nbsp;&nbsp;리그 정보</td></tr>

					<tr >
						<td bgcolor="#e0e0e0">&nbsp;&nbsp;종목구분</td>
						<td bgcolor="#FFFFFF">
							<select name="Sect" Information="Required" title="종목구분" >
								<option value="">==선택==</option>
								<option <%=gSelection(Sect,5,"selected")%> value="5">승무패</option>
								<option <%=gSelection(Sect,1,"selected")%> value="1">야구(핸디)</option>
								<option <%=gSelection(Sect,2,"selected")%> value="2">축구(핸디)</option>
								<option <%=gSelection(Sect,3,"selected")%> value="3">농구(핸디)</option>								<option <%=gSelection(Sect,6,"selected")%> value="6">기타(핸디)</option>
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
						<td ><input type=button value="리스트" onclick="MovePage('','LegList.asp','','','');" ></td>
						<%If flag="MODIFY" Then%><td ><input type=button value="삭 제" onclick="MovePage('<%=IntIdx%>','LegWrite.asp','DELETE','','');" id=button1 name=button1></td><%End If%>
					</tr>

				</table>
			</td>
		</tr>

		<tr><td height=50></td></tr>
		</form>
	</table>
</body>
</html>
	