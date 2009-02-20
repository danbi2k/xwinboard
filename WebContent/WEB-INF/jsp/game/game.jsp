<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.game.*" %>
<%@ page import="java.util.*" %>

<%@include file="../header.jsp"%>

<%
	String type = request.getParameter("type");
	String grade = request.getParameter("grade");
%>
<script language="JavaScript" src="script/scroller.js"></script>
<script>
var gameType = '<%=type%>'
</script>
<%
	List<Game> gameList = (List<Game>) request.getAttribute("gameList");
%>

<%
 
%>

<div class='sub_ti1'>
		<img src='img/sub_wdl_ti.gif' alt='승무패' class='ml10 mr10 fl'> 
		<div class='sub_ti_desc'>· 경기목록 1~10경기까지 자유롭게 조합배팅이 가능합니다.</div>
		<div class='state_bar'>
			<div class='state_bar_txt'>
			<span class='name'><%=member.getNickName()%></span> 님
			<span class='cash'>· Cash:<span class='val'><%=XwinUtil.comma3(member.getBalance())%></span></span> 
			<span class='apple'>· Apple:<span class='val'><%=XwinUtil.comma3(member.getPoint())%></span></span> 
			<!-- span class='link'><a href='myBet.aspx?mode=viewMyBettingList'>배팅내역보기</a></span -->
			</div>
		</div>
		<div class='sub_ti_bar'></div>

		</div>


		<div id='sub_content2'>
			<div class='wdl'>


				<div class='league_select'>
					<img src='img/sub_reload_bt.gif' alt='새로고침' class='img_bt'>
				</div>
				<!-- end league_select -->

				<div class='list_box'>
					<table>
						<tr><th class='t1'>경기일시</th><th class='t2'>리그</th><th class='t3'>(승) 홈팀</th><th class='t4'>무</th><th class='t5'>(패) 원정팀</th><th class='t6'>상태</th></tr>
						
						<%
						if (gameList != null) {
							for (Game game : gameList) {
							//for (int i = 0 ; i < 100 ; i++) {
							//	Game game = gameList.get(0);
							String clsStr = game.getBetStatus().equals(Code.BETTING_STATUS_ACCEPT)?"out":"";
							//	String over = game.getBetStatus().equals(Code.BETTING_STATUS_ACCEPT)?"onMouseOver=\"this.className='over'\"":"";
						%>
						<tr>
							<td><%=XwinUtil.getBoardItemDate(game.getGameDate())%></td>
							<td><img width=22 height=14 src="images/league/<%=game.getLeagueImage()%>"> <%=game.getLeagueName()%></td>

							<td class='<%=clsStr%>' onClick="FnGameBet(this, <%=game.getId()%>, '<%=game.getType()%>', 'W')" id="checkW<%=game.getId()%>">
								<%=game.getHomeTeam()%> x <%=game.getWinRateStr()%>
							</td>
							<td class='<%=game.getType().equals("handy")||game.getType().equals("wdl")&&game.getDrawRate()==0?"":clsStr%>' onClick="FnGameBet(this, <%=game.getId()%>, '<%=game.getType()%>', 'D')" id="checkD<%=game.getId()%>">
								<%
									if (game.getType().equals("wdl"))
										out.print("x" + game.getDrawRateStr());
									else {
										if (game.getDrawRate() > 0)
											out.print("+");
										out.print(game.getDrawRate());
									}
										
								%>
							</td>
							<td class='<%=clsStr%>' onClick="FnGameBet(this, <%=game.getId()%>, '<%=game.getType()%>', 'L')" id="checkL<%=game.getId()%>">
								x <%=game.getLoseRateStr()%> <%=game.getAwayTeam()%>
							</td>
							<td><%=Code.getValue(game.getBetStatus()) %></td></tr>					
						<%
							}
						}
						%>

					</table>
				</div>
				<!-- end list_box -->

				<!-- <div class='all_del'>
				· 선택하신 경기&nbsp;<img src='img/sub_alldel_bt.gif' alt='전체삭제' class='va_m'>
				</div> -->
				<!-- end all_del -->

											
				<!-- 
				<div class='bet_box'>
				<ul>
				<li>· 예상배당율 : 0.00</li>
				<li>· 예상적중금 : 0원</li>
				<li>· 배팅금액&nbsp;&nbsp;&nbsp; : <input class='input_text w100' value="5,000"> 원</li>
				</ul>
				<div class='bet_bt'><img src='img/sub_bet_bt.gif' alt='배팅하기'></div>
				</div> -->
				<!-- end bet_box -->
		


			
			</div>
		</div>
		<!-- end sub_content2 -->
		<div id='sub_right_content'>
			<div class='side_ti'><img src='img/side_alldel_bt.gif' alt='전체삭제' class='alldel_bt' onclick="FnDeleteFolder('<%=type%>')"></div>
			<div class='side_body'>
			<div id='gameFolderDiv'></div>
			<table>
			<tr>
				<td class='t3'>배당률:</td><td class='t4'><div id='rateDiv'>0.00</div></td>
			</tr>
			<tr>
				<td class='t3'>배팅금액:</td><td class='t4'><input id='moneyDiv' type='text' style='width:60px; height:14px; border: 1px #450808 solid;' value='5,000' onkeyup='FnCalcFolder()'></td>
			</tr>
			<tr>
				<td  class='t3'>예상배당금:</td><td class='t4'><div id='expectDiv'>0</div></td>
			</tr>
			<tr>
			<td colspan='2' class='bet_bt'><img src='img/side_bet_bt.gif' alt='배팅하기' onclick="FnBetting()"></td></tr>
			<td colspan='2' class='move_chk'><input id='animate' type='checkbox' class='input_check' onclick='toggleAnimate();' checked> 이동카트사용</td></tr>
			</table>
			</div>
			<div class='side_foot'></div>
			<div class='side_cart_bt'>
			<img src='img/side_cartin_bt.gif' alt='카트에담기'>
			<img src='img/side_cartview_bt.gif' alt='카트보기'>
			</div>
		</div>
		<!-- end sub_right_content -->
<%@include file="../footer.jsp"%>