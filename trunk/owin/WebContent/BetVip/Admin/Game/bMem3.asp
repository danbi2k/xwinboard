
<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<!--	#include virtual=/common/asp/MemberClass.asp		-->
<%
IntIdx		= Request("Idx")
pageSize = 20
goPage		= Request("goPage")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
Flag		= Request("Flag")
Sect		= Request("Sect")

If Not isDate(f_date) Then f_date	= Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2)
If Not isDate(t_date) Then t_date	= Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2)


If Sect =0 Then tit = "정산전배팅" Else tit = "정산완료" End If

If Flag="MODIFY" Then
	SQL = "UPDATE BetGame_TB Set rMoney="& reInt(replace(Request("rMoney"),",",""),0) &", ResuFlag="& Request("ResuFlag") &" WHERE gCnt='"& Request("gGcnt") &"'"
'	SQL = "UPDATE BetGame_TB Set rMoney="& reInt(Request("rMoney"),0) &", ResuFlag="& Request("ResuFlag") &" WHERE Idx='"& Request("cIdx") &"'"
'	Response.Write SQL
'	Response.End
	RunSQL(SQL)
	Call MileageChange(Request("Id"), reInt(replace(Request("rMoney"),",",""),0), "2")

	If reInt(Request("rMoney"),0) > 0 Then
		TCash = NowMileage(Rss("Id"), "Point")
		Set Rss = RunSQLReturnRs("SELECT TOP 1 Id FROM BetGame_TB WHERE gCnt='"& Request("gGcnt") &"'")
		If Not ( Rss.EOF or Rss.BOF ) Then 
			SQLs = "INSERT INTO Cash_TB (Id,RCash, TCash,ResultCash,Comment,Type) VALUES ('"& Rss("Id") &"','"& reInt(Request("rMoney"),0) &"','"& TCash &"','"& TCash+reInt(Request("rMoney"),0) &"','배팅적중 적립',3)"
			RunSQL(SQLs)
		End If
		Set Rss = Nothing
	End If

	Call descment("","bMem.asp?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&goPage="& Request("CurPage") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&Idx="& IntIdx &"&Sect="& Request("Sect") ,"")	
End If


If Flag="GOLD" Then
	SQL = "UPDATE BetGame_TB Set GoldHit="& Request("cIdx") &" WHERE Idx='"& Request("Idx") &"'"
'	Response.Write SQL
'	Response.End
	RunSQL(SQL)
	Call descment("","bMem.asp?CurPage="& Request("CurPage") &"&CurBlock="& Request("CurBlock") &"&goPage="& Request("CurPage") &"&KeyField="& Request("KeyField")&"&KeyWord="& Request("KeyWord") &"&Idx="& IntIdx &"&Sect="& Request("Sect") ,"")	
End If


order = " Order By gCnt DESC "
SQL = "SELECT DISTINCT gCnt FROM BetGame_TB WHERE Id='neo4u' "
'SQL = "SELECT DISTINCT gCnt FROM BetGame_TB WHERE ResuFlag='1' And Visbled=0 And Sect=5 And rMoney > 0"

If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" And "& KeyField &" like '%"& KeyWord &"%'"
Response.Write sql &"<br>"
SQL = SQL & order
Set objCon = getConnection
Set Rss = getRecordSet(objCon, SQL)
If Rss.EOF or Rss.BOF Then
	rsCount = -1
Else
    Rss.PageSize = pageSize
    Rss.AbsolutePage = CurPage
    rsCount = Rss.RecordCount
    gSeq = getReverseRow(pageSize, CurPage, rsCount)    
End If

g_pageCount = getPageSize(pageSize, rsCount)
If(isNone(strSort) Or strSort="Desc") Then strSort="Asc" Else strSort="Desc": '//정렬방식 순서 변경
%>
<script language='javascript' src=/common/js/Calendar.js></script>
<script language='javascript' src=/common/js/goList.js></script>
<script language='javascript'>
	function MovePage(gId, goP, gfl, gSe, gfrm) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["ScFlag"]		= '<%=ScFlag%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["Idx"]			= gId;
		getQuery["cIdx"]		= gSe;
		getQuery["flag"]		= gfl;
		action(gfrm,goP);
	}

	function ReSortList(SortColumn,Sort) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';	
		getQuery["ScFlag"]		= '<%=ScFlag%>';
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
		getQuery["KeyWord"]		= '<%=KeyWord%>';	
		getQuery["KD1"]			= '<%=KD1%>';
		getQuery["KD2"]			= '<%=KD2%>';
		getQuery["ScFlag"]		= '<%=ScFlag%>';
		action();
	}
	
	function UpdateGoldhit() {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["ScFlag"]		= '<%=ScFlag%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["flag"]		= 'HITUPDATE';
		action('frmsgod','bMem_Prc.asp');
	}
	
	function addGoldhit(val) {
		
		var goldhits = document.frmsgod.goldhits.value;
		if (goldhits=="") {
			document.frmsgod.goldhits.value = val;
		} else {
			document.frmsgod.goldhits.value = goldhits+'@'+val;
		}
//		alert(document.frmsgod.goldhits.value);
	}


	function seArch() {
		if(confirm('삭제 하시겠습니까?')) {
			location.href = 'List_Prc.asp?Sect=<%=Sect%>&f_date='+document.all.f_date.value+'&t_date='+document.all.t_date.value+'&flag=BMEMDELETE';
		}
	}
</script>
<body style="margin:0">
<script language='javascript' src=/common/js/common.js></script>
	<table width="980" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="30" background="/Images/Admin/top1_bg.gif"></td></tr>
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" valign="middle">
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[<%=tit%> 관리]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<tr>
			<td align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<form name=regfrm method=post action="bMem.asp">

					<input type=hidden name="Sect" value="<%=Sect%>">

					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<table  border="0" cellspacing="1" cellpadding="0" >
								<tr height="30" >
									<td>
										<select name=KeyField>
											<option value="Id">아이디</option>
										</select>
										&nbsp;&nbsp;&nbsp;
										<input type=text name=KeyWord>
									</td>
									<td rowspan=2>
										<input type=submit value="검 색" id=submit1 name=submit1>
									</td>
							</table>
						</td>
					</tr>
					
					</form>
				</table>
			</td>
		</tr>
		<% If Sect=1 Then %>
		<tr>
			<td align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<table  border="0" cellspacing="1" cellpadding="0" >
								<tr height="30" >
									<td>
										배팅일시 기준 : <input type="text" name="f_date" size="10" value="<%=f_date%>" maxlength="10" class="input4" onchange="ValidateDatetime(this.form, this.name);"> 
										<a href="javascript:Calendar_D(f_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>
										~
										<input type="text" name="t_date" size="10" value="<%=t_date%>" maxlength="10" class="input4" onchange="ValidateDatetime(this.form, this.name);"> 
										<a href="javascript:Calendar_D(t_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>
										&nbsp;&nbsp;&nbsp;
										<!--
										<select name=KeyField>
											<option value="hTname" <%=gSelection(KeyField,"hTname","selected")%>>홈팀</option>
											<option value="vTname" <%=gSelection(KeyField,"vTname","selected")%>>원정팀</option>
										</select>
										&nbsp;&nbsp;&nbsp;
										<input type=text name=KeyWord value="<%=KeyWord%>">
										-->
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type=button value="삭 제" onclick="seArch();" id=button1 name=button1>
									</td>
									
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<% End If%>
		<tr>
			<td>
					<table width="100%" border="0" cellspacing="1" cellpadding="0" align=center>
						<tr height="30" align="center" >
							
							<td>
<%
				If rsCount = -1 Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
				Else
				    count = 0
				    Do Until Rss.EOF Or count >= pageSize
				AllbMoney	= 0
				AllrbMoney	= 0
				AllAllot	= 0
				AllhMoney	= 0

																	
				order = " ORDER BY Idx DESC"
				SQL = "SELECT Idx, Sect, Id, gName, convert(varchar(16),gsDate,120 ) As gsDat, hTname, hAllot, hCap, "
				SQL = SQL &" HcapAllotl, vTname, vAllot, gbTem, convert(varchar(16),WriteDay,120 ) As WriteDay, bMoney, "
				SQL = SQL &" ResuFlag, rMoney, goldhit, rtel "
				'SQL = SQL &" FROM BetGame_TB b, Game_TB g WHERE g.Status=0 And g.Idx=b.gIdx And b.Id='"& Session("UId") &"' "
				SQL = SQL &" FROM BetGame_TB WHERE gCnt='"& Rss(0) &"' "
'				If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" AND "& KeyField &" LIKE '%"& KeyWord &"%'"
				SQL = SQL & order
'				Response.Write sql &"<br>"
				Set objRs = RunSQLReturnRs(SQL)
%>		
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<tr height="30" align="center" >
						<td>
							<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
								<tr height="30" align="center" bgcolor="#e0e0e0">
									<td width="90"><nobr>아이디</td>
									<td width="135"><nobr>베팅일시</td>
									<td width="135"><nobr>경기날짜</td>
									<td width="80"><nobr>종목</td>
									
									<td width="160"><nobr>승(홈팀)</td>
									<td width="75"><nobr>무/핸드캡</td>
									
									<td width="160"><nobr>(패)원정팀</td>
									<td width="50"><nobr>배팅팀</td>
									<td width="75"><nobr>경기결과</td>
									<td width="230"><nobr>적중유무</td>
									<!--<td width="100">배팅금액</td>
									<td width="60">삭제</td>-->
								</tr>
									<form  name=frms >
									<input type=hidden name="Idx" value="<%=IntIdx%>">
									<input type=hidden name="KeyWord" value="<%=KeyWord%>">
									<input type=hidden name="KeyField" value="<%=KeyField%>">
									<input type=hidden name="Flag" value="MODIFY">
									<input type=hidden name="Sect" value="<%=Sect%>">
									<input type=hidden name="Id" value="<%=objRs("Id")%>">
			<%

								If Not (objRs.EOF or objRs.BOF) Then
								    Do Until objRs.EOF
			%>
								
								<tr height="20" align=center bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
									<td ><nobr><%=objRs("Id")%></td>
									<td ><nobr><%=objRs("WriteDay")%></td>
									<td ><nobr><%=objRs("gsDat")%></td>
									<td align=left ><nobr><%=objRs("gName")%></td>
									
									<td align="right"><nobr><%=objRs("hTname")%>&nbsp;<%=objRs("hAllot")%>&nbsp;</td>
									<td ><nobr><%If objRs("Sect")=5 Then %>무&nbsp;<%=IfElse(objRs("HcapAllotl"),"0.00")%><%Else%><%=objRs("hCap")%><%End If %></td>
									<td align=left><nobr>&nbsp;<%=objRs("vAllot")%>&nbsp;<%=objRs("vTname")%></td>
									<td ><nobr><%If objRs("gbTem")=1 Then %>홈팀<%ElseIf objRs("gbTem")=2 Then%>원정팀<%Else%>무<%End If%></td>
									<td ><nobr><%=objRs("rtel")%></td>
									<td ><nobr><input type="radio" name="goldhit_<%=objRs("Idx")%>" value=0 onclick="addGoldhit('<%=objRs("Idx")%>|0');" <%=gSelection(objRs("goldhit"),0,"checked")%>>대기중&nbsp;<input type="radio" name="goldhit_<%=objRs("Idx")%>" value=2 onclick="addGoldhit('<%=objRs("Idx")%>|2');" <%=gSelection(objRs("goldhit"),2,"checked")%>>미적중&nbsp;<input type="radio" name="goldhit_<%=objRs("Idx")%>" value=1 onclick="addGoldhit('<%=objRs("Idx")%>|1');" <%=gSelection(objRs("goldhit"),1,"checked")%>>적중</td>
									
									<!--<td align="right"><%=formatnumber(objRs("bMoney"),[])%>&nbsp;</td>
									<td ><input type=button value="삭제" onclick="if(confirm('삭제하시겠습니까?')) { MovePage('<%=objRs("Idx")%>','bMem_Prc.asp','DELETE','',''); }" ></td>-->
								</tr>
<%


										AllbMoney	= AllbMoney+reInt(objRs("bMoney"),0)
										AllrbMoney	= reInt(objRs("rMoney"),0)	'적중금액

										betmoney	= objRs("bMoney")				
										Id			= objRs("Id")
										rMoney		= objRs("rMoney")
										ResuFlag	= objRs("ResuFlag")
									
										ThisGcnt	= Rss(0)
										objRs.MoveNext

									Loop
										AllAllot	= getToAlot(ThisGcnt)
										AllhMoney = Int(AllAllot*betmoney)		'예상적중금액
										gGcnt = Rss(0)
									End IF									
%>
								<input type=hidden name=gGcnt value="<%=gGcnt%>">
							</table>
						</td>
					</tr>
					<tr>
						<td align=center bgcolor=FFFFFF>
							<table >
								<tr>
						<%If Sect=0 Then %>
							
									<td>
						배당율 : <%=formatnumber(AllAllot,2)%> / 배팅금액 : <%=formatnumber(betmoney,[])%> / 
						예상적중금액 : <%=formatnumber(AllhMoney,[])%> / 
						적중금액 : <input type=text name="rMoney" value="<%=formatnumber(AllrbMoney,[])%>" onkeyup="if(event.keyCode>40 || event.keyCode<33)this.value=MoneyFormat(this.value)" size=10>
									</td>
									<td>
										<input type=radio name=ResuFlag value=0 <%=gSelection(ResuFlag,0,"checked")%>>정산전
										<input type=radio name=ResuFlag value=1 <%=gSelection(ResuFlag,1,"checked")%>>완료
									</td>
									<td ><input type=submit value="적용" id=submit2 name=submit2></td>
									<!--
									<td>
										<input type=button value="실제정립" onclick="MM_winopen('CashCh.asp?Id=<%=Id%>&Idx=<%=IntIdx%>','CA','width=400,height=300');" id=button1 name=button1>
									</td>
									-->
									<td>
										<input type=button value="삭제" onclick="if(confirm('삭제하시겠습니까?')) { MovePage('<%=ThisGcnt%>','bMem_Prc.asp','DELETE','',''); }"  id=button2 name=button2>
									</td>
									
						<%Else%>			
						
									<td>배당율 : <%=formatnumber(AllAllot,2)%> / 배팅금액 : <%=formatnumber(betmoney,[])%> / 예상적중금액 : <%=formatnumber(AllhMoney,[])%> / 적중금액 : <%=formatnumber(reInt(AllrbMoney,0),[])%></td>
									<td>
										<input type=radio name=ResuFlag value=0 <%=gSelection(ResuFlag,0,"checked")%>>정산전
										<input type=radio name=ResuFlag value=1 <%=gSelection(ResuFlag,1,"checked")%>>완료
									</td>
									<td ><input type=submit value="적용" id=submit2 name=submit2></td>
									<td>
										<input type=button value="삭제" onclick="if(confirm('삭제하시겠습니까?')) { MovePage('<%=ThisGcnt%>','bMem_Prc.asp','DELETE','',''); }"  id=button2 name=button2>
									</td>	
						
						<%End If%>
										
								</tr>
								</form>
							</table>
						</td>
					</tr>
					<tr><td bgcolor=FFFFFF height=20></td></tr>
				</table>
			

<%

				gSeq = gSeq - 1

				count = count + 1

		       Rss.MoveNext

		   Loop

		End IF

%>
				
			</td>
		</tr>
	</table>
			</td>
		</tr>
		<form name=frmsgod action="bMem_Prc.asp">
		<input type=hidden name=goldhits>
		<input type=hidden name=CurPage value="<%=CurPage%>">
		<input type=hidden name=CurBlock value="<%=CurBlock%>">
		<input type=hidden name=SortColumn value="<%=SortColumn%>">
		<input type=hidden name=strSort value="<%=strSort%>">
		<input type=hidden name=Sect value="<%=Sect%>">
		<input type=hidden name=ScFlag value="<%=ScFlag%>">
		<input type=hidden name=KeyField value="<%=KeyField%>">
		<input type=hidden name=KeyWord value="<%=KeyWord%>">
		<input type=hidden name=flag value="HITUPDATE">
		<tr><td align=center><input type=submit value="적중유무 일괄변경" onclick="UpdateGoldhit();"></td></tr>
		</form>
		<tr>
			<td height=50>
				<TABLE cellSpacing=0 cellPadding=0 width=100% border=0>
					<TR>
						<TD align=middle >
							<%=getPrintPaging(pageSize, CurPage, rsCount)%>
						</TD>				
					</TR>
				</TABLE>			
			</td>
		</tr>
	</table>
</body>
</html>
		