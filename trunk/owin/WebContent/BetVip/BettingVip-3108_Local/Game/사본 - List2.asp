<!--	#include virtual=/common/asp/top.asp			-->
<!--	#include virtual=/common/asp/memberClass.asp	-->
<!--	#include virtual=/common/asp/Oops.asp	-->
<!--<META HTTP-EQUIV="refresh" CONTENT="50" URL="">-->
<script language=javascript src="/js/bet.js"></script>

<%
	Sect	= reInt(Request("Sect"),5)
	SQL = "SELECT Idx, gName, convert(varchar(16),gsDate,120 ) As gsDat, League, hTname, "
	SQL = SQL &" hAllot, hCap, HcapAllotl, vTname, vAllot, hcont, vcont, Upflag, Status, UpAllot "
	SQL = SQL &" FROM Game_TB WHERE  ( Status=0 or Status=1 )  "
'	If Not isNone(Sect) Then SQL = SQL &" And Sect='"& Sect &"'"
	SQL = SQL &" And Sect='"& Sect &"'"
	SQL = SQL &" Order By Idx ASC "
	Set objRs = RunSQLReturnRs(SQL)
'	Response.Write RandomCode()
%>
<script>
				var f_coin="<%=UsePoints("", Session("UId"), 2)%>";
				var min_bet1="5000";
				var min_bet2="5000";
				var max_bet1="1000000";
				var max_bet2="1000000";
				var max_amount1="3000000";
				var max_amount2="3000000";
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
                    <td width=194 bgcolor=#5A1010 >
	                    <!--	#include virtual=/common/asp/left.asp	-->
                    </td>
					<td valign=top >
						<table border="0" cellpadding="0" cellspacing="0" >
							
							<tr>
								<td  >
									<table width=980 border="0" cellpadding="0" cellspacing="0" >
										<tr>
											<td valign=top style="padding-left:20pt">
												<table border="0" cellpadding="0" cellspacing="0" height=750>
													<tr>
														<td valign=top>
															<table border="0" cellpadding="3" cellspacing="2" width=100%>
																<tr>
																    <td height=42 width=750 background=/images/title01.gif style="background-repeat:no-repeat"></td>
																</tr>
																<tr>
																    <td >
																		<table border=0 width=100% cellpadding=3 cellspacing=0 bgcolor=D6C5AD>
																			<tr>
																				<td >
																					<table width=100% border=0 cellpadding=3 cellspacing=1 bgcolor=D6C5AD>
																						<tr bgcolor=DE6B8C >
																							<td  width=220 align=center ><font color=FFFFFF><b>경기일시</td>
																							<td  width=100 align=center ><font color=FFFFFF><b>리 그</td>
																							<td  width=550 align=center ><font color=FFFFFF><b>(승)홈 팀</td>
																							<td  width=100 align=center ><font color=FFFFFF><b>무</td>
																							<td  width=650 align=center ><font color=FFFFFF><b>패(원정팀)</td>
																							<td  width=70 align=center ><font color=FFFFFF><b>상태</td>
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
																										<td align=center width=60>&nbsp;<% If objRs("Upflag")=1 Then %><img src=/images/icon_close.gif align=absmiddle alt="<%=objRs("UpAllot")%>" style="cursor:hand" hspace=1><% End If %></td>
																										<td width=90% align=right><nobr>
																										<span id="team1_<%=objRs("Idx")%>"><%=objRs("hTname")%></span>
																										<input <% If objRs("Status")=0 Then%> disabled <%End If %> type=checkbox id="chk1_<%=objRs("Idx")%>" value="1" onclick="check_bet(event)" num="<%=objRs("Idx")%>">
																										<span id="bet1_<%=objRs("Idx")%>"><%=objRs("hAllot")%></span>&nbsp;<img width=22 height=14 src="/flag/<%=right("0"&objRs("hcont"),2)%>.gif" align=absmiddle>
																										</td>
																									</tr>
																								</table>
																							</td>
																							<td align=center bgcolor=FFFFF7 ><nobr>
																							<% If getInt(objRs("HcapAllotl")) Then %>
																							<input <% If objRs("Status")=0  Then%> disabled <%End If %> type="checkbox" id="chk3_<%=objRs("Idx")%>" value="3" onclick="check_bet(event)" num="<%=objRs("Idx")%>"  > <span id="bet3_<%=objRs("Idx")%>" ><%=objRs("HcapAllotl")%></span>
																							<% Else %>
																							 - 
																							<% End If %>
																							</td>
																							<td align=left bgcolor=FFFFFF >
																								<table border=0 cellpadding=0 cellspacing=0>
																									<tr>
																										<td ><nobr>
																											<img width=22 height=14 src="/flag/<%=right("0"&objRs("vcont"),2)%>.gif"> 
																											<span id="bet2_<%=objRs("Idx")%>"><%=objRs("vAllot")%></span> 
																											<input <% If objRs("Status")=0 Then%> disabled <%End If %> type=checkbox id="chk2_<%=objRs("Idx")%>" value="2" onclick="check_bet(event)" num="<%=objRs("Idx")%>">
																											<span id="team2_<%=objRs("Idx")%>"><%=objRs("vTname")%></span>&nbsp;
																										</td>
																										
																									</tr>
																								</table>
																							</td>
																							<td align=center bgcolor=FFFFFF ><nobr><% If objRs("Status")=0 Then%>마감<%Else%>배팅<%End If %></td>
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
																
																<tr>
																	<td>
																		<table border=0 width=97% cellpadding=6 cellspacing=2 bgcolor=D6CFC9>
																			<tr>
																				<td bgcolor=EFEFEF align=center>
																				<img src=/images/sub01.gif align=absmiddle>
																				<img src=/images/sub02.gif onclick="location.href='Cart.asp'" style="cursor:pointer" align=absmiddle>
																				<img src=/images/sub03.gif onclick="del_all()" style="cursor:pointer" style="cursor:pointer" align=absmiddle>
																				
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
																		<table border=0 width=97% cellpadding=6 cellspacing=2 bgcolor=EFEFEF>
																			<tr >
																				<td bgcolor=FFFFFF>
																					<table border=0 align=center cellpadding=1 cellspacing=2 >
																						<tr  >
																							<td >배팅금액</td>
																							<td >: <input type=text id="txt_point" size="19" value="5,000" onkeyup="if(event.keyCode>40 || event.keyCode<33)this.value=MoneyFormat(this.value);calc()" type="text" ID="Text4" class=input2></td>
																							<td align=center><img src=/images/btn_bat.gif onclick="betting('betting')" style="cursor:pointer"></td>
																						</tr>
																						<tr  >
																							<td align=center>예상배당율</td>
																							<td >: <b><span id="sp_bet">0.00</span></td>
																							<td align=center><img src=/images/btn_in.gif onclick="betting('cart')" style="cursor:pointer" ></td>
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
<!--	#include virtual=/common/asp/bottom.asp	-->										