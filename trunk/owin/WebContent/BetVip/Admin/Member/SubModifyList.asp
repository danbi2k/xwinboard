
<!--	#include virtual=/common/asp/connect.asp		-->
<!--	#include virtual=/common/asp/UtilityClass.asp		-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<!--	#include virtual=/common/asp/MemberClass.asp		-->
<!--	#include virtual=/common/asp/SysOops.asp		-->
<%

pageSize = 20

goPage		= Request("goPage")
CurPage		= reInt(Request("CurPage"),1)
CurBlock	= Request("CurBlock")
strId		= Request("Id")
SortColumn	= Request("SortColumn")
strSort		= Request("Sort")
Flag		= Request("Flag")
f_date		= Request("f_date")
t_date		= Request("t_date")
Sect		= Request("Sect")

If Not isNone(SortColumn) And Not isNone(strSort) Then
	order = " ORDER BY " & SortColumn & " " & strSort & ""
Else
	order = " ORDER BY c.Idx DESC "
End If

SQL = "SELECT c.Id, c.TCash, c.RCash, c.Type, c.WriteDay, c.ResultCash, c.Comment, c.gCnt, m.Name FROM Cash_TB c, Member_TB m WHERE c.Id=m.Id And c.Id='"& strId &"'"
If LCase(Session("SYS_ID"))="master" Then 
	SQL = SQL &" And ( c.ChId<>'master' or c.ChId IS NULL) "
Else
	SQL = SQL &" AND c.Visbled=0 "
End if

If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" AND "& KeyField &" ='"& KeyWord &"'"
If Not isNone(Sect) Then SQL = SQL &" AND c.Type ='"& Sect &"'"
If Not isNone(f_date) And Not isNone(t_date) Then SQL = SQL &" And convert(varchar(10),c.WriteDay,120 ) BETWEEN convert(varchar(10),'"& f_date &"',120 ) And convert(varchar(10),'"& t_date &"',120 ) "
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
		getQuery["Id"]			= '<%=strId%>';
		getQuery["f_date"]		= '<%=f_date%>';
		getQuery["t_date"]		= '<%=t_date%>';		
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
		getQuery["Id"]			= '<%=strId%>';
		getQuery["Idx"]			= gId;
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
	location.href = window.location.pathname+'?f_date='+document.all.f_date.value+'&t_date='+document.all.t_date.value+'&Id=<%=strId%>&Sect='+document.all.Sect.value;
}


</script>

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="54" background="/Images/Admin/top2_bg.gif" align="left" >
				<table border="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td><img src='/Images/Admin/bar_index.gif'>&nbsp;&nbsp;</td>
						<td><font color="#ffffff" size="4"><b>[<%=strId%>회원 캐쉬내역 리스트]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<tr>
			<td >
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:10pt">
						<td>
							<select name=Sect>
								<option value="" >전체보기</option>
								<option value="0" <%=gSelection(Sect,0,"selected")%>>충전요청</option>
								<option value="1" <%=gSelection(Sect,1,"selected")%>>환전요청</option>
								<option value="8" <%=gSelection(Sect,8,"selected")%>>관리자교정</option>
							</select>
							&nbsp;
							<input type="text" name="f_date" size="10" value="<%=f_date%>" maxlength="10" class="input10" onchange="ValidateDatetime(this.form, this.name);"> 
							<a href="javascript:Calendar_D(f_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>
							~
							<input type="text" name="t_date" size="10" value="<%=t_date%>" maxlength="10" class="input10" onchange="ValidateDatetime(this.form, this.name);"> 
							<a href="javascript:Calendar_D(t_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>

							
								&nbsp;&nbsp;&nbsp;
								
								<input type=button value="검 색" class="btn2"  onclick="seArch()">
								
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type=button value="전체목록" class="btn4"  onclick="location.href=window.location.pathname+'?Id=<%=StrId%>';" >
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
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" >
					<tr height="30" align="center" bgcolor="#e0e0e0">
					<form name=frms>
						<td width="50">번호</td>
						<td width="130">아이디</td>
						<td width="130">성명</td>
						<td width="130">요청(사용)금액</td>
						<td width="130">전금액</td>
						<td width="130">현제금액</td>
						<td width="150">구 분</td>
						<!--<td width="150">적립게임</td>-->
						<td width="130">등록일</td>
					</tr>
<%
					If objRs.EOF or objRs.BOF Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>등록된 자료가 없습니다.</td></tr>"
					Else
					    Dim count : count = 0
					    Do Until objRs.EOF Or count >= pageSize
%>
					<tr height="20" align="center" bgcolor="#FFFFFF" onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""'>
						<td><nobr><%=gSeq%></td>
						<td><nobr><%=objRs("Id")%></td>
						<td><nobr><%=objRs("Name")%></td>
						<td align=right><nobr><%=formatnumber(objRs("RCash"),[])%>&nbsp;</td>
						<td align=right><nobr><%=formatnumber(objRs("TCash"),[])%>&nbsp;</td>
						<td align=right><nobr><%=formatnumber(objRs("ResultCash"),[])%>&nbsp;</td>
						<td><nobr><%If isNone(objRs("Comment")) Then %><%If objRs("Type")=0 Then %><font color=08AA00>충전요청<%ElseIf objRs("Type")=1 Then%><font color=C3B801>환전요청<%End If%><%Else%><%=objRs("Comment")%><%End If%></td>
						<!--<td align="left"><nobr><% If Not isNone(objRs("gCnt")) And (objRs("Type")=2 or objRs("Type")=3 ) Then %><input type=button value="배팅내역" class=btn1 onclick="MM_winopen('/admin/Game/IframebMem.asp?Id=<%=objRs("Id")%>&gCnt=<%=objRs("gCnt")%>','IM','width=980,height=650,scrollbars=1');" id=button8 name=button8><%End If%></td>-->
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
	