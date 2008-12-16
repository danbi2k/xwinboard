<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<%
' 쿼리를 만드는데 필요한 변수값 받기
Dim Column, OrderBy, EmptyStr, mode, oColumn, cYear, cmon, i
Column  = Request("Column")  ' 카운팅을 할 컬럼 
OColumn = Request("OColumn") ' 정렬 필드방법
OrderBy = Request("OrderBy") ' 정렬 방법
EmptyStr= Request("EmptyStr")' 빈 값에 들어갈 명
mode    = Request("mode")    ' 기타
cYear   = Request("cyear")
cmon    = Request("cmon")

If isNone(Column) Then Column = "cmon"
If isNone(oColumn) Then oColumn = Column
If isNone(orderBy) Then orderBy = "ASC"
Dim Query, cValue(), cWeek(), objRsNum, cutCount(), ss, CountTotal  
	
' 쿼리 만들기
Query = "Select "&Column&", count("&Column&") as cutCount From VisitCnt_TB Where "&Column&" is not null "
If Not isNone(cyear) Then	Query = Query &" and DatePart(yy,hit_date)  = "& cyear
If Not isNone(cmon) Then	Query = Query &" and DatePart(mm,hit_date)  = "&cmon
Query = Query & " Group by "& Column &" Order by "& oColumn &" "&OrDerBy

' 검색어 통계 쿼리
If column = "csearch" Then 
	Query  = "Select "&Column&", count("&Column&") As cutCount From VisitCnt_TB Where "&Column&" is not null and "& column &" != '' "
	' 검색어 통계일 경우는 빈 값은 불러오면 안된다-----------------------------------------------------------------^ 추가 부분   
	If Not isNone(cyear) Then	Query = Query &" and DatePart(yy,hit_date)  = "&cyear
	If Not isNone(cmon) Then	Query = Query &" and DatePart(mm,hit_date)  = "&cmon
	Query = Query & " Group by "&Column&" Order by "&oColumn&" "&OrDerBy
End If
															  
' 날짜별 뷰 통계 쿼리
If Column = "cday" Then
	' 쿼리 만들기
	Query  = "Select Hit_date, cWeek, "&Column&", count("&Column&") as cutCount From VisitCnt_TB Where "&Column&" is not null "
	If Not isNone(cyear) Then Query = Query &" and DatePart(yy,hit_date)  = "&cyear
	If Not isNone(cmon) Then Query = Query &" and DatePart(mm,hit_date)  = "&cmon
	Query = Query & " Group by hit_date, cWeek, "&Column&" Order by "&oColumn&" "&OrDerBy
End If
'Response.Write Query
'레코더셋에 저장된 데이터를 배열에 집어 넣고, 레코더 셋은 닫는다.

Set objRs = RunSQLReturnRS(Query)
objRsNum = objRs.RecordCount
	If objRsNum > 0 Then
		REDim cValue(objRsNum), cutCount(objRsNum) , cWeek(objRsNum)
		
		For ss = 1 to objRsNum
			If objRs.Eof or objRs.BOF Then Exit for
				cValue(ss)  = objRs(0)
				cutCount(ss)= objRs("cutCount")
					If isNone(cValue(ss)) Then cValue(ss) = EmptyStr
					' 페이지 뷰 통계일 경우 링크로 만들어 준다.
					If Column = "cPage" Then cValue(ss) = "<a href='http://"& Request.ServerVariables("Http_Host") & cValue(ss) &"' target=_blank>"&cValue(ss)&"</a>"
					' 일자별 통계일 경우 요일도 표시 한다.
					If column = "cday" Then cWeek(ss)   = objRs("cWeek")
					' 총 카운트 구함
			If Not isNone(cValue(ss)) and Not isNone(cValue(ss)) Then CountTotal = CountTotal + cutCount(ss)
		objRs.MoveNext
		Next
	End If
objRs.Close

' 카운터가 시작된 최초 년 저장
Dim firstYear
  firstYear = year(date())
  Set objRs = RunSQLReturnRS("Select Min(DatePart(yy,hit_date)) AS year From VisitCnt_TB")
  If Not objRs.Eof or objRs.BOF Then firstYear = objRs(0)

Set objRs = Nothing
Set objAdo = Nothing

' 지정되는 년별, 월별로 값을 넘길 폼의 액션
' cyear, cmon의 값은 폼에서 넘기므로 링크에서는 제거 해준다.
Dim cutAction : cutAction = "countYMView.asp?"&Request.ServerVariables("QUERY_STRING")
    cutAction = Replace(cutAction,"cmon=","xmon=")
    cutAction = Replace(cutAction,"cyear=","xyear=")    


' 그래프를 만든다.
Dim percent : percent = "0%"
Function getSticGraph(tableWidth, countTotal, value)
	Dim sel, selNum
	  sel = tableWidth / 100 '4
	  selNum =  (value / countTotal) * 100
	  percent = int(selNum) & "%"  ' 퍼센트
	  getSticGraph = sel * selNum
End function

Function gTitle(str)
	Dim strYear, strmon
	stryear = cyear
	strmon = cmon
	If isNone(stryear) Then stryear = "전체"
	If isNone(strmon) Then strmon = "전체"  
																  
	If str = "cmon" Then
	  gTitle = stryear&"년 " &strmon&"월의 접속 통계"
	ElseIf str = "cday" Then
	  gTitle = stryear&"년 " &strmon&"월의 날짜별 접속 통계"
	ElseIf str = "chour" Then
	  gTitle = stryear&"년 " &strmon&"월의 시간별 접속 통계"
	ElseIf str = "cweek" Then
	  gTitle = stryear&"년 " &strmon&"월의 주별 접속 통계"
	ElseIf str = "csite" Then
	  gTitle = stryear&"년 " &strmon&"월의 참조 사이트 통계"
	ElseIf str = "csearch" Then
	  gTitle = stryear&"년 " &strmon&"월의 검색어 통계"
	ElseIf str = "cos" Then
	  gTitle = stryear&"년 " &strmon&"월의 사용자 운영체제"
	ElseIf str = "cbrowser" Then
	  gTitle = stryear&"년 " &strmon&"월의 사용자 브라우져"                        
	End If
End function

' 컬럼 필드 쓰기 (요일일 경우만 바뀜)
Function gColumn(str)

  If column = "cmon" Then
    gColumn = str & "월"
  ElseIf column = "cday" Then
    gColumn = str & "일"
  ElseIf column <> "cweek" Then
    gColumn = str
  ElseIf str = 1 Then
    gColumn = "<font color='red'>일요일</font>"
  ElseIf str = 2 Then
    gColumn = "월요일"
  ElseIf str = 3 Then
    gColumn = "화요일"
  ElseIf str = 4 Then
    gColumn = "수요일"
  ElseIf str = 5 Then
    gColumn = "목요일"
  ElseIf str = 6 Then
    gColumn = "금요일"                    
  ElseIf str = 7 Then
    gColumn = "<font color='blue'>토요일</font>"    
  Else
    gColumn = "알수 없음"
  End If

End function

' 숫자 요일을 문자로 바꿔준다
Function gcWeek(str)

  If str = 1 Then
    gCWeek = "<font color='red'>(日)</font>"
  ElseIf str = 2 Then
    gCWeek = "(月)"
  ElseIf str = 3 Then
    gCWeek = "(火)"
  ElseIf str = 4 Then
    gCWeek = "(水)"
  ElseIf str = 5 Then
    gCWeek = "(木)"
  ElseIf str = 6 Then
    gCWeek = "(金)"
  ElseIf str = 7 Then
    gCWeek = "<font color='blue'>(土)</font>"
  Else
    gCWeek = ""
  End If

End function

Function gSelect(A,B)

  a = cstr(a)
  b = cstr(b)
  If A = B Then gSelect = "selected"
  
End function

' 현재 컬럼에 글씨 굵게 표시
Function gBold(A,B,kind)

  If Kind = 1 Then
    If a = b Then 
      gBold = "<FONT style='BACKGROUND-COLOR: #0021b0' color=#ffffff><STRONG>"
    Else
      gBold = "<font color='#000000'>"
    End If
  Else
    If a = b Then 
      gBold = "|</STRONG></FONT>"  
    Else
      gBold = "|</font>"
    End If
  End If
  
End Function

%>

<script language="javascript">
function sendit(){
															  
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
						<td><font color="#ffffff" size="4"><b>[접속로그]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<tr>
			<td align="center">
				<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<form name="form1" action="<%=cutAction%>" method="post">
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<TD >
							<select onChange="document.form1.submit();" name="cyear">
								<option value="" >전체</option>
								<% For i=Year(Date())-5 To Year(date()) %>
								<option value="<%=i%>" <%=gSelection(i,cYear,"selected")%>><%=i%></option>
								<% Next %>
							</select>

							<b>년</b>
							<select onChange="document.form1.submit();" name="cmon">
								<option value="" >전체</option>
								<% For i=1 To 12 %>
								<option value="<%=i%>" <%=gSelection(i,cmon,"selected")%>><%=i%></option>
								<% Next %>
							</select>
							<b>월</b>
							<!--
							<a href="countMain.asp"><%=gBold(Lcase(column),"",1)%>Main<%=gBold(Lcase(column),"",2)%></a>
							<a href="countYMView.asp?cmon=<%=cmon%>&cyear=<%=cyear%>&column=cmon&orderby=ASC&emptyStr=&ocolumn=cmon"><%=gBold(Lcase(column),"cmon",1)%>월별<%=gBold(Lcase(column),"cmon",2)%></a>
							<a href="countYMView.asp?cmon=<%=cmon%>&cyear=<%=cyear%>&column=cweek&orderby=ASC&emptyStr=&ocolumn=cweek"><%=gBold(Lcase(column),"cweek",1)%>주별<%=gBold(Lcase(column),"cweek",2)%></a>
							<a href="countYMView.asp?cmon=<%=cmon%>&cyear=<%=cyear%>&column=cday&orderby=ASC&emptyStr=&ocolumn=cday"><%=gBold(Lcase(column),"cday",1)%>일별<%=gBold(Lcase(column),"cday",2)%></a>
							<a href="countYMView.asp?cmon=<%=cmon%>&cyear=<%=cyear%>&column=chour&orderby=ASC&emptyStr=&ocolumn=chour"><%=gBold(Lcase(column),"chour",1)%>시간대별<%=gBold(Lcase(column),"chour",2)%></a>
							<a href="countYMView.asp?cmon=<%=cmon%>&cyear=<%=cyear%>&column=csite&orderby=DESC&emptyStr=즐겨찾기&ocolumn=cutCount"><%=gBold(Lcase(column),"csite",1)%>참조 사이트<%=gBold(Lcase(column),"csite",2)%></a>
							<a href="countYMView.asp?cmon=<%=cmon%>&cyear=<%=cyear%>&column=csearch&orderby=DESC&emptyStr=&ocolumn=cutCount"><%=gBold(Lcase(column),"csearch",1)%>검색어<%=gBold(Lcase(column),"csearch",3)%></a>
							<a href="countYMView.asp?cmon=<%=cmon%>&cyear=<%=cyear%>&column=cos&orderby=desc&emptyStr=알수없음&ocolumn=cutcount"><%=gBold(Lcase(column),"cos",1)%>운영체제<%=gBold(Lcase(column),"cos",2)%></a>
							<a href="countYMView.asp?cmon=<%=cmon%>&cyear=<%=cyear%>&column=cbrowser&orderby=desc&emptyStr=알수없음&ocolumn=cutcount"><%=gBold(Lcase(column),"cbrowser",1)%>브라우져<%=gBold(Lcase(column),"cbrowser",2)%></a>												
							
							-->
						</TD>
					</TR>
				</TABLE>
				
			</TD>
		</tr>
		<tr><td height=20></td></tr>
		<tr>
			<td >
				<table width="99%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>● <%=gTitle(column)%> (총 <%=CountTotal%>건)</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height=10 ></td></tr>
		<tr>
			<td align=center>
				<table width="99%" border="0" cellpadding="2" cellspacing="0" bgcolor="#CCCCCC" bordercolordark="#FFFFFF">
					<tr><td bgcolor=#CCCCCC height=3></td>
<%
					For ss = 1 to objRsNum
						if objRsNum = 0 Then Exit for
%>
					<tr> 
						<td width="130" bgcolor="#029FC8"><font color=#FFFFFF size=2><b><%=gColumn(cValue(ss))%> <!--<%=gcWeek(cWeek(ss))%>--></td>
						<td width="580" bgcolor="#FFFFFF">
							<table width="<%=getSticGraph(450,countTotal, cutCount(ss))%>" border="0" align="left" cellpadding="0" cellspacing="0" style="margin-top:3">
								<tr><td height="12" background="/admin/VisitStatic/img/icon_graph.gif"></td></tr>
							</table>
							<%=cutCount(ss)%> (<%=percent%>)
						</td>
					</tr>
					<tr><td bgcolor=#CCCCCC height=1></td>
<%
					Next
%>
					<tr><td bgcolor=#CCCCCC height=3></td>
				</table>
									
			</td>
		</tr>
	</table>

</body>
</html>