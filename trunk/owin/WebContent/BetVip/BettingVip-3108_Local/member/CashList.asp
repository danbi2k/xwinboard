<!--	#include virtual=/common/asp/top.asp	-->
<!--	#include virtual=/common/asp/Oops.asp	-->
<!--	#include virtual="/common/asp/RecordPasing.asp"		-->

<%
KeyField		= Request("KeyField")
KeyWord			= Request("KeyWord")
strSortColumn	= Request("SortColumn")
strSort			= Request("Sort")

pageSize = 20
CurPage		= reInt(Request("CurPage"),1)
goPage		= Request("goPage")
CurBlock	= Trim(Request("CurBlock"))
order = " ORDER BY Idx DESC"

SQL = "SELECT * FROM Cash_TB WHERE Type=0 And Id='"& Session("UId") &"' And Visbled=0 "
If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" AND "& KeyField &" LIKE '%"& KeyWord &"%'"
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
		action();
	}
</script>  

	<tr>
        <td >
            <table border="0" cellpadding="0" cellspacing="0" width=100%>
                <tr>
                    <td width=40 >&nbsp;</td>
					<td valign=top height=570>
						<table width=100% border="0" cellpadding="0" cellspacing="0" >
							
							<tr>
								<td  >
									<table width=100% border="0" cellpadding="0" cellspacing="0" >
										<tr>
											<td valign=top >
												<table width=100% border="0" cellpadding="0" cellspacing="0" >
													<tr>
														<td valign=top>
															<table border="0" cellpadding="0" cellspacing="0" width=99%>
																<tr><td height=10></td></tr>
																<tr>
																    <td ><img src=/images/title_cashlist.gif ></td>
																</tr>
																<tr><td height=10></td></tr>
																<tr>
																	<td>
																		<table border="0" cellpadding="0" cellspacing="0" >
																			<tr>
																				<td><input type=button class="btn13" value="ĳ��ȯ�� ��û" onclick="location.href='Cash.asp';" id=button1 name=button1>&nbsp;</td>
																				<td><input type=button class="btn11" value="ĳ��ȯ�� ����"  id=button2 name=button2></td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr>
																    <td >
																		
																		
																		<table width="99%" cellpadding="0" cellspacing="0" border="0" >
																			<tr>
																				<td >
																					<table width="100%" border="0" cellspacing="0" cellpadding="0">
																						<tr><td height=1 bgcolor=424142 colspan=10></td></tr>
																						<tr align="center" height="30" bgcolor=212021> 
																							<td width="80" ><font color=FFFFFF><b>��ȣ</td>
																							<td width="200"><font color=FFFFFF><b>�����ݾ�</td>
																							<td width="200" ><font color=FFFFFF><b>�Ա��ڸ�</td>
																							<td width="200" ><font color=FFFFFF><b>������¥</td>
																							<td width="80" ><font color=FFFFFF><b>����</td>
																						</tr>
																						<tr><td height=1 bgcolor=000000 colspan=10></td></tr>
																						<tr><td height=1 bgcolor=424142 colspan=10></td></tr>
																									
																					</table>
																					
																					
																				</td>
																			</tr>
																			<tr>
																				<td >
																					<table width="100%" cellpadding="4" cellspacing="1" border="0" >
<%
																						If objRs.EOF or objRs.BOF Then
																							Response.Write "<tr><td height=500 align=center colspan=20 >��ϵ� �ڷᰡ �����ϴ�.</td></tr>"
																						Else
																						    Dim count : count = 0
																						    Do Until objRs.EOF Or count >= pageSize
																							Set obj = RunSQLReturnRs("SELECT Count(Idx) FROM BetGame_TB" )
%>																					
																						<tr height=27 align=center bgcolor=212021>
																							<td width=80><%=gSeq%></td>
																							<td align=right width=200><%=formatnumber(objRs("RCash"),[])%>&nbsp;</td>
																							<td width=200>&nbsp;<%=objRs("Depos")%></td>
																							<td align=center width=200>&nbsp;<%=DateViewLen(objRs("InDay"),"-",10)%></td>
																							<td align=center width=80> <%If objRs("Status")=1 Then %><b><font color=FFC602>�����Ϸ�<%Else%>�������<%End If%></td>
																						</tr>
																						<tr><td height=1 colspan=10 bgcolor=000000></td></tr>
																						<tr><td height=1 colspan=10 bgcolor=313431></td></tr>
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
																		</table>
																    </td>
																</tr>
																<tr>
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
	<tr><td height=20></td></tr>
<!--	#include virtual=/common/asp/bottom.asp	-->										