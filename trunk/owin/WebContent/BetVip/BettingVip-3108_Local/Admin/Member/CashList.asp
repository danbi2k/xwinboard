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
KD1			= Request("KD1")
f_date	= Request("f_date")
t_date	= Request("t_date")

'SQL = "SELECT SUM(RCash), (SELECT SUM(RCash) FROM Cash_TB WHERE Type='"& Sect &"' And Visbled=1 And Status=0), (SELECT SUM(RCash) FROM Cash_TB WHERE Type='"& Sect &"' And Visbled=1 And Status=1) FROM Cash_TB WHERE Type='"& Sect &"'"
'If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" AND "& KeyField &" LIKE '%"& KeyWord &"%'"
'If Not isNone(f_date) And Not isNone(t_date) Then SQL = SQL &" And convert(varchar(10),WriteDay,120 ) BETWEEN convert(varchar(10),'"& f_date &"',120 ) And convert(varchar(10),'"& t_date &"',120 ) "

If Not isNone(KeyField) And Not isNone(KeyWord) Then sSQL = " AND "& KeyField &" LIKE '%"& KeyWord &"%'"
If Not isNone(f_date) And Not isNone(t_date) Then sSQL = sSQL & " And convert(varchar(10),WriteDay,120 ) BETWEEN convert(varchar(10),'"& f_date &"',120 ) And convert(varchar(10),'"& t_date &"',120 ) "
SQL = "SELECT SUM(RCash), "
SQL = SQL &" (SELECT SUM(RCash) FROM Cash_TB WHERE Type='"& Sect &"' And Visbled=1 And Status=0 "& sSQL &"), "
SQL = SQL &" (SELECT SUM(RCash) FROM Cash_TB WHERE Type='"& Sect &"' And Visbled=1 And Status=1 "& sSQL &") FROM Cash_TB WHERE Type='"& Sect &"' "& sSQL &""

If Session("SYS_ID") = "IN" Then
'response.write SQL&"<BR><BR><BR>"
End If
Set objRs = RunSQLReturnRs(SQL)
If Not objRs.EOF Then ToSDayCash = objRs(0) : ToSDaySDCash = objRs(1) : ToSDaySSDCash = objRs(2) : objRs.Close : Set objRs = Nothing


bTitle = "ȯ"
If Sect = 0 Then bTitle = "��"
If Flag="STOPS" Then
	SQL = "UPDATE Cash_TB Set Stops='"& senum &"' WHERE Idx='"& IntIdx &"'"
'	Response.Write SQL
'	Response.end
	RunSQL(SQL)
	Call descment("","CashList.asp?CurPage="& CurPage &"&CurBlock="& CurBlock &"&Sect="& Sect &"&KeyField="& KeyField &"&KeyWord="& KeyWord &"&f_date="& f_date &"&t_date="& t_date &"&KD1="& KD1,"")
End If


If Flag="DELETE" Then
'	RunSQL("DELETE FROM Cash_TB WHERE Idx='"& IntIdx &"'")
	SQL = "UPDATE Cash_TB Set Visbled=1, ChId='"& Session("SYS_ID") &"', DDay=getDate() WHERE Idx='"& IntIdx &"'"
'	Response.Write SQL
'	Response.End
	RunSQL(SQL)
	Call descment("","CashList.asp?CurPage="& CurPage &"&CurBlock="& CurBlock &"&Sect="& Sect &"&KeyField="& KeyField &"&KeyWord="& KeyWord &"&f_date="& f_date &"&t_date="& t_date &"&KD1="& KD1,"")
End If

Select Case Sect
	Case 0 : titl = "ĳ������ ��û"	: titl2 = "���� �ݾ�"	: titl3 = "��ü �����ݾ�"
	Case 1 : titl = "ĳ��ȯ�� ��û"	: titl2 = "ȯ�� �ݾ�"	: titl3 = "��ü ȯ���ݾ�"
End Select

If Not isNone(SortColumn) And Not isNone(strSort) Then
	order = " ORDER BY " & SortColumn & " " & strSort & ""
Else
	order = " ORDER BY WriteDay DESC "
End If

SQL = "SELECT * FROM Cash_TB WHERE Type='"& Sect &"'"
If LCase(Session("SYS_ID"))="master" or LCase(Session("SYS_ID"))="in"  Then 
	SQL = SQL &" AND ( ChId<>'master' or ChId IS NULL) "
	If isInt(KD1) Then 	SQL = SQL &" And Visbled='"& KD1 &"' "
Else
	SQL = SQL &" AND Visbled=0 "
End if
If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" AND "& KeyField &" LIKE '%"& KeyWord &"%'"
If Not isNone(f_date) And Not isNone(t_date) Then SQL = SQL &" And convert(varchar(10),WriteDay,120 ) BETWEEN convert(varchar(10),'"& f_date &"',120 ) And convert(varchar(10),'"& t_date &"',120 ) "
SQL = SQL & order
If Session("SYS_ID") = "master" Then
'Response.Write sql
End If 
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
If(isNone(strSort) Or strSort="Desc") Then strSort="Asc" Else strSort="Desc": '//���Ĺ�� ���� ����
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
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["KD1"]			= '<%=KD1%>';
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
		getQuery["KD1"]			= '<%=KD1%>';
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
		getQuery["KD1"]			= '<%=KD1%>';
		action();
	}

	
	function GoSearch() {
		lfm.action=window.location.pathname
		lfm.submit()
	}
		

function showToolTip(current,e,strText)
{
   // ���ͳ� �ͽ��÷η��̸� ���� title �Ӽ��� ����Ѵ�.
   if (document.all)
   {
      // ���� ���ڿ� �ȿ� <br> �±װ� �ִ��� Ȯ��
      strTitle=strText.split('<br>')
      // ���� ���ڿ� �ȿ� <br> �±װ� ������
      if (strTitle.length > 1)
      {
        strTitles=""
        for (i=0; i<strTitle.length; i++)
           strTitles += strTitle[i] + "\r\n"
        current.title = strTitles
      }
      else current.title = strText
   }
 
   // �ݽ��������̸� ���̾� �±׸� ����Ѵ�.
   else if (document.layers)
   {
       // ���� �ȿ� tooltip�̶� ID�� <div> ��ü�� �ϳ� ���Ե� ���̴�.
       // �� <div> ��ü ���̾� �ȿ� ���̾� �±׸� �����Ѵ�.
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

function seArch() {
	location.href = window.location.pathname+'?f_date='+document.all.f_date.value+'&t_date='+document.all.t_date.value+'&Sect=<%=Sect%>&KeyField='+document.all.KeyField.value+'&KeyWord='+document.all.KeyWord.value+'&KD1='+document.all.KD1.value;

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
						<td><font color="#ffffff" size="4"><b>[<%=titl%> ���� ]</b></font></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="24" background="/Images/Admin/top3_bg.gif"></td></tr>
		<tr>
			<td >
			<% If LCase(Session("SYS_ID"))="master" or LCase(Session("SYS_ID"))="in" Then %>
				<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<select name=KeyField>
								<option value="Id" <%=gSelection(KeyField,"Id","Selected")%>>���̵�</option>
								<option value="Depos" <%=gSelection(KeyField,"Depos","Selected")%>>�̸�</option>
							</select>
							
								&nbsp;&nbsp;&nbsp;
								<input type=text name=KeyWord value="<%=KeyWord%>">
								<select name=KD1>
								<option value="0" <%=gSelection(KD1,0,"Selected")%>>��κ���</option>
								<option value="1" <%=gSelection(KD1,1,"Selected")%>>�������ڷḸ ����</option>
							</select>&nbsp;&nbsp;
								
									<input type="text" name="f_date" size="10" value="<%=f_date%>" maxlength="10" class="input4" onchange="ValidateDatetime(this.form, this.name);"> 

									<a href="javascript:Calendar_D(f_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>

									~

									<input type="text" name="t_date" size="10" value="<%=t_date%>" maxlength="10" class="input4" onchange="ValidateDatetime(this.form, this.name);"> 

									<a href="javascript:Calendar_D(t_date); "><img src="/images/ico_cal.gif" alt="" width="13" height="13" border="0"></a>

								<input type=button value="�� ��" onclick="seArch();">								
						</td>
					</tr>
				</table>
			<% Else %>
				<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<form name=sfrms method=post action="CashList.asp">
					<input type=HIDDEN name=Sect value="<%=Sect%>">
					<tr height="30" bgcolor="#e0e0e0" style="padding-left:30pt">
						<td>
							<select name=KeyField>
								<option value="Id" <%=gSelection(KeyField,"Id","Selected")%>>���̵�</option>
								<option value="Depos" <%=gSelection(KeyField,"Depos","Selected")%>>�̸�</option>
							</select>
							
								&nbsp;&nbsp;&nbsp;
								<input type=text name=KeyWord value="<%=KeyWord%>">
								<input type=submit value="�� ��" id=submit1 name=submit1>
						</td>
					</tr>
					</form>
				</table>

				<%End If %>
			</td>
		</tr>
		<% If LCase(Session("SYS_ID"))="master" or LCase(Session("SYS_ID"))="in" Then %>
		<tr>
			<td ><br>
				<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa">
					<tr height="27" bgcolor="#e0e0e0" >
						<td width=170>&nbsp;<%=titl3%></td>
						<td> <b><%If Not isNone(f_date) And Not isNone(t_date) Then %><%=f_date%> ~ <%=t_date%> ���� <%End If %> <font color=red><%=formatnumber(reInt(ToSDayCash,0),[])%>
						</td>
					</tr>
					<tr height="27" bgcolor="#e0e0e0" >
						<td>&nbsp;����� �����ݾ� </td>
						<td> <b><%If Not isNone(f_date) And Not isNone(t_date) Then %><%=f_date%> ~ <%=t_date%> ���� <%End If %> <font color=red><%=formatnumber(reInt(ToSDaySDCash,0),[])%>
						</td>
					</tr>	
					<tr height="27" bgcolor="#e0e0e0" >
						<td>&nbsp;�Ϸ�� �����ݾ� </td>
						<td> <b><%If Not isNone(f_date) And Not isNone(t_date) Then %><%=f_date%> ~ <%=t_date%> ���� <%End If %> <font color=red><%=formatnumber(reInt(ToSDaySSDCash,0),[])%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<%End If %>
		<tr>
			<td><br>
				<table width="790" border="0" cellspacing="1" cellpadding="0" bgcolor="#aaaaaa" align=center>
					<form  name=frms>
					<tr height="30" align="center" bgcolor="#e0e0e0">
						<td width="20"><input type=checkbox onclick="fSelectAllCheckBox(frms)" id=checkbox1 name=checkbox1></td>
					<% If Sect=0 Then %>
						<td width="110"><nobr>����</td>
						<td width="80"><nobr>����</td>
						<td width="80"><nobr>�����ϱ�</td>
						<td width="150"><nobr>���̵�</td>
						<td width="130"><nobr>�Ա��� �̸�</td>
						<td width="180"><nobr><%=titl2%></td>
<!--						<td width="180"><nobr>2%�߰����հ�</td>-->
						<td width="200"><nobr>��û��</td>
						<td width="40"><nobr>����</td>
					<% Else %>
						<td width="100"><nobr>����</td>
						<td width="80"><nobr>����</td>
						<td width="130"><nobr>���̵�</td>
						<td width="130"><nobr>������</td>
						<td width="150"><nobr>�ŷ�����</td>
						<td width="150"><nobr>���¹�ȣ</td>
						<td width="130"><nobr><%=titl2%></td>
						<td width="220"><nobr>��û��</td>
						<td width="40"><nobr>����</td>
					<% End If %>
					<% If LCase(Session("SYS_ID"))="master" Then %>
						<td width="60"><nobr>����</td>
						<td width="100"><nobr>�������̵�</td>
						<td width="220"><nobr>�����Ͻ�</td>
					<% End If %>
					</tr>
<%
					If objRs.EOF or objRs.BOF Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>��ϵ� �ڷᰡ �����ϴ�.</td></tr>"
					Else
					    Dim count : count = 0
					    Do Until objRs.EOF Or count >= pageSize
						Set Rsm = RunSQLReturnRs("SELECT CDepos, BankN, BankNum, RDepos FROM Member_TB WHERE Id='"& objRs("Id") &"'")
							If Not (Rsm.EOF or Rsm.BOF) Then
								CDepos	= Rsm("CDepos") : BankN	= Rsm("BankN")
								BankNum	= Rsm("BankNum") : RDepos= Rsm("RDepos")
							End If
						Set Rsm = Nothing
'						PlusPoint = (objRs("RCash")/100)*2
'						PlusPoint = objRs("RCash")
%>
					<tr height="20" align="center" <% If LCase(Session("SYS_ID"))="master" or LCase(Session("SYS_ID"))="in" Then %> <% If objRs("Visbled")=0 Then%> bgcolor="#FFFFFF" <%Else%> bgcolor="#FFCAD5" <%End If%>  onMouseOver='this.style.backgroundColor="#e4e4e4"' <% If objRs("Visbled")=0 Then%> onMouseOut='this.style.backgroundColor=""' <%Else%> onMouseOut='this.style.backgroundColor="#FFCAD5"' <%End If%> <%Else%> onMouseOver='this.style.backgroundColor="#e4e4e4"' onMouseOut='this.style.backgroundColor=""' bgcolor="#FFFFFF" <%End If%>>
						<td><input type=checkbox name=selcheck value="<%=objRs("Idx")%>" ></td>
					<% If Sect=0 Then %>
						<td align="center"><nobr>
						<% If objRs("Status")=0 Then %>
						<font color=C3B801><b>���� �����</font></b>
						<%Else %>
						<font color=08AA00><b>���� �Ϸ�</font></b>
						<% End If %>
						<td align="center"><%If Sect=0 And objRs("Status")=0 Then %> <input type=checkbox value=1 name=sostop onclick="MovePage('<%=objRs("Idx")%>','CashList.asp','STOPS',<%If objRs("Stops")=0 Then %>1<%Else%>0<%End If%>,'')" <%=gSelection(objRs("Stops"),1,"checked")%> ><%End If%></td>
						<!--
							<select name="Status">
								<option <%=gSelection(objRs("Status"),0,"selected")%> value=0 style="background-color:#FFEA00">���� �����</option>
								<option <%=gSelection(objRs("Status"),1,"selected")%> value=1 style="background-color:#00FF2A">���� �Ϸ�</option>
							</select>
							-->
						</td>
						<td align="center">
						<% If objRs("Status")=0 Then %>
							<input type=button value="�����ϱ�" onclick="if(confirm('<%=objRs("Id")%> ȸ������ <%=formatnumber(objRs("RCash"),[])%> ���� \n�������� �Ͻðڽ��ϱ�?')) {MM_winopen('Cash_Prc.asp?Sect=<%=Sect%>&Id=<%=objRs("Id")%>&Idx=<%=objRs("Idx")%>&Cash=<%=objRs("RCash")%>','CA','width=500,height=500');}" id=button2 name=button2>
						<%Else %>
							<!--<input type=button value="�����ϱ�" onclick="if(confirm('<%=objRs("Id")%> ȸ������ �̹�<%=formatnumber(objRs("RCash"),[])%> ���� �������� �ϼ̽��ϴ�.\n�ߺ� �������� �Ͻðڽ��ϱ�?')) {MM_winopen('Cash_Prc.asp?Sect=<%=Sect%>&Id=<%=objRs("Id")%>&Idx=<%=objRs("Idx")%>&Cash=<%=objRs("RCash")%>','CA','width=20,height=20');}">-->
						<% End If %>
						</td>
						<td align="center"><a href=#" onmouseover="showToolTip(this,event,'������ �Ա��ڸ�:<%=CDepos%><br>ȯ���� ����:<%=BankN%><br>���¹�ȣ:<%=BankNum%><br>������:<%=RDepos%>')" onmouseout="hideToolTip()"><%=objRs("Id")%></a></td>
						<td><%=objRs("Depos")%></td>
						<td><nobr><%=formatnumber(objRs("RCash"),[])%> ��</td>
<!--						<td><%=formatnumber(objRs("RCash"),[])%> ��</td>-->
						<td><nobr><%=objRs("WriteDay")%></td>
						<td ><input type=button value="����" onclick="if(confirm('������ �ڷ�� ������ �� �����ϴ�.\n\n�����Ͻðڽ��ϱ�?')){MovePage('<%=objRs("Idx")%>','CashList.asp','DELETE','','');}" id=button1 name=button1></td>
					<% Else %>
						<td align="center"><nobr>
							<select name="Status" onchange="MovePage('<%=objRs("Idx")%>', 'Cash_Prc.asp', 'CHECKCASHOUTUNIT', this.value, '')">
								<option <%=gSelection(objRs("Status"),0,"selected")%> value=0 style="background-color:#FFEA00">ȯ�� �����</option>
								<option <%=gSelection(objRs("Status"),1,"selected")%> value=1 style="background-color:#00FF2A">ȯ�� �Ϸ�</option>
							</select>
						</td>
						<td align="center"><%If Sect=1 And objRs("Status")=0 Then %> <input type=checkbox value=1 name=sostop onclick="MovePage('<%=objRs("Idx")%>','CashList.asp','STOPS',<%If objRs("Stops")=0 Then %>1<%Else%>0<%End If%>,'')" <%=gSelection(objRs("Stops"),1,"checked")%> ><%End If%></td>
						<td align="center"><a href=#" onmouseover="showToolTip(this,event,'������ �Ա��ڸ�:<%=CDepos%><br>ȯ���� ����:<%=BankN%><br>���¹�ȣ:<%=BankNum%><br>������:<%=RDepos%>')" onmouseout="hideToolTip()"><%=objRs("Id")%></a></td>
						<td><nobr><%=objRs("Depos")%></td>
						<td><nobr><%=objRs("BankName")%></td>
						
						<td><nobr><%=objRs("BankCode")%></td>
						<td><nobr><%=formatnumber(objRs("RCash"),[])%> ��</td>
						<td><nobr><%=objRs("WriteDay")%></td>
						<td ><nobr><input type=button value="����" onclick="if(confirm('������ �ڷ�� ������ �� �����ϴ�.\n\n�����Ͻðڽ��ϱ�?')){MovePage('<%=objRs("Idx")%>','CashList.asp','DELETE','','');}" id=button1 name=button1></td>
					<% End If %>
					<% If LCase(Session("SYS_ID"))="master" Then %>
						<td width="60"><nobr><% If objRs("Visbled")=0 Then%>����<%Else%><font color=red>����<%End If%></td>
						<td width="100"><nobr><%=objRs("ChId")%></td>
						<td width="220"><nobr><%=objRs("DDay")%></td>
					<% End If %>	
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
							<input type=button value="���û���" onclick="if(confirm('���� �Ͻðڽ��ϱ�?')){MovePage('','AllDel.asp','CHECKDEL','',frms);}" id=button1 name=button1>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<% If Sect=0 Then %>
							<input type=button value="���� �����ϱ�" onclick="if(confirm('<%=bTitle%>������ �Ͻðڽ��ϱ�?')){MovePage('','Cash_Prc.asp','CHECKCASHIN','',frms);}" id=button1 name=button1>
							<% Else %>
							<input type=button value="���� ȯ���ϱ�" onclick="if(confirm('<%=bTitle%>������ �Ͻðڽ��ϱ�?')){MovePage('','Cash_Prc.asp','CHECKCASHOUT','',frms);}" id=button1 name=button1>
							<% End If %>
						</td>
					</tr>
				</TABLE>			
			</td>
		</tr>
	</table>
</body>
</html>
	