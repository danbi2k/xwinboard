<!--	#include virtual=/common/asp/top.asp	-->
<!--	#include virtual=/common/asp/Oops.asp	-->
<%
	KD1	= Request("KD1")
	f_date	= Request("f_date")
	t_date	= Request("t_date")
	Sect	= Request("Sect")
	If Not isDate(f_date) Then f_date	= Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2)
	If Not isDate(t_date) Then t_date	= Year(Now())&"-"&right("0"&Month(Now()),2)&"-"&right("0"&Day(Now()),2)
	
	Orderby = " Order By convert(varchar(16),gsDate,120 ) DESC "
	SQL = "SELECT Idx, gName, convert(varchar(16),gsDate,120 ) As gsDat, League,  "
	SQL = SQL &" hTname, hAllot, hCap, HcapAllotl, vTname, vAllot, rtel, hcont, vcont "
	SQL = SQL &" FROM Game_TB WHERE Status=2 "
	If Not isNone(f_date) And Not isNone(t_date) Then SQL = SQL &" And convert(varchar(10),WriteDay,120 ) BETWEEN convert(varchar(10),'"& f_date &"',120 ) And convert(varchar(10),'"& t_date &"',120 ) "
	If Not isNone(KD1) Then SQL = SQL &" And League='"& KD1 &"'"
	If Not isNone(Sect) Then SQL = SQL &" And Sect='"& Sect &"'"
	SQL = SQL & Orderby
'	Response.Write SQL
	Set objRs = RunSQLReturnRs(SQL)
%>
<script language='javascript' src=/common/js/Calendar.js></script>
<script language='javascript' >
	function seArch() {
		location.href = window.location.pathname+'?f_date='+document.all.f_date.value+'&t_date='+document.all.t_date.value+'&Sect='+document.all.Sect.value+'&KD1='+document.all.KD1.value;
	}
</script>	
	<tr>
        <td >
            <table border="0" cellpadding="0" cellspacing="0" width=100%>
                <tr>
                    <td width=40 >&nbsp;</td>
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
															<table border="0" cellpadding="3" cellspacing="2" width=98%>
																<tr><td height=10></td></tr>
																<tr>
																    <td ><img src=/images/title_closelist.gif  ></td>
																</tr>
																<tr><td height=10></td></tr>
																<tr>
																	<td >
																		<table border="0" cellpadding="0" cellspacing="0" width=98%>
																			<tr>
																				<td >
																					<b>*경기선택 : </b>
																					<select name=Sect class=select1>
																						<option value="">전체</option>
																						<option <%=gSelection(Sect,5,"selected")%> value="5">승무패</option>
																						<option <%=gSelection(Sect,1,"selected")%> value="1">야구(핸디)</option>
																						<option <%=gSelection(Sect,2,"selected")%> value="2">축구(핸디)</option>
																						<option <%=gSelection(Sect,3,"selected")%> value="3">농구(핸디)</option>																						<option <%=gSelection(Sect,6,"selected")%> value="6">기타(핸디)</option>
																					</select >
																	&nbsp;&nbsp;
																	<b>*리그선택 : </b>
																	<%
																		Set Rss = RunSQLReturnRs("SELECT DISTINCT League FROM Leag_TB Order By League DESC")
																	%>
																					<select name=KD1 class=select1>
																						<option value="">전체</option>
																						<%
																							If Not Rss.EOF Then
																								Do Until Rss.EOF
																						%>
																						<option <%=gSelection(KD1,Rss("League"),"selected")%> value="<%=Rss("League")%>"><%=Rss("League")%></option>
																						<%
																								Rss.MoveNext
																								Loop
																							End If
																						%>
																					</select >
																	&nbsp;&nbsp;<b>*기간선택 : </b>
<input type="text" name="f_date" size="10" value="<%=f_date%>" maxlength="10" class="input14" onchange="ValidateDatetime(this.form, this.name);"> 
<a href="javascript:Calendar_D(f_date); "><img src="/images/ico_cal.gif" align=absmiddle border="0"></a>
~
<input type="text" name="t_date" size="10" value="<%=t_date%>" maxlength="10" class="input14" onchange="ValidateDatetime(this.form, this.name);"> 
<a href="javascript:Calendar_D(t_date); "><img src="/images/ico_cal.gif" align=absmiddle border="0"></a>
<input type=button value="검색" onclick="seArch();" class="btn8"  id=button1 name=button1>
																				</td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr>
																    <td >
																		<table border=0 width=100% cellpadding=3 cellspacing=0 >
																			<tr>
																				<td >
																					<table width=100% border=0 cellpadding=0 cellspacing=1 bgcolor=424142>
																						<tr bgcolor=212021 height=27>
																							<td  width=270 align=center ><nobr><font color=FFFFFF><b>경기일시</td>
																							<td  width=100 align=center ><nobr><font color=FFFFFF><b>리 그</td>
																							<td  width=550 align=center ><nobr><font color=FFFFFF><b>(승)홈 팀</td>
																							<td  width=130 align=center ><nobr><font color=FFFFFF><b>무/핸디캡</td>
																							<td  width=550 align=center ><nobr><font color=FFFFFF><b>(패)원정팀</td>
																							<td  width=80 align=center ><nobr><font color=FFFFFF><b>상태</td>
																							<td  width=130 align=center ><nobr><font color=FFFFFF><b>경기결과</td>
																						</tr>
																						<%
																						If Not objRs.EOF Then
																							Do Until objRs.EOF
%>																						
																						<tr height=25 bgcolor=000000>
																							<td align=center  ><nobr><%=objRs("gsDat")%></td>
																							<td align=center ><nobr><%=objRs("League")%></td>
																							<td align=right >
																								<table border=0 width=100% cellpadding=1 cellspacing=0 bgcolor=424142>
																									<tr>
																										<td align=right width=100%><nobr><%=objRs("hTname")%></td>
																										<td align=right width=30>&nbsp;<%=objRs("hAllot")%>&nbsp;</td>
																										<td align=right width=10><img width=22 height=14 src="/flag/<%=right("0"&objRs("hcont"),2)%>.gif" align=absmiddle>
																										</td>
																									</tr>
																								</table>
																							</td>
																							<td align=center align=center><nobr>
																								<table border=0 width=100% cellpadding=1 cellspacing=0 bgcolor=424142>
																									<tr>
																										<td align=center ><nobr><% If isNone(objRs("hCap")) Then %> <%=IfElse(objRs("HcapAllotl"),"0.00")%><%Else%><%=IfElse(objRs("hCap"),"0.00")%><%End If %></td>
																										
																									</tr>
																								</table>
																							</td>
																							<td align=left >
																								<table border=0 width=100% cellpadding=1 cellspacing=0 bgcolor=424142>
																									<tr>
																										<td width=20><nobr><img width=22 height=14 src="/flag/<%=right("0"&objRs("vcont"),2)%>.gif" align=absmiddle></td>
																										<td width=30>&nbsp;<%=objRs("vAllot")%>&nbsp;</td>
																										<td ><nobr><%=objRs("vTname")%></td>
																										
																									</tr>
																								</table>
																							</td>
																							<td align=center ><nobr>마감</td>
																							<td align=center ><nobr><%=objRs("rtel")%></td>
																						</tr>
<%
																							objRs.MoveNext
																							Loop
																						End If
%>	
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
												</table>
														</td>
													</tr>
												</table>
								
											</td>
										</tr>
<!--	#include virtual=/common/asp/bottom.asp	-->										