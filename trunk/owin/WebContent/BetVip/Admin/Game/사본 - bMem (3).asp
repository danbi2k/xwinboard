
<!--	#include virtual="/Admin/top.asp"					-->
<!--	#include virtual=/common/asp/RecordPasing.asp		-->

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

If Sect =0 Then tit = "����������" Else tit = "����Ϸ�" End If

If Flag="MODIFY" Then
	SQL = "UPDATE BetGame_TB Set rMoney="& reInt(replace(Request("rMoney"),",",""),0) &", ResuFlag="& Request("ResuFlag") &" WHERE gCnt='"& Request("gGcnt") &"'"
'	SQL = "UPDATE BetGame_TB Set rMoney="& reInt(Request("rMoney"),0) &", ResuFlag="& Request("ResuFlag") &" WHERE Idx='"& Request("cIdx") &"'"
'	Response.Write SQL
'	Response.End
	RunSQL(SQL)
	Call MileageChange(Request("Id"), reInt(replace(Request("rMoney"),",",""),0), "2")
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
SQL = "SELECT DISTINCT gCnt FROM BetGame_TB WHERE ResuFlag='"& Sect &"' "
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
If(isNone(strSort) Or strSort="Desc") Then strSort="Asc" Else strSort="Desc": '//���Ĺ�� ���� ����
%>

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
	}		function UpdateGoldhit() {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["SortColumn"]	= '<%=SortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["ScFlag"]		= '<%=ScFlag%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["flag"]		= 'HITUPDATE';
		action(frmsgod,'bMem_Prc.asp');
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
						<td><font color="#ffffff" size="4"><b>[<%=tit%> ����]</b></font></td>
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
											<option value="Id">���̵�</option>
										</select>
										&nbsp;&nbsp;&nbsp;
										<input type=text name=KeyWord>
									</td>
									<td rowspan=2>
										<input type=submit value="�� ��" id=submit1 name=submit1>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=red>���߱ݾ��� ���ڸ� �Է��� �ּ���</font>
									</td>
							</table>
						</td>
					</tr>
					
					</form>
				</table>
			</td>
		</tr>
		<tr>
			<td>
<%
				If rsCount = -1 Then
						Response.Write "<tr><td height=100 align=center colspan=20 bgcolor=FFFFFF>��ϵ� �ڷᰡ �����ϴ�.</td></tr>"
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
									<td width="90">���̵�</td>
									<td width="135">�����Ͻ�</td>
									<td width="135">��⳯¥</td>
									<td width="80">����</td>
									
									<td width="160">��(Ȩ��)</td>
									<td width="75">��/�ڵ�ĸ</td>
									
									<td width="160">��(������)</td>
									<td width="50">������</td>
									<td width="75">�����</td>
									<td width="230">��������</td>
									<!--<td width="100">���ñݾ�</td>
									<td width="60">����</td>-->
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
									<td ><nobr><%If objRs("Sect")=5 Then %>��&nbsp;<%=IfElse(objRs("HcapAllotl"),"0.00")%><%Else%><%=objRs("hCap")%><%End If %></td>
									<td align=left><nobr>&nbsp;<%=objRs("vAllot")%>&nbsp;<%=objRs("vTname")%></td>
									<td ><nobr><%If objRs("gbTem")=1 Then %>Ȩ��<%ElseIf objRs("gbTem")=2 Then%>������<%Else%>��<%End If%></td>
									<td ><nobr><%=objRs("rtel")%></td>
									<td ><nobr><input type="radio" name="goldhit_<%=objRs("Idx")%>" value=0 onclick="MovePage('<%=objRs("Idx")%>','','GOLD','0','');" <%=gSelection(objRs("goldhit"),0,"checked")%>>�����&nbsp;<input type="radio" name="goldhit_<%=objRs("Idx")%>" value=2 onclick="MovePage('<%=objRs("Idx")%>','','GOLD','2','');" <%=gSelection(objRs("goldhit"),2,"checked")%>>������&nbsp;<input type="radio" name="goldhit_<%=objRs("Idx")%>" value=1 onclick="MovePage('<%=objRs("Idx")%>','','GOLD','1','');" <%=gSelection(objRs("goldhit"),1,"checked")%>>����</td>
									
									<!--<td align="right"><%=formatnumber(objRs("bMoney"),[])%>&nbsp;</td>
									<td ><input type=button value="����" onclick="if(confirm('�����Ͻðڽ��ϱ�?')) { MovePage('<%=objRs("Idx")%>','bMem_Prc.asp','DELETE','',''); }" ></td>-->
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

										AllAllot	=  left(AllAllot,4)

										AllhMoney = Int(AllAllot*betmoney)

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
						����� : <%=formatnumber(AllAllot,2)%> / ���ñݾ� : <%=formatnumber(betmoney,[])%> / �������߱ݾ� : <%=formatnumber(AllhMoney,[])%> / ���߱ݾ� : <input type=text name="rMoney" value="<%=AllrbMoney%>" OnKeydown="onlyNumber();" size=10>
									</td>
									<td>
										<input type=radio name=ResuFlag value=0 <%=gSelection(ResuFlag,0,"checked")%>>������
										<input type=radio name=ResuFlag value=1 <%=gSelection(ResuFlag,1,"checked")%>>�Ϸ�
									</td>
									<td ><input type=submit value="����" id=submit2 name=submit2></td>
									<!--
									<td>
										<input type=button value="��������" onclick="MM_winopen('CashCh.asp?Id=<%=Id%>&Idx=<%=IntIdx%>','CA','width=400,height=300');" id=button1 name=button1>
									</td>
									-->
									<td>
										<input type=button value="����" onclick="if(confirm('�����Ͻðڽ��ϱ�?')) { MovePage('<%=ThisGcnt%>','bMem_Prc.asp','DELETE','',''); }"  id=button2 name=button2>
									</td>
									
						<%Else%>			
						
									<td>����� : <%=formatnumber(AllAllot,2)%> / ���ñݾ� : <%=formatnumber(betmoney,[])%> / �������߱ݾ� : <%=formatnumber(AllhMoney,[])%> / ���߱ݾ� : <%=formatnumber(reInt(AllrbMoney,0),[])%></td>
									<td>
										<input type=radio name=ResuFlag value=0 <%=gSelection(ResuFlag,0,"checked")%>>������
										<input type=radio name=ResuFlag value=1 <%=gSelection(ResuFlag,1,"checked")%>>�Ϸ�
									</td>
									<td ><input type=submit value="����" id=submit2 name=submit2></td>
									<td>
										<input type=button value="����" onclick="if(confirm('�����Ͻðڽ��ϱ�?')) { MovePage('<%=ThisGcnt%>','bMem_Prc.asp','DELETE','',''); }"  id=button2 name=button2>
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
		<form name=frmsgod>
		<input type=hidden name=goldhits>
		
		</form>		<tr><td align=center><input type=button value="�������� �ϰ�����" onclick="UpdateGoldhit();"></td></tr>
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
	