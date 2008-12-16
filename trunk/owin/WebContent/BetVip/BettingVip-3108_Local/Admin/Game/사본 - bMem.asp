
<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<%IntIdx		= Request("Idx")pageSize = 20

goPage		= Request("goPage")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
Flag		= Request("Flag")
Sect		= Request("Sect")
If Flag="MODIFY" Then
	SQL = "UPDATE BetGame_TB Set rMoney="& reInt(Request("rMoney"),0) &", ResuFlag="& Request("ResuFlag") &" WHERE gCnt='"& Request("gGcnt") &"'"
'	SQL = "UPDATE BetGame_TB Set rMoney="& reInt(Request("rMoney"),0) &", ResuFlag="& Request("ResuFlag") &" WHERE Idx='"& Request("cIdx") &"'"
'	Response.Write SQL
'	Response.End
	RunSQL(SQL)
	
	Call descment("","bMem.asp?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&goPage="& Request("CurPage") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&Idx="& IntIdx &"&Sect="& Request("Sect") ,"")	
End If

%>

<script language='javascript' src=/common/js/goList.js></script>
<script language='javascript'>
	function MovePage(gId, goP, gfl, gSe, gfrm) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["ScFlag"]		= '<%=ScFlag%>';		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["Idx"]			= '<%=IntIdx%>';		getQuery["cIdx"]		= gId;
		getQuery["flag"]		= gfl;
		action(gfrm,goP);
	}

	function ReSortList(SortColumn,Sort) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';			getQuery["ScFlag"]		= '<%=ScFlag%>';
		getQuery["SortColumn"]	= SortColumn;
		getQuery["Sort"]		= Sort;
		action('',window.location.pathname);
	}	
	
	function ListPageGo(PageIndex) {
		getQuery["CurPage"]		= PageIndex;
		getQuery["CurBlock"]	= '<%=CurBlock%>';	
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';			getQuery["KD1"]			= '<%=KD1%>';
		getQuery["KD2"]			= '<%=KD2%>';		getQuery["ScFlag"]		= '<%=ScFlag%>';
		action();
	}
</script><body style="margin:0">
<script language='javascript' src=/common/js/common.js></script>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="30" background="/Images/Admin/top1_bg.gif"></td></tr>
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" valign="middle">
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[베팅회원 관리]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<tr>
			<td align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<form name=regfrm method=post action="bMem.asp">
					<input type=hidden name="Idx" value="<%=IntIdx%>">					
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>							<table  border="0" cellspacing="1" cellpadding="0" >								<tr height="30" >
									<td>
										<select name=KeyField>
											<option value="Id">아이디</option>
										</select>
										&nbsp;&nbsp;&nbsp;
										<input type=text name=KeyWord>									</td>									<td rowspan=2>
										<input type=submit value="검 색" id=submit1 name=submit1>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;									</td>							</table>
						</td>
					</tr>					
					</form>
				</table>
			</td>
		</tr>		<tr>			<td>
<%
		SQL = "SELECT DISTINCT gCnt FROM BetGame_TB WHERE gIdx='"& IntIdx &"'"
'		SQL = SQL &" Order By Idx DESC "
		Response.Write sql &"<br>"			Set Rss = RunSQLReturnRs(SQL)
			If Not Rss.EOF or Not Rss.BOF Then
				Do Until Rss.EOF
																	
				AllbMoney	= 0
				AllrbMoney	= 0
				AllAllot	= 0
				AllhMoney	= 0
																	
				order = " ORDER BY b.Idx DESC"
				SQL = "SELECT b.Idx, b.Id, b.gName, convert(varchar(16),b.gsDate,120 ) As gsDat, b.hTname, b.hAllot, b.hCap, "
				SQL = SQL &" b.HcapAllotl, b.vTname, b.vAllot, b.gbTem, convert(varchar(16),b.WriteDay,120 ) As WriteDay, b.bMoney, b.ResuFlag, b.rMoney, g.rtel "
				'SQL = SQL &" FROM BetGame_TB b, Game_TB g WHERE g.Status=0 And g.Idx=b.gIdx And b.Id='"& Session("UId") &"' "
				SQL = SQL &" FROM BetGame_TB b, Game_TB g WHERE g.Idx=b.gIdx And b.gCnt='"& Rss(0) &"' "
				If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" AND "& KeyField &" LIKE '%"& KeyWord &"%'"
				SQL = SQL & order
'				Response.Write sql &"<br>"
				Set objRs = RunSQLReturnRs(SQL)
%>		
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<tr height="30" align="center" >
						<td>							<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
								<tr height="30" align="center" bgcolor="#e0e0e0">
									<td width="110">아이디</td>									<td width="140">베팅일시</td>									<td width="140">경기날짜</td>
									<td width="90">종목</td>
																		<td width="160">승(홈팀)</td>									<td width="80">무/핸드캡</td>
																		<td width="160">패(원정팀)</td>
									<td width="50">배당팀</td>									<td width="90">경기결과</td>									<td width="100">배팅금액</td>									<td width="60">삭제</td>
								</tr>									<form  name=frms >
									<input type=hidden name="Idx" value="<%=IntIdx%>">
									<input type=hidden name="KeyWord" value="<%=KeyWord%>">
									<input type=hidden name="KeyField" value="<%=KeyField%>">
									<input type=hidden name="Flag" value="MODIFY">
			<%
								If Not (objRs.EOF or objRs.BOF) Then
								    Do Until objRs.EOF
			%>
								
								
								<tr height="20" align=center bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>													
									<td ><%=objRs("Id")%></td>									<td ><%=objRs("WriteDay")%></td>									<td ><%=objRs("gsDat")%></td>
									<td align=left ><%=objRs("gName")%></td>
																		<td align="right"><%=objRs("hTname")%>&nbsp;<%=objRs("hAllot")%>&nbsp;</td>									<td ><% If isNone(objRs("hCap")) Then %> <%=IfElse(objRs("HcapAllotl"),"0.00")%><%Else%><%=IfElse(objRs("hCap"),"0.00")%><%End If %></td>									<td align=left>&nbsp;<%=objRs("vAllot")%>&nbsp;<%=objRs("hTname")%></td>									<td ><%If objRs("gbTem")=1 Then %>홈팀<%ElseIf objRs("gbTem")=2 Then%>무<%Else%>원정팀<%End If%></td>									<td align="left"><%=objRs("rtel")%></td>									<td align="right"><%=formatnumber(objRs("bMoney"),[])%>&nbsp;</td>									<td ><input type=button value="삭제" onclick="if(confirm('삭제하시겠습니까?')) { MovePage('<%=objRs("Idx")%>','bMem_Prc.asp','DELETE','',''); }" ></td>								</tr>								
<%
										If objRs("gbTem") = 1 Then
											If allAllot = 0 Then 
												AllAllot = objRs("hAllot")
											Else
												AllAllot = AllAllot * objRs("hAllot")
											End If
																																
										ElseIf objRs("gbTem") = 2 Then
											If allAllot = 0 Then 
												AllAllot = objRs("vAllot")
											Else
												AllAllot = AllAllot * objRs("vAllot")
											End If
																																
										ElseIf objRs("gbTem") = 3 Then
											If allAllot = 0 Then 
												AllAllot = objRs("HcapAllotl")
											Else
												AllAllot = AllAllot * objRs("HcapAllotl")
											End If
																																
										End If	
																											
										AllbMoney	= AllbMoney+reInt(objRs("bMoney"),0)
										AllrbMoney	= reInt(objRs("rMoney"),0)
										
										betmoney	= objRs("bMoney")				
										Id		 = objRs("Id")
										rMoney	 = objRs("rMoney")
										ResuFlag = objRs("ResuFlag")
										objRs.MoveNext
									Loop
										AllAllot	=  left(AllAllot,4)
										AllhMoney = Int(AllAllot*betmoney)
										gGcnt = Rss(0)
									End IF									
			%>
								<input type=hidden name=gGcnt value="<%=gGcnt%>">							</table>
						</td>
					</tr>					<tr>						<td align=center bgcolor=FFFFFF>							<table >								<tr>									<td>
						배당율 : <%=formatnumber(AllAllot,2)%> / 배팅금액 : <%=formatnumber(AllbMoney,[])%> / 예상적중금액 : <%=formatnumber(AllhMoney,[])%> / 적중금액 : <input type=text name="rMoney" value="<%=AllrbMoney%>" size=10>									</td>									<td>
										<input type=radio name=ResuFlag value=0 <%=gSelection(ResuFlag,0,"checked")%>>정산전
										<input type=radio name=ResuFlag value=1 <%=gSelection(ResuFlag,1,"checked")%>>완료									</td>									<td ><input type=submit value="적용" id=submit2 name=submit2></td>									<td>
										<input type=button value="실제정립" onclick="MM_winopen('CashCh.asp?Id=<%=Id%>&Idx=<%=IntIdx%>','CA','width=400,height=300');" id=button1 name=button1>									</td>									
																		</tr>
								</form>							</table>
						</td>					</tr>					
				</table><%
		       Rss.MoveNext
		   Loop
		End IF
%>			</td>		</tr>
	</table>
</body>
</html>
	