
<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->
<%

Dim Column, OrderBy, EmptyStr, mode, oColumn, cYear, cmon
	
Column  = Request.QueryString("Column")  ' ī������ �� �÷� 
OColumn = Request.QueryString("OColumn") ' ���� �ʵ���
OrderBy = Request.QueryString("OrderBy") ' ���� ���
EmptyStr= Request.QueryString("EmptyStr")' �� ���� �� ��
mode    = Request.QueryString("mode")    ' ��Ÿ
cYear   = Request.QueryString("cyear")
cmon    = Request.QueryString("cmon")
If isNone(cYear) Then cYear = Request.Form("cyear")
If isNone(cmon) Then cmon = Request.Form("cmon")
If isNone(Column) Then Column = "cmon"
If isNone(oColumn) Then oColumn = Column
If isNone(orderBy) Then orderBy = "ASC"
	

' �����Ǵ� �⺰, ������ ���� �ѱ� ���� �׼�
' cyear, cmon�� ���� ������ �ѱ�Ƿ� ��ũ������ ���� ���ش�.
Dim cutAction : cutAction = "countYMView.asp?"&Request.ServerVariables("QUERY_STRING")
    cutAction = Replace(cutAction,"cmon","xmon")
    cutAction = Replace(cutAction,"cyear","xyear")    

' ī���� ���

SQL = "SELECT Distinct (Select Min(hit_date) As first_day FROM VisitCnt_TB),"
SQL = SQL &" (Select count(idx)  FROM VisitCnt_TB WHERE DateDiff(dd,hit_date,getdate())=1) ,"
SQL = SQL &" (Select count(idx) As today FROM VisitCnt_TB WHERE DateDiff(dd,hit_date,getdate())=0),"
SQL = SQL &" (Select count(idx) As today FROM VisitCnt_TB)"
SQL = SQL &" FROM VisitCnt_TB"


Set objRs = RunSQLReturnRS(SQL)
  ' ī���� ������
	If Not objRs.EOF or Not objRs.BOF Then
		firstday	= objRs(0)
		yesterday	= objRs(1)
		today		= objRs(2)
		totalday	= objRs(3)
	End If
objRs.Close

'�ְ�,���� �湮�� ��
SQL = "SELECT Distinct m.Hit_date, m.cDay, m.cutCount, n.Hit_date, n.cDay, n.cutCount FROM VisitCnt_TB c,"
SQL = SQL &" (SELECT Top 1 Hit_date, cDay, COUNT(cDay) As cutCount FROM VisitCnt_TB WHERE CDay  Is Not Null Group By Hit_date, cDay Order By cutCount DESC) m,"
SQL = SQL &" (SELECT Top 1 Hit_date, cDay, COUNT(cDay) As cutCount FROM VisitCnt_TB WHERE CDay  Is Not Null Group By Hit_date, cDay Order By cutCount ASC) n "
Set objRs = RunSQLReturnRS(SQL)
If Not objRs.EOF or Not objRs.BOF Then 
	MaxDay		= objRs(0)
	Maxcount	= objRs(2)
	MinDay		= objRs(3)
	Mincount	= objRs(5)
End If
objRs.Close

															  
' �˻����� ���� 
SQL = "SELECT Top 10 cSite, COUNT(cSite)  As cutCount FROM VisitCnt_TB WHERE DateDiff(dd,hit_date, getdate())=0 and "
SQL = SQL &" cSite Is Not Null and cSite != '' Group By cSite Order By cutcount DESC"
Set objRs = RunSQLReturnRS(SQL)
If objRs.EOF or objRs.BOF Then
	SarrRsCnt = -1
Else
	SarrRs	= objRs.getRows()
	SarrRsCnt = Ubound(SarrRs,2)
End If
objRs.Close    
															  
' �˻��� ���� 
SQL = "Select Top 10 cSearch, COUNT(cSearch) As cutCount FROM VisitCnt_TB WHERE DateDiff(dd,hit_date, getdate())=0 and "
SQL = SQL &" cSearch Is Not Null and cSearch != '' Group By cSearch Order By cutcount DESC "
Set objRs = RunSQLReturnRS(SQL)
If objRs.EOF or objRs.BOF Then
	KarrRsCnt = -1
Else
	KarrRs	= objRs.getRows()
	KarrRsCnt = Ubound(KarrRs,2)
End If

Set objRs = Nothing
Set objAdo = Nothing


' ���� �÷��� �۾� ���� ǥ��
Function gBold(A,B,kind)
	If Kind = 1 Then
		If a = b Then 
			gBold = "<FONT style='BACKGROUND-COLOR: #0021b0' color=#ffffff><b>"
		Else
			gBold = "<font color='#000000'>"
		End if
	Else
		If a = b Then
			gBold = "|</b></FONT>"  
		Else
			gBold = "|</font>"
		End If
	End If
End Function
%>
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
								<option value="<%=i%>" <%=gSelection(ss,cyear,"selected")%>><%=i%></option>
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
			</td>
		</tr>
		
		<tr>
			<td><br>
				<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<form name=sfrms method=post action="MemberList.asp">
					<input type=HIDDEN name=Sect value="<%=Sect%>">
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td><br>
							<span style="font-size:10pt;"><b>1. �Ѱ� ����</b></span>
							<ul type="disc">
							<li>���� �湮�� : <%=reInt(yesterday,0)%>��</li>
							<li><font color="red">���� �湮�� : <%=reInt(today,0)%>��</font></li>
							<li>�ְ� �湮�� : <%=reInt(MaxCount,0)%>�� (<%=MaxDay%>)</li>
							<li>���� �湮�� : <%=reInt(MinCount,0)%>�� (<%=MinDay%>)</li>
							<li><font color="red"><b>ī���� �Ѱ� : <%=reInt(totalday,0)%>��</b></font></li>
							<li>ī���� ������ : <%=IfElse(firstday,now())%>�Ϻ��� <b><%=datediff("d",IfElse(firstday,now()),now())%></b>�ϰ� ������</li>
							</ul>
						</td>
					</tr>
					</form>
				</table>
				
			</td>
		</tr>
		<!--
		<tr>
			<td>
														
				<table border="0" width="100%">
					<tr>
						<td width="694"><b>2. ����</b></span></p>
							<ul type="disc">
							<li>�˻���<br>
																		
								<table width="95%" border="0" cellpadding="3" cellspacing="0" style="margin-top:3;margin-bottom:6">
									<tr bgcolor="#e0e0e0"> 
										<td width="10%" height="25"><b>����</b></font></td>
										<td><b>������</b></font></td>
										<td width="15%"><b>���ӷ�</b></font></td>
									</tr>
<% 
									If KarrRsCnt > -1 Then
										For i = 0 To KarrRsCnt 
%>
									<tr> 
										<td align="center"><%=i+1%></div></td>
										<td><a href='http://<%=Request.ServerVariables("HTTP_HOST")%><%=KarrRs(0,i)%>' target=_blank><%=KarrRs(0,i)%></a></td>
										<td><div align="center"><%=KarrRs(1,i)%></div></td>
									</tr>
									<tr bgcolor="#aaaaaa"><td height="1" colspan=3></td></tr>
<%
										Next
									End If
%>
									<tr bgcolor="#aaaaaa"><td height="1" colspan=3></td></tr>
								</table>
																																
								<li>�˻����� 
																
								<table width="95%" border="0" cellpadding="3" cellspacing="0" style="margin-top:3;margin-bottom:6">
									<tr bgcolor="#e0e0e0"> 
										<td width="10%" height="25"><b>����</td>
										<td><b>�˻�����</td>
										<td width="15%"><b>����</td>
									</tr>
<% 
									If SarrRsCnt > -1 Then
										For i = 0 To SarrRsCnt 
%>
									<tr> 
										<td align="center"><%=i+1%></div></td>
										<td><%=SarrRs(0,i)%></td>
										<td><div align="center"><%=SarrRs(1,i)%></div></td>
									</tr>
									<tr bgcolor="#aaaaaa"><td height="1" colspan=3></td></tr>
<%
										Next
									End If
%>
									<tr bgcolor="#aaaaaa"><td height="1" colspan=3></td></tr>
								</table>

							</td>
						</tr>
					</table>
				</td>
			</tr>
			-->
		</table>								
	</td>
</tr>
<tr><td height=1 bgcolor="#dedede"></td></tr>
</table>
</body>
</html>