<!--	#include virtual=/common/asp/top.asp	-->
<!--	#include virtual=/common/asp/Oops.asp	-->
<%
	SQL = "SELECT Idx, gName, convert(varchar(16),gsDate,120 ) As gsDat, League,  "
	SQL = SQL &" hTname, hAllot, hCap, HcapAllotl, vTname, vAllot, rtel, hcont, vcont "
	SQL = SQL &" FROM Game_TB WHERE Status=2 Order By Idx DESC "
	Set objRs = RunSQLReturnRs(SQL)
%>
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
									<table width=850 border="0" cellpadding="0" cellspacing="0" >
										<tr>
											<td valign=top style="padding-left:20pt">
												<table border="0" cellpadding="0" cellspacing="0" height=750>
													<tr>
														<td valign=top>
															<table border="0" cellpadding="3" cellspacing="2" width=100%>
																<tr>
																    <td height=42 width=750 background=/images/howleg_title.gif style="background-repeat:no-repeat"></td>
																</tr>
																<tr>
																    <td >
																		<table border=0 width=100% cellpadding=3 cellspacing=0 bgcolor=D6C5AD>
																			<tr>
																				<td >
																					<table width=100% border=0 cellpadding=3 cellspacing=1 bgcolor=D6C5AD>
																						<tr bgcolor=DE6B8C >
																							<td  width=270 align=center ><nobr><font color=FFFFFF><b>경기일시</td>
																							<td  width=100 align=center ><nobr><font color=FFFFFF><b>리 그</td>
																							<td  width=550 align=center ><nobr><font color=FFFFFF><b>(승)홈 팀</td>
																							<td  width=130 align=center ><nobr><font color=FFFFFF><b>무/핸드캡</td>
																							<td  width=550 align=center ><nobr><font color=FFFFFF><b>패(원정팀)</td>
																							<td  width=80 align=center ><nobr><font color=FFFFFF><b>상태</td>
																							<td  width=130 align=center ><nobr><font color=FFFFFF><b>경기결과</td>
																						</tr>
																						<%
																						If Not objRs.EOF Then
																							Do Until objRs.EOF
%>																						
																						<tr>
																							<td align=center bgcolor=FFFFF7 ><nobr><%=objRs("gsDat")%></td>
																							<td align=center bgcolor=FFFFFF ><nobr><%=objRs("League")%></td>
																							<td align=right bgcolor=FFFFF7 >
																								<table border=0 width=100% cellpadding=0 cellspacing=0>
																									<tr>
																										<td align=right ><nobr><%=objRs("hTname")%>&nbsp;&nbsp;</td>
																										<td align=right width=20><nobr>
																										<%=objRs("hAllot")%>
																										<img width=22 height=14 src="/flag/<%=right("0"&objRs("hcont"),2)%>.gif" align=absmiddle>
																										</td>
																									</tr>
																								</table>
																							</td>
																							<td align=center bgcolor=FFFFF7 align=center><nobr><% If isNone(objRs("hCap")) Then %> <%=IfElse(objRs("HcapAllotl"),"0.00")%><%Else%><%=IfElse(objRs("hCap"),"0.00")%><%End If %></td>
																							<td align=left bgcolor=FFFFFF >
																								<table border=0 width=100% cellpadding=0 cellspacing=0>
																									<tr>
																										<td width=20><nobr>
																										<img width=22 height=14 src="/flag/<%=right("0"&objRs("vcont"),2)%>.gif" align=absmiddle>
																										<%=objRs("vAllot")%>
																										</td>
																										<td ><nobr>&nbsp;&nbsp;<%=objRs("vTname")%>
																										</td>
																										
																									</tr>
																								</table>
																							</td>
																							<td align=center bgcolor=FFFFFF ><nobr>마감</td>
																							<td align=center bgcolor=FFFFFF ><nobr><%=objRs("rtel")%></td>
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
<!--	#include virtual=/common/asp/bottom.asp	-->										