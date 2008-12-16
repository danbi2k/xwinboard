<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<%
If Session("SYS_Ssection")<>0 Then Call descment("","back","")
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
bTitle = "환"
If Sect = 0 Then bTitle = "충"


If Flag="DELETE" Then
	RunSQL("DELETE FROM Point_TB WHERE Idx='"& IntIdx &"'")
	Call descment("","ChCashList.asp?CurPage="& CurPage &"&CurBlock="& CurBlock &"&Sect="& Sect &"&KeyField="& KeyField &"&KeyWord="& KeyWord,"")
End If


If Not isNone(SortColumn) And Not isNone(strSort) Then
	order = " ORDER BY " & SortColumn & " " & strSort & ""
Else
	order = " ORDER BY Idx DESC "
End If

SQL = "SELECT * FROM Point_TB WHERE Type=5 "
If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" AND "& KeyField &" LIKE '%"& KeyWord &"%'"
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
		getQuery["Sect"]		= '<%=Sect%>';		
		action();
	}

	
	function GoSearch() {
		lfm.action=window.location.pathname
		lfm.submit()
	}
		

function showToolTip(current,e,strText)
{
   // 인터넷 익스플로러이면 원래 title 속성을 사용한다.
   if (document.all)
   {
      // 툴팁 문자열 안에 <br> 태그가 있는지 확인
      strTitle=strText.split('<br>')
      // 툴팁 문자열 안에 <br> 태그가 있으면
      if (strTitle.length > 1)
      {
        strTitles=""
        for (i=0; i<strTitle.length; i++)
           strTitles += strTitle[i] + "\r\n"
        current.title = strTitles
      }
      else current.title = strText
   }
 
   // 넷스케이프이면 레이어 태그를 사용한다.
   else if (document.layers)
   {
       // 문서 안에 tooltip이란 ID의 <div> 객체가 하나 삽입될 것이다.
       // 이 <div> 객체 레이어 안에 레이어 태그를 삽입한다.
       document.tooltip.document.write( 
           '<layer bgColor="#FFFFE7" style="border:1px ' +
           'solid black; font-size:12px;color:#000000;">' + strText + '</layer>')
       document.tooltip.document.close()
       document.tooltip.left=e.pageX+5
       document.tooltip.top=e.pageY+5
       document.tooltip.visibility="show"
   }
}
 
function hideToolTip()
{
    if (document.layers)
        document.tooltip.visibility="hidden"
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
						<td><font color="#ffffff" size="4"><b>[포인트 전환 내역 ]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<tr>
			<td align="center">
				<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<form name=sfrms method=post action="ChCashList.asp">
					<input type=HIDDEN name=Sect value="<%=Sect%>">
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<select name=KeyField>
								<option value="Id">아이디</option>
							</select>
								&nbsp;&nbsp;&nbsp;
								<input type=text name=KeyWord>
								<input type=submit value="검 색" id=submit1 name=submit1>
						</td>
					</tr>
					</form>
				</table>
			</td>
		</tr>
		<tr>
			<td><br>
				<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<form  name=frms>
					<tr height="30" align="center" bgcolor="#e0e0e0">
						<td width="20"><input type=checkbox onclick="fSelectAllCheckBox(frms)" id=checkbox1 name=checkbox1></td>
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
						<td><input type=checkbox name=selcheck value="<%=objRs("Idx")%>" ></td>
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
					</form>
				</table>
			</td>
		</tr>
		<tr>
			<td height=50>
				<TABLE cellSpacing=0 cellPadding=0 width=100% border=0>
					
					<tr>
						<TD align=middle width=750>
<%=getPrintPaging(pageSize, CurPage, rsCount)%>
						</TD>				
					</TR>
					<TR>
						<td>
							<input type=button value="선택삭제" onclick="if(confirm('삭제 하시겠습니까?')){MovePage('','AllDel.asp','POINTCHECKDEL','',frms);}" id=button1 name=button1>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							
						</td>
					</tr>
				</TABLE>			
			</td>
		</tr>
	</table>
</body>
</html>
	