<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<%
' ������ ����µ� �ʿ��� ������ �ޱ�
Dim Column, OrderBy, EmptyStr, mode, oColumn, cYear, cmon, i
Column  = Request("Column")  ' ī������ �� �÷� 
OColumn = Request("OColumn") ' ���� �ʵ���
OrderBy = Request("OrderBy") ' ���� ���
EmptyStr= Request("EmptyStr")' �� ���� �� ��
mode    = Request("mode")    ' ��Ÿ
cYear   = Request("cyear")
cmon    = Request("cmon")

If isNone(Column) Then Column = "cmon"
If isNone(oColumn) Then oColumn = Column
If isNone(orderBy) Then orderBy = "ASC"
Dim Query, cValue(), cWeek(), objRsNum, cutCount(), ss, CountTotal  
	
' ���� �����
Query = "Select "&Column&", count("&Column&") as cutCount From VisitCnt_TB Where "&Column&" is not null "
If Not isNone(cyear) Then	Query = Query &" and DatePart(yy,hit_date)  = "& cyear
If Not isNone(cmon) Then	Query = Query &" and DatePart(mm,hit_date)  = "&cmon
Query = Query & " Group by "& Column &" Order by "& oColumn &" "&OrDerBy

' �˻��� ��� ����
If column = "csearch" Then 
	Query  = "Select "&Column&", count("&Column&") As cutCount From VisitCnt_TB Where "&Column&" is not null and "& column &" != '' "
	' �˻��� ����� ���� �� ���� �ҷ����� �ȵȴ�-----------------------------------------------------------------^ �߰� �κ�   
	If Not isNone(cyear) Then	Query = Query &" and DatePart(yy,hit_date)  = "&cyear
	If Not isNone(cmon) Then	Query = Query &" and DatePart(mm,hit_date)  = "&cmon
	Query = Query & " Group by "&Column&" Order by "&oColumn&" "&OrDerBy
End If
															  
' ��¥�� �� ��� ����
If Column = "cday" Then
	' ���� �����
	Query  = "Select Hit_date, cWeek, "&Column&", count("&Column&") as cutCount From VisitCnt_TB Where "&Column&" is not null "
	If Not isNone(cyear) Then Query = Query &" and DatePart(yy,hit_date)  = "&cyear
	If Not isNone(cmon) Then Query = Query &" and DatePart(mm,hit_date)  = "&cmon
	Query = Query & " Group by hit_date, cWeek, "&Column&" Order by "&oColumn&" "&OrDerBy
End If
'Response.Write Query
'���ڴ��¿� ����� �����͸� �迭�� ���� �ְ�, ���ڴ� ���� �ݴ´�.

Set objRs = RunSQLReturnRS(Query)
objRsNum = objRs.RecordCount
	If objRsNum > 0 Then
		REDim cValue(objRsNum), cutCount(objRsNum) , cWeek(objRsNum)
		
		For ss = 1 to objRsNum
			If objRs.Eof or objRs.BOF Then Exit for
				cValue(ss)  = objRs(0)
				cutCount(ss)= objRs("cutCount")
					If isNone(cValue(ss)) Then cValue(ss) = EmptyStr
					' ������ �� ����� ��� ��ũ�� ����� �ش�.
					If Column = "cPage" Then cValue(ss) = "<a href='http://"& Request.ServerVariables("Http_Host") & cValue(ss) &"' target=_blank>"&cValue(ss)&"</a>"
					' ���ں� ����� ��� ���ϵ� ǥ�� �Ѵ�.
					If column = "cday" Then cWeek(ss)   = objRs("cWeek")
					' �� ī��Ʈ ����
			If Not isNone(cValue(ss)) and Not isNone(cValue(ss)) Then CountTotal = CountTotal + cutCount(ss)
		objRs.MoveNext
		Next
	End If
objRs.Close

' ī���Ͱ� ���۵� ���� �� ����
Dim firstYear
  firstYear = year(date())
  Set objRs = RunSQLReturnRS("Select Min(DatePart(yy,hit_date)) AS year From VisitCnt_TB")
  If Not objRs.Eof or objRs.BOF Then firstYear = objRs(0)

Set objRs = Nothing
Set objAdo = Nothing

' �����Ǵ� �⺰, ������ ���� �ѱ� ���� �׼�
' cyear, cmon�� ���� ������ �ѱ�Ƿ� ��ũ������ ���� ���ش�.
Dim cutAction : cutAction = "countYMView.asp?"&Request.ServerVariables("QUERY_STRING")
    cutAction = Replace(cutAction,"cmon=","xmon=")
    cutAction = Replace(cutAction,"cyear=","xyear=")    


' �׷����� �����.
Dim percent : percent = "0%"
Function getSticGraph(tableWidth, countTotal, value)
	Dim sel, selNum
	  sel = tableWidth / 100 '4
	  selNum =  (value / countTotal) * 100
	  percent = int(selNum) & "%"  ' �ۼ�Ʈ
	  getSticGraph = sel * selNum
End function

Function gTitle(str)
	Dim strYear, strmon
	stryear = cyear
	strmon = cmon
	If isNone(stryear) Then stryear = "��ü"
	If isNone(strmon) Then strmon = "��ü"  
																  
	If str = "cmon" Then
	  gTitle = stryear&"�� " &strmon&"���� ���� ���"
	ElseIf str = "cday" Then
	  gTitle = stryear&"�� " &strmon&"���� ��¥�� ���� ���"
	ElseIf str = "chour" Then
	  gTitle = stryear&"�� " &strmon&"���� �ð��� ���� ���"
	ElseIf str = "cweek" Then
	  gTitle = stryear&"�� " &strmon&"���� �ֺ� ���� ���"
	ElseIf str = "csite" Then
	  gTitle = stryear&"�� " &strmon&"���� ���� ����Ʈ ���"
	ElseIf str = "csearch" Then
	  gTitle = stryear&"�� " &strmon&"���� �˻��� ���"
	ElseIf str = "cos" Then
	  gTitle = stryear&"�� " &strmon&"���� ����� �ü��"
	ElseIf str = "cbrowser" Then
	  gTitle = stryear&"�� " &strmon&"���� ����� ������"                        
	End If
End function

' �÷� �ʵ� ���� (������ ��츸 �ٲ�)
Function gColumn(str)

  If column = "cmon" Then
    gColumn = str & "��"
  ElseIf column = "cday" Then
    gColumn = str & "��"
  ElseIf column <> "cweek" Then
    gColumn = str
  ElseIf str = 1 Then
    gColumn = "<font color='red'>�Ͽ���</font>"
  ElseIf str = 2 Then
    gColumn = "������"
  ElseIf str = 3 Then
    gColumn = "ȭ����"
  ElseIf str = 4 Then
    gColumn = "������"
  ElseIf str = 5 Then
    gColumn = "�����"
  ElseIf str = 6 Then
    gColumn = "�ݿ���"                    
  ElseIf str = 7 Then
    gColumn = "<font color='blue'>�����</font>"    
  Else
    gColumn = "�˼� ����"
  End If

End function

' ���� ������ ���ڷ� �ٲ��ش�
Function gcWeek(str)

  If str = 1 Then
    gCWeek = "<font color='red'>(��)</font>"
  ElseIf str = 2 Then
    gCWeek = "(��)"
  ElseIf str = 3 Then
    gCWeek = "(��)"
  ElseIf str = 4 Then
    gCWeek = "(�)"
  ElseIf str = 5 Then
    gCWeek = "(��)"
  ElseIf str = 6 Then
    gCWeek = "(��)"
  ElseIf str = 7 Then
    gCWeek = "<font color='blue'>(��)</font>"
  Else
    gCWeek = ""
  End If

End function

Function gSelect(A,B)

  a = cstr(a)
  b = cstr(b)
  If A = B Then gSelect = "selected"
  
End function

' ���� �÷��� �۾� ���� ǥ��
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
						<td><font color="#ffffff" size="4"><b>[���ӷα�]</b></font></td>
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
								<option value="" >��ü</option>
								<% For i=Year(Date())-5 To Year(date()) %>
								<option value="<%=i%>" <%=gSelection(i,cYear,"selected")%>><%=i%></option>
								<% Next %>
							</select>

							<b>��</b>
							<select onChange="document.form1.submit();" name="cmon">
								<option value="" >��ü</option>
								<% For i=1 To 12 %>
								<option value="<%=i%>" <%=gSelection(i,cmon,"selected")%>><%=i%></option>
								<% Next %>
							</select>
							<b>��</b>
							<!--
							<a href="countMain.asp"><%=gBold(Lcase(column),"",1)%>Main<%=gBold(Lcase(column),"",2)%></a>
							<a href="countYMView.asp?cmon=<%=cmon%>&cyear=<%=cyear%>&column=cmon&orderby=ASC&emptyStr=&ocolumn=cmon"><%=gBold(Lcase(column),"cmon",1)%>����<%=gBold(Lcase(column),"cmon",2)%></a>
							<a href="countYMView.asp?cmon=<%=cmon%>&cyear=<%=cyear%>&column=cweek&orderby=ASC&emptyStr=&ocolumn=cweek"><%=gBold(Lcase(column),"cweek",1)%>�ֺ�<%=gBold(Lcase(column),"cweek",2)%></a>
							<a href="countYMView.asp?cmon=<%=cmon%>&cyear=<%=cyear%>&column=cday&orderby=ASC&emptyStr=&ocolumn=cday"><%=gBold(Lcase(column),"cday",1)%>�Ϻ�<%=gBold(Lcase(column),"cday",2)%></a>
							<a href="countYMView.asp?cmon=<%=cmon%>&cyear=<%=cyear%>&column=chour&orderby=ASC&emptyStr=&ocolumn=chour"><%=gBold(Lcase(column),"chour",1)%>�ð��뺰<%=gBold(Lcase(column),"chour",2)%></a>
							<a href="countYMView.asp?cmon=<%=cmon%>&cyear=<%=cyear%>&column=csite&orderby=DESC&emptyStr=���ã��&ocolumn=cutCount"><%=gBold(Lcase(column),"csite",1)%>���� ����Ʈ<%=gBold(Lcase(column),"csite",2)%></a>
							<a href="countYMView.asp?cmon=<%=cmon%>&cyear=<%=cyear%>&column=csearch&orderby=DESC&emptyStr=&ocolumn=cutCount"><%=gBold(Lcase(column),"csearch",1)%>�˻���<%=gBold(Lcase(column),"csearch",3)%></a>
							<a href="countYMView.asp?cmon=<%=cmon%>&cyear=<%=cyear%>&column=cos&orderby=desc&emptyStr=�˼�����&ocolumn=cutcount"><%=gBold(Lcase(column),"cos",1)%>�ü��<%=gBold(Lcase(column),"cos",2)%></a>
							<a href="countYMView.asp?cmon=<%=cmon%>&cyear=<%=cyear%>&column=cbrowser&orderby=desc&emptyStr=�˼�����&ocolumn=cutcount"><%=gBold(Lcase(column),"cbrowser",1)%>������<%=gBold(Lcase(column),"cbrowser",2)%></a>												
							
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
						<td>�� <%=gTitle(column)%> (�� <%=CountTotal%>��)</td>
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