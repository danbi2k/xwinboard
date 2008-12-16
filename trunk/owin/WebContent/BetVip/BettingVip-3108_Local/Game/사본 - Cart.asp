<!--	#include virtual=/common/asp/top.asp			-->
<!--	#include virtual=/common/asp/memberClass.asp	-->
<!--	#include virtual=/common/asp/Oops.asp	-->
<script language=javascript src="/js/bet.js"></script>
<script language=javascript src="/js/cart.js"></script>
<%
	Sect	= Request("Sect")
	SQL = "SELECT c.Idx, g.gName, convert(varchar(16),g.gsDate,120 ) As gsDat,convert(varchar(16),c.WriteDay,120 ) As WriteDay,"
	SQL = SQL &"  c.gbTem, g.hTname, g.hAllot, g.hCap, g.HcapAllotl, g.vTname, g.vAllot, g.hcont, g.vcont, "
	SQL = SQL &" c.HaAllot, c.hMoney, c.bMoney, c.gCnt "
	SQL = SQL &" FROM Game_TB g, BetCart_TB c WHERE g.Status=1 And c.gIdx=g.Idx And c.Id='"& Session("UId") &"'"
	If Not isNone(Sect) Then SQL = SQL &" And Sect='"& Sect &"'"
'	SQL = SQL &" Order By Idx DESC "
	Set objRs = RunSQLReturnRs(SQL)
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
                    <td width=194 bgcolor=#5A1010 >
	                    <!--	#include virtual=/common/asp/left.asp	-->
                    </td>
					<td valign=top >
						<table border="0" cellpadding="0" cellspacing="0" >
							
							<tr>
								<td  >
									<table border="0" cellpadding="0" cellspacing="0" height=600>
										<tr>
											<td valign=top style="padding-left:20pt">
												<table border="0" width=100% cellpadding="0" cellspacing="0" >
													<tr>
														<td >
															<table border="0" cellpadding="3" cellspacing="2" width=100%>
																<form method="post" name="myform">
																<tr>
																    <td height=42 width=750 background=/images/title01.gif></td>
																</tr>
																<tr>
																    <td >
																		<table border=0 width=100% cellpadding=3 cellspacing=0 bgcolor=D6C5AD>
																			<tr>
																				<td >
																					<table width=100% border=0 cellpadding=3 cellspacing=1 bgcolor=D6C5AD>
																						<tr bgcolor=DE6B8C >
																							<td  width=250 align=center ><font color=FFFFFF><b>경기일시</td>
																							<td  width=250 align=center ><font color=FFFFFF><b>배팅시간</td>
																							<td  width=450 align=center ><font color=FFFFFF><b>(승)홈 팀</td>
																							<td  width=100 align=center ><font color=FFFFFF><b>핸드캡</td>
																							<td  width=450 align=center ><font color=FFFFFF><b>패(원정팀)</td>
																							<td  width=100 align=center ><font color=FFFFFF><b>배팅팀</td>
																							<td  width=100 align=center ><font color=FFFFFF><b>상태</td>
																						</tr>
<%
																						If Not objRs.EOF Then
																							Do Until objRs.EOF
%>																						
																						<tr>
																							<td align=center bgcolor=FFFFF7 ><%=objRs("gsDat")%></td>
																							<td align=center bgcolor=FFFFF7 ><%=objRs("WriteDay")%></td>
																							
																							<td align=right bgcolor=FFFFF7 >
																								<img width=22 height=14 src="/flag/<%=right("0"&objRs("hcont"),2)%>.gif">
																								<%=objRs("hTname")%>
																								<%=objRs("hAllot")%>&nbsp;
																							</td>
																							<td align=center bgcolor=FFFFF7 ><%=objRs("hCap")%><%=objRs("HcapAllotl")%></td>
																							<td align=left bgcolor=FFFFFF >&nbsp;<%=objRs("vAllot")%><%=objRs("vTname")%>&nbsp;<img width=22 height=14 src="/flag/<%=right("0"&objRs("vcont"),2)%>.gif"> </td>
																							<td align=center bgcolor=FFFFFF ><%If objRs("gbTem")=1 Then%>홈팀<%Else%>원정팀<%End If%></td>
																							<td align=center bgcolor=FFFFFF >대기</td>
																						</tr>
<%
																								HaAllot = objRs("HaAllot")
																								hMoney = objRs("hMoney")
																								bMoney = objRs("bMoney")
																								gCnt = objRs("gCnt")
																								
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
																		<table border=0 width=100% cellpadding=2 cellspacing=1 bgcolor=EFEFEF>
																			<tr >
																				<td bgcolor=FFFFFF>
																					<table border=0 align=center cellpadding=1 cellspacing=2 >
																						<tr  >
																							<td >배당율 : <%=HaAllot%> / 배팅금액 : <%=formatnumber(bMoney,[])%> / 예상적중금 : <%=formatnumber(hMoney,[])%> <img border="0" src="/images/bet_delete.gif" align="absmiddle" onClick="del_cart('<%=gCnt%>')" style="cursor:hand">
																								<input type="checkbox" id="cart_num" name='cart_num' value='<%=gCnt%>' onClick="check_cart()">
																								<input type="hidden" id="betmoney" name='betmoney' value='<%=bMoney%>'>
																							</td>
																					</table>
																				</td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr><td height=10></td></tr>
																<tr>
																	<td>
																		<table border=0 width=100% cellpadding=6 cellspacing=2 bgcolor=D6CFC9>
																			<tr>
																				<td bgcolor=EFEFEF align=center>
																					<table border=0 width=100% cellpadding=6 cellspacing=2 bgcolor=D6CFC9>
																						<tr>
																							<td align=center>
																								<img src=/images/bet_delete_ch.gif onclick="delall()" style="cursor:pointer" align=absmiddle>&nbsp;
																								선택 한 카트 배팅 금액 : <input type=text id="amount" name="amount" size="19" readonly="readonly" class=input10>
																								<img src=/images/btn_bat.gif onclick="cart_bet()" style="cursor:pointer;" align=absmiddle>
																							</td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																		</table>
																	</td>
																</tr>
																</form>
															</table>
														
														</td>
													</tr>
												</table>
								
											</td>
										</tr>
<!--	#include virtual=/common/asp/bottom.asp	-->										