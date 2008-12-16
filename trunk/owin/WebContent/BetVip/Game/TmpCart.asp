<!--	#include virtual=/common/asp/top.asp			-->
<!--	#include virtual=/common/asp/memberClass.asp	-->
<!--	#include virtual=/common/asp/Oops.asp	-->
<script language=javascript src="/js/bet.js"></script>
<script language=javascript src="/js/cart.js"></script>

<script>
var f_coin="<%=UsePoints("", Session("UId"), 2)%>";
var min_bet1="5000";
var min_bet2="5000";
var max_bet1="1000000";
var max_bet2="1000000";
var max_amount1="3000000";
var max_amount2="3000000";
			</script>
<form name="betForm" method="post" action="Bet_Prc.asp">
	<input type="hidden" name="mode" value="betting">
	<input type="hidden" name="betmoney" value="">
	<input type="hidden" name="betcontent" value="">
	<input type="hidden" id="game_type" name="game_type" value="2">
	<input type="hidden" id="Sect" name="Sect" value="<%=Sect%>">
</form>
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
												<table border="0" width=100% cellpadding="0" cellspacing="0" height=750>
													<tr>
														<td valign=top>
															<table border="0" cellpadding="3" cellspacing="2" width=100%>
																<form method="post" name="myform">
																<tr><td height=10></td></tr>
																<tr>
																    <td ><img src=/images/title_dubcart.gif  ></td>
																</tr>
<%
																Sect	= Request("Sect")
																	AllbMoney	= 0
																	AllAllot	= 0
																	AllhMoney	= 0
																		
																	SQL = "SELECT c.Idx, g.gName, convert(varchar(16),g.gsDate,120 ) As gsDat,convert(varchar(16),c.WriteDay,120 ) As WriteDay,"
																	SQL = SQL &"  c.gbTem, g.hTname, g.hAllot, g.hCap, g.HcapAllotl, g.vTname, g.vAllot, g.hcont, g.vcont, "
																	SQL = SQL &" c.HaAllot, c.hMoney, c.bMoney, c.gCnt "
																	SQL = SQL &" FROM Game_TB g, TmpBetCart_TB c WHERE g.Status=1 And c.gIdx=g.Idx And c.Id='"& Session("UId") &"'"
'																		If Not isNone(Sect) Then SQL = SQL &" And Sect='"& Sect &"'"
																	SQL = SQL &" Order By c.Idx DESC "
																	Set objRs = RunSQLReturnRs(SQL)
																	If objRs.EOF or objRs.BOF Then
																		cnt =0 
																	Else
%>																

																<tr>
																	<td>
																	
																	
																	
																		<table border="0" cellpadding="0" cellspacing="0" width=100%>
																			
																			
																			<tr>
																			    <td >
																					<table border=0 width=100% cellpadding=3 cellspacing=0 >
																						<tr>
																							<td >
																								<table width=100% border=0 cellpadding=0 cellspacing=1 bgcolor=424142>
																									<tr bgcolor=212021 height=27>
																										<td  width=220 align=center ><font color=FFFFFF><b>경기일시</td>
																										<td  width=220 align=center ><font color=FFFFFF><b>배팅시간</td>
																										<td  width=550 align=center ><font color=FFFFFF><b>(승)홈 팀</td>
																										<td  width=150 align=center ><font color=FFFFFF><b>핸드캡</td>
																										<td  width=550 align=center ><font color=FFFFFF><b>패(원정팀)</td>
																										<td  width=100 align=center ><font color=FFFFFF><b>배팅팀</td>
																										<td  width=100 align=center ><font color=FFFFFF><b>상태</td>
																									</tr>
			<%

																										Do Until objRs.EOF
			%>																						
																									<tr height=25 bgcolor=000000>
																										<td align=center ><%=objRs("gsDat")%></td>
																										<td align=center ><%=objRs("WriteDay")%></td>
																										
																										<td align=right >
																											<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
																												<tr>
																													<td width=90% align=right><nobr><%=objRs("hTname")%></td>
																													<td width=90% align=right>&nbsp;<%=objRs("hAllot")%>&nbsp;</td>
																													<td width=90% align=right><nobr><img width=22 height=14 src="/flag/<%=right("0"&objRs("hcont"),2)%>.gif" align=absmiddle></td>
																												</tr>
																											</table>
																											
																											
																										</td>
																										<td align=center ><% If isNone(objRs("hCap")) Then %> <%=IfElse(objRs("HcapAllotl"),"0.00")%><%Else%><%=IfElse(objRs("hCap"),"0.00")%><%End If %></td>
																										<td align=left >
																											<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
																												<tr>
																													<td ><img width=22 height=14 src="/flag/<%=right("0"&objRs("vcont"),2)%>.gif" align=absmiddle> </td>
																														<td width=1% >&nbsp;<%=objRs("vAllot")%>&nbsp;</td>
																														<td width=90% ><nobr><%=objRs("vTname")%>&nbsp;</td>
																																
																												</tr>
																											</table>
																											
																										</td>
																										<td align=center ><%If objRs("gbTem")=1 Then%>홈팀<%ElseIf objRs("gbTem")=2 Then%>원정팀<%Else%>무<%End If%></td>
																										<td align=center >대기</td>
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
																										betmoney	= objRs("bMoney")	
																										gCnt = objRs("gCnt")
																											
																										objRs.MoveNext
																										Loop
																										AllAllot	=  left(AllAllot,4)
																										AllhMoney = Int(AllAllot*betmoney)
%>																						
																									
																								</table>		
																								
																							</td>
																						</tr>
																					</table>
																			    </td>
																			</tr>
																			<tr>
																				<td>
																					<table border=0 width=100% cellpadding=5 cellspacing=5 bgcolor=212021>
																			<tr >
																				<td bgcolor=000000>
																								<table border=0 align=center cellpadding=1 cellspacing=2 >
																									<tr  >
																										<td >배당율 : <input type=text name="viewAllAllot" value="<%=formatnumber(AllAllot,2)%>" style="width:35;border:0;background-color:000000;color:FFFFFF" readonly> / 배팅금액 : <input type=text name="viewbetmoney" value="<%=formatnumber(betmoney,[])%>" style="width:60;border:0;background-color:000000;color:FFFFFF" readonly> / 최고 예상적중금액 : <input type=text name="viewAllhMoney" value="<%=formatnumber(AllhMoney,[])%>" style="width:70;border:0;background-color:000000;color:FFFFFF" readonly>  
																											<input type="hidden" id="betmoney" name='betmoney' value='<%=betmoney%>'>
																											<input type="hidden" name="oviewAllAllot" value="<%=formatnumber(AllAllot,2)%>" >
																											<input type="hidden" name="oviewbetmoney" value="<%=formatnumber(betmoney,[])%>" >
																											<input type="hidden" name="oviewAllhMoney" value="<%=formatnumber(AllhMoney,[])%>" >  

																										</td>
																								</table>
																							</td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																			
																			
																		</table>
														
														
														
																	</td>
																</tr>													

																
																
																
																
																<tr><td height=10></td></tr>
																<tr>
																	<td>
																	
																			<table border=0 width=100% cellpadding=5 cellspacing=5 bgcolor=212021>
																				<tr >
																					<td bgcolor=000000>
																						<table border=0 align=center cellpadding=1 cellspacing=2 >
																							<tr  >
																								<td >
																									<img src=/images/delete.gif onclick="delalltmp()" style="cursor:pointer" align=absmiddle>&nbsp;
																								복식카트 배팅 금액 : <input type=text id="amount" name="amount" onblur="tmpcart_betch('')" size="19" value="<%=betmoney%>" class=input14>
																								<img src=/images/btn_bat.gif onclick="tmpcart_betch('1')" style="cursor:pointer;" align=absmiddle>
																								<input type="hidden" id="AllhMoney" name='AllhMoney' value='<%=AllhMoney%>'>
																								</td>
																						</table>
																					</td>
																				</tr>
																			</table>
																					
																					
																		
																	</td>
																</tr>
<%
																End If
%>																
																</form>
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