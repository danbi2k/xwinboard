<!--	#include virtual=/common/asp/top.asp	-->
<!--	#include virtual=/common/asp/Oops.asp	-->
<!--	#include virtual="/common/asp/RecordPasing.asp"		-->
<script language='javascript' src=/common/js/Calendar.js></script>
<%
'If Request("flag") = 1 Then
	f_date	= Request("f_date")
	t_date	= Request("t_date")
	
	If Not isDate(f_date) Then f_date	= Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2)
	If Not isDate(t_date) Then t_date	= Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2)
	Sect	= Request("Sect")
'End If

KeyField		= Request("KeyField")
KeyWord			= Request("KeyWord")
strSortColumn	= Request("SortColumn")
strSort			= Request("Sort")

pageSize = 10
CurPage		= reInt(Request("CurPage"),1)
goPage		= Request("goPage")
CurBlock	= Trim(Request("CurBlock"))
order = " Order by gCnt DESC "

If Request("flag") = "DELETE" Then
	RunSQL("UPDATE BetGame_TB Set UHiden=1 WHERE gCnt='"& Request("Idx") &"' And Id='"& Session("UId") &"'")
	Call Descment("","MybetList.asp?CurPage="& CurPage &"&CurBlock="& CurBlock &"&KeyField="& KeyField &"&KeyWord="& KeyWord &"&f_date="& f_date &"&t_date="& t_date,"")
End If
SQL = "SELECT DISTINCT gCnt FROM BetGame_TB WHERE Id='"& Session("UId") &"' And UHiden=0 "
If Not isNone(Sect) Then
	If Sect=5 Then 
		SQL = SQL &" And Sect =5 "
	Else
		SQL = SQL &" And ( Sect =1 or Sect =2 or Sect =3 or Sect =4) "
	End If
End If
If Not isNone(f_date) And Not isNone(t_date) Then SQL = SQL &" And convert(varchar(10),WriteDay,120 ) BETWEEN convert(varchar(10),'"& f_date &"',120 ) And convert(varchar(10),'"& t_date &"',120 ) "
SQL = SQL & order
'Response.Write sql &"<br>"
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
If(strSort="" Or strSort="Desc") Then strSort="Asc" Else strSort="Desc": '//���Ĺ�� ���� ����

%>
<script language='javascript' src=/common/js/goList.js></script>
<script language='javascript'>
	function ReSortList(SortColumn,Sort) {
		getQuery["CurPage"]		= '<%=CurPage%>';	
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["TableName"]	= '<%=TableName%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["Sort"]		= Sort;
		getQuery["SortColumn"]	= SortColumn;
		action();
	}	

	function MovePage(gId, goP, goF, gSe) {
		getQuery["CurPage"]		= '<%=CurPage%>';
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["TableName"]	= '<%=TableName%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["SortColumn"]	= '<%=strSortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["f_date"]		= '<%=f_date%>';
		getQuery["t_date"]		= '<%=t_date%>';
		getQuery["Idx"]			= gId;
		getQuery["flag"]		= goF;
		action('',goP);
	}
	
	function ListPageGo(PageIndex) {
		getQuery["CurPage"]		= PageIndex;
		getQuery["CurBlock"]	= '<%=CurBlock%>';
		getQuery["TableName"]	= '<%=TableName%>';
		getQuery["KeyField"]	= '<%=KeyField%>';
		getQuery["KeyWord"]		= '<%=KeyWord%>';
		getQuery["SortColumn"]	= '<%=strSortColumn%>';
		getQuery["Sort"]		= '<%=strSort%>';
		getQuery["Sect"]		= '<%=Sect%>';
		getQuery["f_date"]		= '<%=f_date%>';
		getQuery["t_date"]		= '<%=t_date%>';
		action();
	}
	
	function seArch() {
		location.href = window.location.pathname+'?f_date='+document.all.f_date.value+'&t_date='+document.all.t_date.value+'&Sect='+document.all.Sect.value+'&flag=1';
	}
</script>  
	<tr>
        <td >
            <table border="0" cellpadding="0" cellspacing="0" width=100%>
                <tr>
                    <td width=40 ></td>
					<td valign=top >
						<table border="0" cellpadding="0" cellspacing="0" >
							
							<tr>
								<td  >
									<table width=980 border="0" cellpadding="0" cellspacing="0" >
										<tr>
											<td valign=top >
												<table border="0" cellpadding="0" cellspacing="0" height=750>
													<tr>
														<td valign=top>
															<table border="0" cellpadding="0" cellspacing="0" width=950>
																<tr><td height=20></td></tr>
																<tr><td ><img src=/images/title01.gif ></td></tr>
																<tr><td height=10></td></tr>
																<tr>
																	<td>
																		
																		<table border=0 width=100% cellpadding=5 cellspacing=5 bgcolor=212021>
																			
																			<tr bgcolor=000000>
																				<td style="padding-top:7pt;padding-bottom:7pt">
																				<b>*��⼱�� : </b>
																					<select name=Sect class=select1>
																						<option value="">��ü</option>
																						<option <%=gSelection(Sect,5,"selected")%> value="5">�¹���</option>
																						<option <%=gSelection(Sect,1,"selected")%> value="1">�߱�(�ڵ�)</option>
																						<option <%=gSelection(Sect,2,"selected")%> value="2">�౸(�ڵ�)</option>
																						<option <%=gSelection(Sect,3,"selected")%> value="3">��(�ڵ�)</option>
																						<option <%=gSelection(Sect,6,"selected")%> value="6">��Ÿ(�ڵ�)</option>
																					</select >
																	&nbsp;&nbsp;<b>*�Ⱓ���� : </b>
											
<input type="text" name="f_date" size="10" value="<%=IfElse(f_date,Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2))%>" maxlength="10" class="input14" onchange="ValidateDatetime(this.form, this.name);"> 
<a href="javascript:Calendar_D(f_date); "><img src="/images/ico_cal.gif" align=absmiddle border="0"></a>
~
<input type="text" name="t_date" size="10" value="<%=IfElse(t_date,Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2))%>" maxlength="10" class="input14" onchange="ValidateDatetime(this.form, this.name);"> 
<a href="javascript:Calendar_D(t_date); "><img src="/images/ico_cal.gif" align=absmiddle border="0"></a>
<input type=button value="�˻�" onclick="seArch();" class="btn8" >
																				</td>
																			</tr>
																			
																		</table>
																		<br>
																	</td>
																</tr>
																<tr>
																    <td >
																		<table border=0 width=100% cellpadding=0 cellspacing=0 >
<%
																
				If rsCount = -1 Then
						
				Else
				    Dim count : count = 0
				    Do Until objRs.EOF Or count >= pageSize
				    																
																	
																	AllbMoney	= 0
																	AllrbMoney	= 0
																	AllAllot	= 0
																	AllhMoney	= 0
																	
																	order = " ORDER BY Idx DESC"
																	SQL = "SELECT gName, Sect, convert(varchar(16),gsDate,120 ) As gsDat, hTname, hAllot, hCap, "
																	SQL = SQL &" HcapAllotl, vTname, vAllot, gbTem, convert(varchar(16),WriteDay,120 ) As WriteDay, "
																	SQL = SQL &" bMoney, ResuFlag, rMoney, goldhit, rtel, event, hcont "
																	'SQL = SQL &" FROM BetGame_TB b, Game_TB g WHERE g.Status=0 And g.Idx=b.gIdx And b.Id='"& Session("UId") &"' "
																	SQL = SQL &" FROM BetGame_TB WHERE gCnt='"& objRs(0) &"' And Id='"& Session("UId") &"' "
																	If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" AND "& KeyField &" LIKE '%"& KeyWord &"%'"
																	SQL = SQL & order
'																	Response.Write sql &"<br>"
																	Set Rss = RunSQLReturnRs(SQL)
%>																		
																			<tr>
																				<td >
																		
																					<table border=0 width=100% cellpadding=0 cellspacing=0 >
																						<tr>
																							<td >
																								<table width=100% border=0 cellpadding=0 cellspacing=1 bgcolor=424142>
																									<tr bgcolor=212021 height=27>
																										<td  width=120 align=center ><font color=FFFFFF><b><nobr>�����Ͻ�</td>
																										<td  width=60 align=center ><font color=FFFFFF><b><nobr>����</td>
																										<td  width=120 align=center ><font color=FFFFFF><b><nobr>��⳯¥</td>
																										<td  width=300 align=center ><font color=FFFFFF><b><nobr>(��)Ȩ ��</td>
																										<td  width=85 align=center ><font color=FFFFFF><b><nobr>��/�ڵ�ĸ</td>
																										
																										<td  width=300 align=center ><font color=FFFFFF><b><nobr>(��)������</td>
																										<td  width=60 align=center ><font color=FFFFFF><b><nobr>������</td>
																										<td  width=95 align=center ><font color=FFFFFF><b><nobr>�����</td>
																										<td  width=80 align=center ><font color=FFFFFF><b><nobr>��������</td>
																										
																									</tr>
			<%
																									If Not (Rss.EOF or Rss.BOF) Then
																									    Do Until Rss.EOF
																									    If Rss("goldhit")=1 Then fcolor = "FFC602" Else fcolor = "FFFFFF" End If
			%>																						
																									<tr bgcolor=000000 height=25>
																										<td align=center  ><nobr><font color=<%=fcolor%>><%=Rss("WriteDay")%></td>
																										<td align=center><nobr><font color=<%=fcolor%>><%=Rss("gName")%></td>
																										<td align=center ><nobr><font color=<%=fcolor%>><%=Rss("gsDat")%></td>
																										<td align=right><nobr>
																											<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
																												<tr>
																													<td align=center width=60><nobr>&nbsp;<% If Rss("event")=1 Then %><img src=/images/icon_event.gif align=absmiddle hspace=1 ><% End If %></td>
																													<td align=right width=90%><nobr>
																														<font color=<%=fcolor%>><%=Rss("hTname")%>&nbsp;
																													</td>
																													<td width=10><%=Rss("hAllot")%>&nbsp;</td>
																												</tr>
																											</table>
																										</td>
																										<td align=center><nobr>
																											<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
																												<tr>
																													<td height=18 align=center><font color=<%=fcolor%>><%If Rss("Sect")=5 Then %>��&nbsp;<%=IfElse(Rss("HcapAllotl"),"0.00")%><%Else%><%=Rss("hCap")%><%End If %></td>
																												</tr>
																											</table>
																											
																										</td>
																										
																										<td ><nobr>
																											<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
																												<tr>
																													
																													<td width=30><font color=<%=fcolor%>><%=Rss("vAllot")%></td>
																													<td><nobr>&nbsp;<%=Rss("vTname")%></td>
																												</tr>
																											</table>
																										</td>
																										<td align=center ><nobr><font color=<%=fcolor%>><%If Rss("gbTem")=1 Then %>Ȩ��<%ElseIf Rss("gbTem")=2 Then%>������<%Else%>��<%End If%></td>
																										<td ><nobr>&nbsp;<font color=<%=fcolor%>><%=Rss("rtel")%></td>
																										<td align=center ><nobr><font color=<%=fcolor%>><%If Rss("goldhit")=0 Then%>�����<%ElseIf Rss("goldhit")=2 Then%>������<%Else%>����<%End If%></td>
																										
																									</tr>
<%
																										
																										AllbMoney	= AllbMoney+reInt(Rss("bMoney"),0)
																										AllrbMoney	= reInt(Rss("rMoney"),0)
																										betmoney	= Rss("bMoney")
																										ThisGcnt	= objRs(0)
																										
																										DelFlag = 1
																										If Rss("ResuFlag")=0 Then DelFlag = 0
																										
																									   Rss.MoveNext
																									   Loop
																									   AllAllot		= getToAlot(ThisGcnt)
																									   AllhMoney	= Int(AllAllot*betmoney)
																									End IF
%>																									
																								</table>		
																							</td>
																						</tr>
																						<tr><td height=3></td></tr>
																						<tr>
																							<td align=center >
																								����� : <%=formatnumber(AllAllot,2)%> / ���ñݾ� : <%=formatnumber(betmoney,[])%> / �������߱ݾ� : <%=formatnumber(AllhMoney,[])%> / ���߱ݾ� : <% If AllrbMoney<>0 Then %><font color=FFC602><b><%End If%> <%=formatnumber(AllrbMoney,[])%> ��
																								<% If DelFlag=1 Then %> <input type=button value="����" class=btn2 onclick="if(confirm('���� �Ͻðڽ��ϱ�?')) {MovePage('<%=objRs(0)%>','MybetList.asp','DELETE','');}"><%End If %>
																							</td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																			<tr><td height=10></td></tr>
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
																	<td height=50 align=center>
																		<%=getPrintPagingBoard(pageSize, CurPage, rsCount)%>													
																	</td>
																</tr>																					
															</table>
														
														</td>
													</tr>
												
												</table>
								
											</td>
										</tr>
									</table>
												
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
<!--	#include virtual=/common/asp/bottom.asp	-->										