<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.game.*" %>
<%@ page import="java.util.*" %>

<%@include file="../header.jsp"%>

<%
	String type = request.getParameter("type");
	String grade = request.getParameter("grade");
%>
<script>
var gameType = '<%=type%>'
</script>
<%
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	List<Game> gameList = (List<Game>) request.getAttribute("gameList");
	
	String leagueId = (String) request.getParameter("leagueId");
	leagueId = leagueId == null ? "" : leagueId;
%>

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
																    <td ><img src=images/title_gamelist.gif  ></td>
																</tr>
																<tr>
																    <td >
																		
																		<table width=100% border=0 cellpadding=0 cellspacing=1 bgcolor=424142>
																			<tr bgcolor=212021 height=27>
																				<td  width=130 align=center ><font color=FFFFFF><b>경기일시</td>
																				<td  width=150 align=center ><font color=FFFFFF><b>리 그</td>
																				<td  width=500 align=center ><font color=FFFFFF><b>(승)홈 팀</td>
																				<td  width=70 align=center ><font color=FFFFFF><b>무</td>
																				<td  width=600 align=center ><font color=FFFFFF><b>(패)원정팀</td>
																				<td  width=60 align=center ><font color=FFFFFF><b>상태</td>
																			</tr>

<%
																			if (gameList != null) {
																				for (Game game : gameList) {
																					String fcolor = "FFFFFF";
																					if (game.getDisplayStatus().equals(Code.GAME_DISPLAY_OPEN))
																						fcolor = "FFC602";
%>														
																			<tr height=25 bgcolor=000000>
																				<td align=center  ><nobr><font color=<%=fcolor%>><%=XwinUtil.toDateStr(game.getGameDate(), 1)%></td>
																				<td align=center  ><nobr><font color=<%=fcolor%>><%=game.getLeagueName()%></td>
																				<td align=right  >
																					<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
																						<tr>
																							<td align=center width=60><nobr>&nbsp;<% if (game.getGrade().equals(Code.USER_GRADE_VIP)) {%><img src=images/icon_event.gif align=absmiddle hspace=1 ><%}%></td>
																							<td align=center width=60>&nbsp;<% if (false) {%><img src=images/icon_close.gif align=absmiddle alt="" style="cursor:hand" hspace=1><%}%></td>
																										
																							<td width=90% align=right><nobr><font color=<%=fcolor%>>
																							<span id="team1_<%=game.getId()%>"><%=game.getHomeTeam()%></span>
																							<input <%=game.getBetStatus().equals(Code.BETTING_STATUS_DENY)?"disable":""%> type=checkbox id="chk1_<%=game.getId()%>" value="1" onclick="check_bet(event)" num="<%=game.getId()%>">
																							</td>
																							<td width=1 bgcolor=FFFFFF></td>
																							<td width=90% align=right>&nbsp;<font color=<%=fcolor%>><span id="bet1_<%=game.getId()%>"><%=game.getWinRateStr()%></span>&nbsp;</td>
																							<td width=1 bgcolor=FFFFFF></td>
																							<td width=90% align=right><nobr><img width=22 height=14 src="/flag/.gif" align=absmiddle></td>
																						</tr>
																					</table>
																				</td>
																				<td align=center ><nobr>
																					<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
																						<tr>
																							<td align=center><nobr><font color=<%=fcolor%>>
																								<% if (game.getType().equals("handy")) {%>
																								<input <%=game.getBetStatus().equals(Code.BETTING_STATUS_DENY)?"disable":""%> type="checkbox" id="chk3_<%=game.getId()%>" value="3" onclick="check_bet(event)" num="<%=game.getId()%>"  > <span id="bet3_<%=game.getId()%>" ><%=game.getDrawRateStr()%></span>
																								<%} else { %>
																								 - 
																								<%}%>
																							</td>
																						</tr>
																					</table>
																				
																				</td>
																				<td align=left >
																					<table border=0 width=100% cellpadding=0 cellspacing=1 bgcolor=424142>
																						<tr>
																							<td ><img width=22 height=14 src="/flag/.gif" align=absmiddle> </td>
																								<td width=1% >&nbsp;<font color=<%=fcolor%>><span id="bet2_<%=game.getId()%>"><%=game.getLoseRateStr()%></span>&nbsp;</font></td>
																								<td width=90% ><nobr>
																								<input <%=game.getBetStatus().equals(Code.BETTING_STATUS_DENY)?"disable":""%> type=checkbox id="chk2_<%=game.getId()%>" value="2" onclick="check_bet(event)" num="<%=game.getId()%>">
																								<font color=<%=fcolor%>><span id="team2_<%=game.getId()%>"><%=game.getAwayTeam()%></span>&nbsp;
																							</td>
																										
																						</tr>
																					</table>
																				</td>
																				<td align=center ><nobr><font color=<%=fcolor%>><%=game.getBetStatus().equals(Code.BETTING_STATUS_DENY)?"마감":"배팅"%></font></td>
																			</tr>
<%
																				}
																			}
%>																					
																						
																		</table>		
																					
																		
																    </td>
																</tr>
																
																<tr>
																	<td>
																		<table border=0 width=100% cellpadding=5 cellspacing=5 bgcolor=212021>
																			<tr >
																				<td bgcolor=000000 >
																					<table border=0 cellpadding=6 cellspacing=2 align=center>
																						<tr>
																							<td>
																				<img src=images/icon02.gif align=absmiddle><b>선택하신 경기&nbsp;
																				<img src=images/sub02.gif onclick="location.href='Cart.asp'" style="cursor:pointer" align=absmiddle>
																				<img src=images/sub03.gif onclick="del_all()" style="cursor:pointer" style="cursor:pointer" align=absmiddle>
																				
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
																							<td align=center><img src=images/btn_bat.gif onclick="betting('betting')" style="cursor:pointer"></td>
																						</tr>
																						<tr  >
																							<td align=center>예상배당율</td>
																							<td >: <b><span id="sp_bet">0.00</span></td>
																							<td align=center><img src=images/btn_in.gif onclick="betting('cart')" style="cursor:pointer" ></td>
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
<%@include file="../footer.jsp"%>