<!--	#include virtual=/common/asp/top.asp	-->
<!--	#include virtual=/common/asp/Oops.asp	-->


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
                    <td width=194 bgcolor=#5A1010 >
	                    <!--	#include virtual=/common/asp/left.asp	-->
                    </td>
					<td valign=top >
						<table border="0" cellpadding="0" cellspacing="0" >
							
							<tr>
								<td  >
									<table border="0" cellpadding="0" cellspacing="0" >
										<tr>
											<td valign=top style="padding-left:5pt">
												<table border="0" cellpadding="0" cellspacing="0" height=750>
													<tr>
														<td valign=top>
															<table border="0" cellpadding="0" cellspacing="0" width=950>
																<tr>
																    <td height=42 width=750 background=/images/title01.gif style="background-repeat:no-repeat" style="background-repeat:no-repeat"></td>
																</tr>
																<tr>
																    <td >
																		<table border=0 width=100% cellpadding=0 cellspacing=0 >
<%
																SQL = "SELECT DISTINCT gCnt FROM BetGame_TB WHERE Id='"& Session("UId") &"'"
'																SQL = SQL &" Order By Idx DESC "
'																Response.Write sql &"<br>"
																Set Rss = RunSQLReturnRs(SQL)
																If Not Rss.EOF or Not Rss.BOF Then
																	Do Until Rss.EOF
																	
																	
																	
																	order = " ORDER BY b.Idx DESC"
																	SQL = "SELECT b.gName, convert(varchar(16),b.gsDate,120 ) As gsDat, b.hTname, b.hAllot, b.hCap, "
																	SQL = SQL &" b.HcapAllotl, b.vTname, b.vAllot, b.gbTem, b.WriteDay, b.bMoney, b.ResuFlag, b.rMoney, g.rtel "
																	'SQL = SQL &" FROM BetGame_TB b, Game_TB g WHERE g.Status=0 And g.Idx=b.gIdx And b.Id='"& Session("UId") &"' "
																	SQL = SQL &" FROM BetGame_TB b, Game_TB g WHERE g.Idx=b.gIdx And b.gCnt='"& Rss(0) &"' And b.Id='"& Session("UId") &"' "
																	If Not isNone(KeyField) And Not isNone(KeyWord) Then SQL = SQL &" AND "& KeyField &" LIKE '%"& KeyWord &"%'"
																	SQL = SQL & order
'																	Response.Write sql &"<br>"
																	Set objRs = RunSQLReturnRs(SQL)
%>																		
																			<tr>
																				<td >
																		
																		
																		
																					<table border=0 width=100% cellpadding=1 cellspacing=0 bgcolor=D6C5AD>
																						<tr>
																							<td >
																								<table width=100% border=0 cellpadding=3 cellspacing=1 bgcolor=D6C5AD>
																									<tr bgcolor=DE6B8C >
																										<td  width=125 align=center ><font color=FFFFFF><b>베팅일시</td>
																										<td  width=90 align=center ><font color=FFFFFF><b>종목</td>
																										<td  width=55 align=center ><font color=FFFFFF><b>경기날짜</td>
																										<td  width=27 align=center ><font color=FFFFFF><b>시간</td>
																										<td  width=110 align=center ><font color=FFFFFF><b>(승)홈 팀</td>
																										<td  width=80 align=center ><font color=FFFFFF><b>핸드캡</td>
																										<td  width=70 align=center ><font color=FFFFFF><b>배당율</td>
																										
																										
																										<td  width=130 align=center ><font color=FFFFFF><b>패(원정팀)</td>
																										<td  width=80 align=center ><font color=FFFFFF><b>핸드캡</td>
																										<td  width=70 align=center ><font color=FFFFFF><b>배당율</td>
																										<td  width=80 align=center ><font color=FFFFFF><b>배팅팀</td>
																										<td  width=95 align=center ><font color=FFFFFF><b>경기결과</td>
																										<td  width=100 align=center ><font color=FFFFFF><b>베팅금액</td>
																										<td  width=65 align=center ><font color=FFFFFF><b>정산</td>
																										<td  width=100 align=center ><font color=FFFFFF><b>정산금액</td>
																									</tr>
			<%
																									If Not (objRs.EOF or objRs.BOF) Then
																									    Do Until objRs.EOF
			%>																						
																									<tr>
																										<td align=center bgcolor=FFFFF7 ><%=right("0"&DatePart("m",objRs("WriteDay")),2)%>-<%=right("0"&DatePart("d",objRs("WriteDay")),2)%> (<%=DatePart("h",objRs("WriteDay"))%>:<%=right("0"&DatePart("n",objRs("WriteDay")),2)%>)</td>
																										<td bgcolor=FFFFF7 ><%=objRs("gName")%></td>
																										<td align=center bgcolor=FFFFF7 ><%=DateViewLen(objRs("gsDat"),".",10)%></td>
																										<td align=center bgcolor=FFFFF7 ><%=right(objRs("gsDat"),5)%></td>
																										<td bgcolor=FFFFF7 ><%=objRs("hTname")%></td>
																										<td bgcolor=FFFFF7 >-<%=objRs("hCap")%></td>
																										<td bgcolor=FFFFF7 ><%=objRs("hAllot")%></td>
																										<td bgcolor=FFFFF7 ><%=objRs("vTname")%></td>
																										<td bgcolor=FFFFF7 ><%=objRs("hCap")%></td>
																										<td bgcolor=FFFFF7 ><%=objRs("vAllot")%></td>
																										<td align=center bgcolor=FFFFF7 ><%If objRs("gbTem")=1 Then %>홈팀<%Else%>원정팀<%End If%></td>
																										<td bgcolor=FFFFF7 ><%=objRs("rtel")%></td>
																										<td bgcolor=FFFFF7 ><%=formatnumber(objRs("bMoney"),[])%></td>
																										<td align=center bgcolor=FFFFF7 ><%If objRs("ResuFlag")=1 Then%>완료<%Else%>정산중<%End If%></td>
																										<td bgcolor=FFFFF7 ><%=formatnumber(reInt(objRs("rMoney"),0),[])%></td>
																									</tr>
<%
																									   objRs.MoveNext
																									   Loop
																									End IF
%>																									
																								</table>		
																							</td>
																						</tr>
																						<tr>
																							<td>dfdf</td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																			<tr><td height=10></td></tr>
																			
																			
<%
																		       Rss.MoveNext
																			   Loop
																			End IF
%>																																
																		</table>
																																				
																    </td>
																																
															</table>
														
														</td>
													</tr>
												</table>
								
											</td>
										</tr>
<!--	#include virtual=/common/asp/bottom.asp	-->										