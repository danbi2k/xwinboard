
<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<!--	#include virtual=/common/asp/MemberClass.asp		-->
<%
pageSize = 20
strId		= Request("Id")
goPage		= Request("goPage")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
Flag		= Request("Flag")
Sect		= Request("Sect")
Hits		= Request("Hits")
'Response.write Hits&"DD"
'Response.End	
rMoney		= replace(Request("rMoney"),",","")
If Not isDate(f_date) Then f_date	= Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2)
If Not isDate(t_date) Then t_date	= Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2)


order = " Order By gCnt DESC "
SQL = "SELECT DISTINCT gCnt FROM BetGame_TB WHERE MisPF=1 And Visbled=0 And Id='"& strId &"'"
If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" And "& KeyField &" like '%"& KeyWord &"%'"
'Response.Write sql &"<br>"
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
		getQuery["Id"]			= '<%=strId%>';
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
		getQuery["Id"]			= '<%=strId%>';
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
		getQuery["Id"]			= '<%=strId%>';
		action();
	}
	
	
	function seArch() {
		mdf = "";
		if(confirm('삭제 하시겠습니까?')) {
			if (document.all.md.checked) {
				mdf = ",UHiden = 1"
			} 
//			alert(mdf);return;
			location.href = 'List_Prc.asp?KeyWord=<%=KeyWord%>&KeyField=<%=KeyField%>&Sect=<%=Sect%>&f_date='+document.all.f_date.value+'&t_date='+document.all.t_date.value+'&flag=BMEMDELETE'+'&Mdflag='+mdf;
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
						<td><font color="#ffffff" size="4"><b>[미적중 포인트 적립게임 리스트]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
<!--
		<tr>
			<td align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<form name=regfrm method=post action="MisPGameList.asp">

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
										<input type=text name=KeyWord value="<%=KeyWord%>">
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
		-->
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

										<!--
										<select name=KeyField>
											<option value="hTname" <%=gSelection(KeyField,"hTname","selected")%>>홈팀</option>
											<option value="vTname" <%=gSelection(KeyField,"vTname","selected")%>>원정팀</option>
										</select>
										&nbsp;&nbsp;&nbsp;
										<input type=text name=KeyWord value="<%=KeyWord%>">
										-->
										&nbsp;
										<input type=checkbox name="md" value="1" >회원자료모두 삭제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
									<td width="90"><nobr>고유키</td>
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

			<%

								If Not (objRs.EOF or objRs.BOF) Then
								    Do Until objRs.EOF
			%>

								
								<tr height="20" align=center bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
									<td ><nobr><%=Rss(0)%></td>
									<td ><nobr><%=objRs("Id")%></td>
									<td ><nobr><%=objRs("WriteDay")%></td>
									<td ><nobr><%=objRs("gsDat")%></td>
									<td align=left ><nobr><%=objRs("gName")%></td>
									
									<td align="right"><nobr><%=objRs("hTname")%>&nbsp;<%=objRs("hAllot")%>&nbsp;</td>
									<td ><nobr><%If objRs("Sect")=5 Then %>무&nbsp;<%=IfElse(objRs("HcapAllotl"),"0.00")%><%Else%><%=objRs("hCap")%><%End If %></td>
									<td align=left><nobr>&nbsp;<%=objRs("vAllot")%>&nbsp;<%=objRs("vTname")%></td>
									<td ><nobr><%If objRs("gbTem")=1 Then %>홈팀<%ElseIf objRs("gbTem")=2 Then%>원정팀<%Else%>무<%End If%></td>
									<td ><nobr><%=objRs("rtel")%></td>
									<td ><nobr><input type="radio" name="goldhit_<%=objRs("Idx")%>" value=0 <%=gSelection(objRs("goldhit"),0,"checked")%>>대기중&nbsp;<input type="radio" name="goldhit_<%=objRs("Idx")%>" value=2 <%=gSelection(objRs("goldhit"),2,"checked")%>>미적중&nbsp;<input type="radio" name="goldhit_<%=objRs("Idx")%>" value=1 <%=gSelection(objRs("goldhit"),1,"checked")%>>적중</td>
									
									<!--<td align="right"><%=formatnumber(objRs("bMoney"),[])%>&nbsp;</td>
									<td ><input type=button value="삭제" onclick="if(confirm('삭제하시겠습니까?')) { MovePage('<%=objRs("Idx")%>','bMem_Prc.asp','DELETE','',''); }" ></td>-->

								</tr>
								
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
									
										ThisGcnt = Rss(0)
										objRs.MoveNext
									Loop
									
										AllAllot	=  int(AllAllot*100)/100
										AllhMoney = Int(AllAllot*betmoney)
										MisPMoney = (betmoney/100)*2
										allMisPMoney = allMisPMoney+MisPMoney
									End IF									
%>
								
							</table>
						</td>
					</tr>
					<tr>
						<td align=center bgcolor=FFFFFF>
							<table >
								<tr>	
									<input type=hidden name=rMoney value="<%=reInt(AllrbMoney,0)%>" >
									<td>배당율 : <%=formatnumber(AllAllot,2)%> / 
									배팅금액 : <%=formatnumber(betmoney,[])%> / 
									예상적중금액 : <%=formatnumber(AllhMoney,[])%> / 
									적중금액 : <%=formatnumber(reInt(AllrbMoney,0),[])%>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<font color=red>미적중 적립금액 : <%=formatnumber(MisPMoney,[])%>
									</td>
								</tr>
								
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
		<tr><td align=center height=50>전체 미적중 적립금액 : <b><font color=red><%=formatnumber(allMisPMoney,[])%></td></tr>
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
		