<!--	#include virtual=/common/asp/top.asp			-->
<!--	#include virtual=/common/asp/memberClass.asp	-->
<!--	#include virtual=/common/asp/Oops.asp	-->
<!--<META HTTP-EQUIV="refresh" CONTENT="50" URL="">-->
<script language=javascript src="/js/bet.js"></script>

<%
	Sect	= reInt(Request("Sect"),1)
	SQL = "SELECT Idx, gName, convert(varchar(16),gsDate,120 ) As gsDat, League, hTname, "
	SQL = SQL &" hAllot, hCap, HcapAllotl, vTname, vAllot, hcont, vcont, Upflag, Status, UpAllot, event "
	SQL = SQL &" FROM Game_TB WHERE ( Status=0 or Status=1 ) "
'	If Not isNone(Sect) Then SQL = SQL &" And Sect='"& Sect &"'"
If Sect =4 Then
	SQL = SQL &" And ( Sect ='1' or Sect ='2' or Sect ='3' or Sect ='4' or Sect ='6' ) "
Else
	SQL = SQL &" And Sect='"& Sect &"'"
End If
'	SQL = SQL &" Order By Idx DESC "
	SQL = SQL &" Order By convert(varchar(20),gsDate,120 ) ASC, League ASC "
	Set objRs = RunSQLReturnRs(SQL)

%>
<script>
				var f_coin="<%=UsePoints("", Session("UId"), 2)%>";
				var min_bet1="5000";
				var min_bet2="5000";
				var max_bet1="1000000";
				var max_bet2="1000000";
				var max_amount1="5000000";
				var max_amount2="5000000";
			</script>
	<form name="betForm" method="post" >
	<input type="hidden" name="mode" value="betting">
	<input type="hidden" name="betmoney" value="">
	<input type="hidden" name="betcontent" value="">
	<input type="hidden" id="game_type" name="game_type" value="2">
	<input type="hidden" id="Sect" name="Sect" value="<%=Sect%>">
	<input type="hidden" name="hapr" >
	<input type="hidden" name="haa" >
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
												<table border="0" cellpadding="0" cellspacing="0" height=750>
													<tr>
														<td valign=top>
															<table border="0" cellpadding="3" cellspacing="2" width=98%>
																<tr>
																    <td ><img src=/images/title_gamelist.gif  ></td>
																</tr>
																<tr>
																    <td >
																		
																					<table width=100% border=0 cellpadding=0 cellspacing=1 bgcolor=424142>
																						<tr bgcolor=212021 height=27>
																							<td  width=130 align=center ><font color=FFFFFF><b>경기일시</td>
																							<td  width=150 align=center ><font color=FFFFFF><b>리 그</td>
																							<td  width=500 align=center ><font color=FFFFFF><b>(승)홈 팀</td>
																							<td  width=100 align=center ><font color=FFFFFF><b>핸디캡</td>
																							<td  width=600 align=center ><font color=FFFFFF><b>(패)원정팀</td>
																							<td  width=60 align=center ><font color=FFFFFF><b>상태</td>
																						</tr>
<%
																						If Not objRs.EOF Then
																							Do Until objRs.EOF
																							If objRs("Status")=0 Then fcolor = "FFC602" Else fcolor = "FFFFFF" End If
%>																						
																						<tr height=25>
																							<td align=center bgcolor=000000 ><nobr><font color=<%=fcolor%>><%=objRs("gsDat")%></td>
																							<td align=center bgcolor=000000 ><nobr><font color=<%=fcolor%>><%=objRs("League")%></td>
																							<td align=right bgcolor=000000 >
																								<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
																									<tr>
																										<td align=center width=60><nobr>&nbsp;<% If objRs("event")=1 Then %><img src=/images/icon_event.gif align=absmiddle hspace=1 ><% End If %></td>
																										<td align=center width=60><nobr>&nbsp;<% If objRs("Upflag")=1 Then %><img src=/images/icon_close.gif align=absmiddle hspace=1 alt="<%=objRs("UpAllot")%>" style="cursor:hand"><% End If %></td>
																										<td align=right width=90%><nobr><font color=<%=fcolor%>>
																											<span id="team1_<%=objRs("Idx")%>"><%=objRs("hTname")%></span>
																											<input <% If objRs("Status")=0 Then%> disabled <%End If %> type=checkbox id="chk1_<%=objRs("Idx")%>" value="1" onclick="check_bet(event)" num="<%=objRs("Idx")%>">
																											
																											<td width=1 bgcolor=FFFFFF></td>
																											<td width=10><font color=<%=fcolor%>>
																											<span id="bet1_<%=objRs("Idx")%>"><%=objRs("hAllot")%></span>&nbsp;
																											<td width=1 bgcolor=FFFFFF></td>
																											<td width=10>
																											<img width=22 height=14 src="/flag/<%=right("0"&objRs("hcont"),2)%>.gif" align=absmiddle>
																										</td>
																									</tr>
																								</table>
																							</td>
																							
																							<td  align=center bgcolor=000000  ><nobr>
																								<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
																									<tr>
																										<td height=20 align=center><font color=<%=fcolor%>><%=objRs("hCap")%><span id="handicap_<%=objRs("Idx")%>" style="display:none"><%=objRs("HcapAllotl")%></span></td>
																									</tr>
																								</table>
																							</td>

																							<td align=left bgcolor=000000 >
																								<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
																									<tr>
																										<td width=10><img width=22 height=14 src="/flag/<%=right("0"&objRs("vcont"),2)%>.gif"></td>
																										
																										<td width=30>&nbsp;<font color=<%=fcolor%>><span id="bet2_<%=objRs("Idx")%>"><%=objRs("vAllot")%></span>&nbsp;</td>
																										
																										<td><nobr>
																										<input <% If objRs("Status")=0 Then%> disabled <%End If %>  type=checkbox id="chk2_<%=objRs("Idx")%>" value="2" onclick="check_bet(event)" num="<%=objRs("Idx")%>">
																										<font color=<%=fcolor%>><span id="team2_<%=objRs("Idx")%>"><%=objRs("vTname")%></span>&nbsp;
																										</td>
																									</tr>
																								</table>
																							</td>
																							<td align=center bgcolor=000000 ><nobr><font color=<%=fcolor%>><% If objRs("Status")=0 Then%>마감<%Else%>배팅<%End If %></td>
																						</tr>
<%
																							objRs.MoveNext
																							Loop
																						End If
%>																						
																						
																					</table>		
																					
																				
																    </td>
																</tr>
																
																<tr>
																	<td>
																		<table border=0 width=100% cellpadding=5 cellspacing=5 bgcolor=212021>
																			<tr >
																				<td bgcolor=000000>
																					<table border=0 width=97% cellpadding=6 cellspacing=2 >
																						<tr>
																							<td align=center>
																							<img src=/images/icon02.gif align=absmiddle><b>선택하신 경기&nbsp;
																							<img src=/images/sub02.gif onclick="location.href='Cart.asp'" style="cursor:pointer" align=absmiddle>
																							<!--<%If Sect =1 or Sect =2 or Sect =3 Then%><img src=/images/sub04.gif onclick="location.href='TmpCart.asp'" style="cursor:pointer" align=absmiddle><%End If%>-->
																							<img src=/images/sub03.gif onclick="del_all()" style="cursor:pointer" style="cursor:pointer" align=absmiddle>
																							
																							</td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																		</table>																					
																	</td>
																</tr>
																<tr>
																	<td style="padding-top: 10px; padding-bottom: 10px;" align="center" >
																		
																		<div id="Div1">
																			<table id="tb_list"></table>
																		</div>
																	</td>
																</tr>
																<tr>
																	<td>
																		<table border=0 width=100% cellpadding=5 cellspacing=5 bgcolor=212021>
																			<tr >
																				<td bgcolor=000000>
																				
																					<table border=0 align=center cellpadding=1 cellspacing=2 >
																						<tr  >
																							<td >배팅금액</td>
																							<td >: <input type=text id="txt_point" size="19" value="5,000" onkeyup="if(event.keyCode>40 || event.keyCode<33)this.value=MoneyFormat(this.value);calc()" type="text" ID="Text4" class=input14></td>
																							<td ><img src=/images/btn_bat.gif onclick="betting('betting')" style="cursor:pointer" align=absmiddle>
																							
																							
																							</td>
																						</tr>
																						<tr  >
																							<td align=center>예상배당율</td>
																							<td >: <b><span id="sp_bet">0.00</span></td>
																							<td align=center>
																								<img src=/images/btn_in.gif onclick="betting('cart')" style="cursor:pointer" >
																								<!--<%If Sect =1 or Sect =2 or Sect =3 Then%><img src=/images/btn_in2.gif onclick="betting('tmpcart')" style="cursor:pointer" ><%End If%>-->
																							</td>
																						</tr>
																						<tr  >
																							<td >예상적중금</td>
																							<td >: <b><span id="sp_total">0</span> 원</td>
																							<td align=center></td>
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
												</table>
											</td>
										</tr>
<!--	#include virtual=/common/asp/bottom.asp	-->										