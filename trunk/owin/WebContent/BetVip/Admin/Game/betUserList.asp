<!--	#include virtual=/common/asp/SysOops.asp		-->
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/UtilityClass.asp		-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<!--	#include virtual=/common/asp/MemberClass.asp		-->
<%

pageSize = 20


goPage		= Request("goPage")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
Flag		= Request("Flag")
f_date		= Request("f_date")
t_date		= Request("t_date")
IntIdx		= Request("Idx")
Sect		= Request("Sect")

If Not isNone(SortColumn) And Not isNone(strSort) Then
	order = " ORDER BY " & SortColumn & " " & strSort & ""
Else
	order = " ORDER BY c.Idx DESC "
End If

order = " Order By gCnt DESC "
SQL = "SELECT DISTINCT gCnt FROM BetGame_TB WHERE gIdx='"& IntIdx &"' "
If Not isNone(Sect) Then
	If Sect=0 Then  
	SQL = SQL &" And rMoney = 0"
	Else
	SQL = SQL &" And rMoney > 0"
	End If
End If
If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" And "& KeyField &" like '%"& KeyWord &"%'"
SQL = SQL & order
'Response.Write sql &"<br>"
Set objCon = getConnection
Set objRs = getRecordSet(objCon, SQL)
If objRs.EOF or objRs.BOF Then
	rsCount = -1
Else
    objRs.PageSize = pageSize
    objRs.AbsolutePage = CurPage
    rsCount = objRs.RecordCount
    gSeq = getReverseRow(pageSize, CurPage, rsCount)    
End If

g_pageCount = getPageSize(pageSize, rsCount)
If(isNone(strSort) Or strSort="Desc") Then strSort="Asc" Else strSort="Desc": '//정렬방식 순서 변경
%>


<html>
<head>
<title> 관리자</title>
<LINK href="/common/CSS/Admin.css" type=text/css rel=stylesheet>
<LINK href="/common/CSS/Adminstyle.css" type=text/css rel=stylesheet>
</head>
<BODY style="margin:0">
<script language=javascript src="/js/common.js"></script>
<script language='javascript' src=/common/js/Calendar.js></script>
<script language='javascript' src=/common/js/goList.js></script>
<script language='javascript' src=/common/js/common.js></script>
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
		getQuery["flag"]		= gfl;
		action(gfrm,goP);
	}

	function ReSortList(SortColumn,Sort) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';	
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
		getQuery["Idx"]			= '<%=IntIdx%>';	
		action();
	}

	
	
function frame_resize2() {
	parent.document.all.member.style.height=document.body.scrollHeight;
	setTimeout("frame_resize2()",100);
}	

function seArch() {
//	alert(document.all.KeyField.value)
/*
	if(document.all.KeyField.value=="Type|0") {
		KeyField = "c.Type";
		KeyWord	 = "0";
		
	} else if(document.all.KeyField.value=="Type|1") {
		KeyField = "c.Type";
		KeyWord	 = "1";
	} else {
		KeyField = document.all.KeyField.value;
		KeyWord	 = document.all.KeyWord.value;
	}
	*/
	
//	location.href = window.location.pathname+'?f_date='+document.all.f_date.value+'&t_date='+document.all.t_date.value+'&KeyField='+KeyField+'&KeyWord='+KeyWord;
	location.href = window.location.pathname+'?f_date='+document.all.f_date.value+'&t_date='+document.all.t_date.value+'&KeyField='+document.all.KeyField.value+'&KeyWord='+document.all.KeyWord.value+'&Sect='+document.all.Sect.value;
}
</script>

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" >
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[배팅회원 리스트]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<tr>
			<td >
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<form name=sfrms method=post action="betUserList.asp">
					<input type=hidden name=Idx value="<%=IntIdx%>">
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
						<!--
							<select name=Sect>
								<option value="" >전체보기</option>
								<option value="0" <%=gSelection(Sect,0,"selected")%>>충전요청</option>
								<option value="1" <%=gSelection(Sect,1,"selected")%>>환전요청</option>
							</select>
							&nbsp;&nbsp;&nbsp;
							<input type="text" name="f_date" size="10" value="<%=IfElse(f_date,Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2))%>" maxlength="10" class="input10" onchange="ValidateDatetime(this.form, this.name);"> 
<a href="javascript:Calendar_D(f_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>
~
<input type="text" name="t_date" size="10" value="<%=IfElse(t_date,Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2))%>" maxlength="10" class="input10" onchange="ValidateDatetime(this.form, this.name);"> 
<a href="javascript:Calendar_D(t_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>
-->
							<select name=Sect>
								<option value="" >전체보기</option>
								<option value="1" <%=gSelection(Sect,1,"selected")%>>적중회원 보기</option>
								<option value="0" <%=gSelection(Sect,0,"selected")%>>미적중회원 보기</option>
							</select>
							<select name=KeyField>
								<option value="Id" >아이디</option>
							</select>
								&nbsp;&nbsp;&nbsp;
								<input type=text value="<%=KeyWord%>" name=KeyWord>
								<!--<input type=button value="검 색" class="btn2"  onclick="seArch()">-->
								<input type=submit value="검 색" class="btn2"  >
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type=button value="적중회원 SMS보내기" class="btn4"  onclick="MM_winopen('GoldHit_SmsWrite.asp','GHS','width=790,height=400');" >
						</td>
					</tr>
					</form>
				</table>
			</td>
		</tr>
		<tr>
			<td><br>
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" >
					<tr height="30" align="center" bgcolor="#e0e0e0">
					<form name=frms>
						<td width="100"><nobr>번호</td>
						<td width="150"><nobr>아이디</td>
						<td width="100"><nobr>이름</td>
						<td width="100"><nobr>SMS수신여부</td>
						<td width="110"><nobr>금액</td>
						<td width="100"><nobr>예상배당률</td>
						<td width="100"><nobr>예상적중금액</td>
						<td width="100"><nobr>실제적중금액</td>
						<td width="70"><nobr>상태</td>
						<td width="170"><nobr>등록일</td>
					</tr>
<%
								If rsCount = -1 Then
										Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
								Else
								    count = 0
								    Do Until objRs.EOF Or count >= pageSize																
										SQL = "SELECT TOP 1 bmoney, rMoney, WriteDay, hMoney, ResuFlag FROM BetGame_TB  WHERE gCnt='"& objRs("gCnt") &"' Order By WriteDay ASC"
'										Response.Write sql &"<br>"
										Set Rss = RunSQLReturnRs(SQL)
										If Not Rss.EOF Then bMoney = Rss("bmoney") : rMoney = Rss("rMoney") : WriteDay = Rss("WriteDay") : hMoney = Rss("hMoney") : ResuFlag = Rss("ResuFlag") : Set Rss = Nothing
					
										SQL = "SELECT TOP 1 b.Id, m.Name, m.Cell, m.gSms FROM BetGame_TB b, Member_TB m WHERE b.gCnt='"& objRs("gCnt") &"' And m.Id=b.Id "
'										Response.Write sql &"<br>"
										Set Rss = RunSQLReturnRs(SQL)
										If Not Rss.EOF Then Id = Rss("Id") : Name = Rss("Name") : Cell = Rss("Cell") : gSms = Rss("gSms") : Set Rss = Nothing					
										
										SQL = "SELECT GoldHit FROM BetGame_TB WHERE gIdx='"& IntIdx &"' And Id='"& Id &"'"
'										Response.Write sql &"<br>"
										Set Rss = RunSQLReturnRs(SQL)
										If Not Rss.EOF Then GoldHit = Rss("GoldHit") : Set Rss = Nothing
										GoldHit = reInt(GoldHit,0)

										hMoney = reInt(hMoney,0)
										rMoney = reInt(rMoney,0)
%>	
								<tr height="25" align=center bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
									<td ><nobr><%=gSeq%></td>
									<td ><nobr><%=Id%></td>
									<td ><nobr><%=Name%></td>
									<td ><nobr><% If gSms=0 Then %><font color=red>수신거부<%Else%>허용<%End If %></td>
									<td align="right"><nobr><%=formatnumber(bMoney,[])%>&nbsp;</td>
									<td align="right"><nobr><%=getToAlot(objRs("gCnt"))%>&nbsp;</td>
									<td align="right"><nobr><%=formatnumber(hMoney,[])%>&nbsp;</td>
									
									<td align="right"><nobr><%=formatnumber(rMoney,[])%>&nbsp;</td>
									<td ><nobr><% If ResuFlag=0 Then %>대기<%Else%>완료<%End If%></td>
									<td ><nobr><%=WriteDay%></td>
								</tr>
<%

				gSeq = gSeq - 1
				count = count + 1
		       objRs.MoveNext
		   Loop
		End IF

%>	
						<input type=hidden name=cells value="<%=replace(GoldHitSmsNums(IntIdx),"-","")%>">
					</form>
					
				</table>
			</td>
		</tr>
		<tr>
			<td height=50>
				<TABLE cellSpacing=0 cellPadding=0 width=100% border=0>
					<TR>
						<TD align=middle width=750>
							<%=getPrintPaging(pageSize, CurPage, rsCount)%>
						</TD>				
					</TR>
					</form>
				</TABLE>			
			</td>
		</tr>
	</table>
</body>
</html>
<script language="javascript" type="text/javascript">
frame_resize2();
</script>
	