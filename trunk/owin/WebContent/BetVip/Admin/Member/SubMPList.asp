<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<!--	#include virtual=/common/asp/SysOops.asp		-->
<%

pageSize = 20
IntIdx		= Request("Idx")
goPage		= Request("goPage")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
KeyField	= Request("KeyField")
KeyWord		= Request("KeyWord")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
Flag		= Request("Flag")
Sect		= Request("Sect")
senum		= Request("senum")
f_date		= Request("f_date")
t_date		= Request("t_date")
strId		= Request("Id")

If Flag="DELETE" Then
	RunSQL("DELETE FROM Point_TB WHERE Idx='"& IntIdx &"'")
	Call descment("","SumMPList.asp?CurPage="& CurPage &"&CurBlock="& CurBlock &"&Sect="& Sect &"&KeyField="& KeyField &"&KeyWord="& KeyWord,"")
End If


If Not isNone(SortColumn) And Not isNone(strSort) Then
	order = " ORDER BY " & SortColumn & " " & strSort & ""
Else
	order = " ORDER BY Idx DESC "
End If

SQL = "SELECT * FROM Point_TB WHERE Id='"& strId &"'"
If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" AND "& KeyField &" ='"& KeyWord &"'"
If Not isNone(Sect) Then SQL = SQL &" AND Type ='"& Sect &"'"
If Not isNone(f_date) And Not isNone(t_date) Then SQL = SQL &" And convert(varchar(10),WriteDay,120 ) BETWEEN convert(varchar(10),'"& f_date &"',120 ) And convert(varchar(10),'"& t_date &"',120 ) "
SQL = SQL & order
'Response.Write sql
Set objCon = getConnection
Set objRs = getRecordSet(objCon, SQL)

If Not objRs.EOF or Not objRs.BOF Then
    objRs.PageSize = pageSize
    objRs.AbsolutePage = CurPage
    rsCount = objRs.RecordCount
    gSeq = getReverseRow(pageSize, CurPage, rsCount)
Else
    rsCount = 0
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
<script language='javascript'>
	function MovePage(gId, goP, gfl, gSe, gfrm) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["f_date"]		= '<%=f_date%>';
		getQuery["t_date"]		= '<%=t_date%>';		
		getQuery["senum"]		= gSe;
		getQuery["Idx"]			= gId;
		getQuery["flag"]		= gfl;
		action(gfrm,goP);
	}

	function ReSortList(SortColumn,Sort) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["f_date"]		= '<%=f_date%>';
		getQuery["t_date"]		= '<%=t_date%>';			
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
		getQuery["Id"]			= '<%=strId%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["f_date"]		= '<%=f_date%>';
		getQuery["t_date"]		= '<%=t_date%>';	
		action();
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
	location.href = window.location.pathname+'?f_date='+document.all.f_date.value+'&t_date='+document.all.t_date.value+'&Id=<%=strId%>&Sect='+document.all.Sect.value;
}
		

function frame_resize3() {
	parent.document.all.mplist.style.height=document.body.scrollHeight;
	setTimeout("frame_resize3()",100);
}			
</script>
<script language='javascript' src=/common/js/common.js></script>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr><td height="30" background="/Images/Admin/top1_bg.gif"></td></tr>
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" valign="middle">
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[<%=strId%>회원 포인트적립 내역 ]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<tr>
			<td align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<select name=Sect>
								<option value="" >전체보기</option>
								<option value="4" <%=gSelection(Sect,4,"selected")%>>미적중 2%적립</option>
								<option value="5" <%=gSelection(Sect,5,"selected")%>>전환내역</option>
							</select>
							&nbsp;&nbsp;&nbsp;
							<input type="text" name="f_date" size="10" value="<%=f_date%>" maxlength="10" class="input10" onchange="ValidateDatetime(this.form, this.name);"> 
							<a href="javascript:Calendar_D(f_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>
							~
							<input type="text" name="t_date" size="10" value="<%=t_date%>" maxlength="10" class="input10" onchange="ValidateDatetime(this.form, this.name);"> 
							<a href="javascript:Calendar_D(t_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>

							&nbsp;&nbsp;&nbsp;
							<input type=button value="검 색" class="btn2"  onclick="seArch()" id=button2 name=button2>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type=button value="전체목록" class="btn4"  onclick="location.href=window.location.pathname+'?Id=<%=StrId%>';"  id=button8 name=button8>
						</td>
					</tr>
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:10pt">
						<td>
							<input type=button value="오늘" onfocus="this.blur();" onclick="BeforeDay('',0);" class=btn1  id=button1 name=button1>
							<input type=button value="어제" onfocus="this.blur();" onclick="BeforeDay('',1);" class=btn1  id=button1 name=button1>
							<input type=button value="3일간" onfocus="this.blur();" onclick="BeforeDay('',3);" class=btn1  id=button2 name=button2>
							<input type=button value="7일간" onfocus="this.blur();" onclick="BeforeDay('',7);" class=btn1  id=button3 name=button3>
							<input type=button value="10일간" onfocus="this.blur();" onclick="BeforeDay('',10);" class=btn1  id=button4 name=button4>
							<input type=button value="20일간" onfocus="this.blur();" onclick="BeforeDay('',20);" class=btn1  id=button5 name=button5>
							<input type=button value="30일간" onfocus="this.blur();" onclick="BeforeDay('',31);" class=btn1  id=button6 name=button6>
							<input type=button value="60일간" onfocus="this.blur();" onclick="BeforeDay('',61);" class=btn1  id=button7 name=button7>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td><br>
				<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<tr height="30" align="center" bgcolor="#e0e0e0">
						<td width="50">번호</td>
						<td width="130">아이디</td>
						<td width="130">성명</td>
						<td width="130">적립(전환)금액</td>
						<td width="130">전금액</td>
						<td width="130">현제금액</td>
						<td width="150">구 분</td>
						<td width="130">등록일</td>
					
					</tr>
<%
					If objRs.EOF or objRs.BOF Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
					Else
					    Dim count : count = 0
					    Do Until objRs.EOF Or count >= pageSize
						Set Rsm = RunSQLReturnRs("SELECT Name FROM Member_TB WHERE Id='"& objRs("Id") &"'")
							If Not (Rsm.EOF or Rsm.BOF) Then
								Name	= Rsm("Name")
							End If
						Set Rsm = Nothing
%>
					<tr height="20" align="center" bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
						<td><nobr><%=gSeq%></td>
						<td><nobr><%=objRs("Id")%></td>
						<td><nobr><%=Name%></td>
						<td align=right><nobr><%=formatnumber(objRs("Point"),[])%>&nbsp;</td>
						<td align=right><nobr><%=formatnumber(objRs("TPoint"),[])%>&nbsp;</td>
						<td align=right><nobr><%=formatnumber(objRs("ResultPoint"),[])%>&nbsp;</td>
						<td><nobr><%If isNone(objRs("Comment")) Then %><%If objRs("Type")=4 Then %><font color=08AA00>미적중 적립<%Else%><font color=C3B801>전환요청<%End If%><%Else%><%=objRs("Comment")%><%End If%></td>
						<td align="left"><nobr><%=objRs("WriteDay")%></td>
					</tr>
<%
					       gSeq = gSeq - 1
					       count = count + 1
					       objRs.MoveNext
					   Loop
					End IF
%>
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
				</TABLE>			
			</td>
		</tr>
	</table>
</body>
</html>
<script language="javascript" type="text/javascript">
frame_resize3();
</script>