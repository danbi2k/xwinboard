<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%
	final Integer ROWSIZE = 10;
	final Integer SHOWPAGE = 10;

	List<Game> gameList = (List<Game>) request.getAttribute("gameList");
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	Integer totalCount = (Integer) request.getAttribute("gameCount");
	
	String leagueId = XwinUtil.nvl(request.getParameter("leagueId"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
	String status = XwinUtil.nvl(request.getParameter("status"));
	String betStatus = XwinUtil.nvl(request.getParameter("betStatus"));
	String gameDate = XwinUtil.nvl(request.getParameter("gameDate"));
	
	String pageIndex = XwinUtil.arcNvl(request.getParameter("pageIndex"));
%>
 <%@ include file="../admin_header.jsp"%>
		  <!-- 좌측 메뉴 -->
		  
<%@page import="com.xwin.web.controller.admin.AdminGameController"%><table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="45" background="imgae/leftm_bg.gif" style="padding-left:20px" class="sub_menu_left"> 경기관리</td>

              </tr>
              <tr>
                <td align="right"><table width="96%"  border="0" cellpadding="5" cellspacing="1" bgcolor="D9D9D9"> 
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminGame.aspx?mode=viewGameList&type=wdl"> 경기관리 - 승무패</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminGame.aspx?mode=viewGameList&type=handy"> 경기관리 - 핸디캡</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminGame.aspx?mode=viewGameList&type=oe"> 경기관리 - 홀짝</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminBetting.aspx?mode=viewBettingList"> 배팅관리</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminLeague.aspx?mode=viewLeagueList"> 리그관리</a></td>
    </tr>

</table></td>
              </tr>
          </table>
		  <!-- 좌측 메뉴 -->
		  </td>
          <td style="padding:15" valign="top">
		  <!-- 세부 내용 -->
		  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>

                <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                  <!-- 서버 타이틀 -->
				  <tr>
                    <td height="30" background="images/admin/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 경기관리 - 승무패</td>
                  </tr>
                  <tr>
                    <td height="1" bgcolor="CDCDCD"> </td>

                  </tr>
                  <tr>
                    <td height="2" bgcolor="E7E7E7"> </td>
                  </tr>
				  <!-- 서버 타이틀 -->
                  <tr>
                    <td>&nbsp;</td>
                  </tr>

                  <tr>
                    <td><!----컨텐츠---->
					<SCRIPT LANGUAGE="JavaScript">

	function goPage(pageIndex)
	{
		document.search.pageIndex.value = pageIndex;
		document.search.submit();
	}

	function readyGame(id)
	{
		if (confirm("경기를 대기 하시겠습니까?")) {
			var query = "mode=readyGame";
			query += "&id=" + id;
			
			var http = new JKL.ParseXML("adminGame.aspx", query);
			var result = http.parse();
			alert(result.resultXml.message);
			if (result.resultXml.code == 0) {
				location.reload();
			}
		}
	}
	
	function runGame(id, oselect)
	{
		if (confirm("경기를 진행 하시겠습니까?")) {	
			var query = "mode=runGame";
			query += "&id=" + id;
			
			var http = new JKL.ParseXML("adminGame.aspx", query);
			var result = http.parse();
			alert(result.resultXml.message);
			if (result.resultXml.code == 0)
				location.reload();
		}
	}
	
	function endGame(id)
	{
		var homeScore = document.getElementById("homeScore_"+id).value;
		var awayScore = document.getElementById("awayScore_"+id).value;

		if (homeScore == '' || awayScore == '') {
			alert("스코어를 입력하세요");
			return;
		}

		if (confirm("경기를 종료 하시겠습니까?")) {
			var query = "mode=endGame";
			query += "&homeScore=" + homeScore;
			query += "&awayScore=" + awayScore;
			query += "&id=" + id;
			
			var http = new JKL.ParseXML("adminGame.aspx", query);
			var result = http.parse();
			alert(result.resultXml.message);
			if (result.resultXml.code == 0) {
				location.reload();
			}
		}
	}

	function cancelGame(id)
	{
		if (confirm("경기를 취소 하시겠습니까?")) {
			var query = "mode=cancelGame";
			query += "&id=" + id;
			
			var http = new JKL.ParseXML("adminGame.aspx", query);
			var result = http.parse();
			alert(result.resultXml.message);
			if (result.resultXml.code == 0) {
				location.reload();
			}
		}
	}

	function changeBetStatus(id, oselect)
	{
		var betStatus = oselect.value;
		var msg = "";
		if (betStatus == '<%=Code.BETTING_STATUS_ACCEPT%>')
			msg = "배팅 가능 상태로 바꾸시겠습니까?";
		else if (betStatus == '<%=Code.BETTING_STATUS_DENY%>')
			msg = "배팅 금지 상태로 바꾸시겠습니까?";
		else
			msg = "배팅을 정산 하시겠습니까?";

		if (confirm(msg)) {
			var query = "mode=changeBetStatus";
			query += "&betStatus=" + betStatus;
			query += "&id=" + id;
			
			var http = new JKL.ParseXML("adminGame.aspx", query);
			var result = http.parse();
			alert(result.resultXml.message);
		}
	}

	function cancelGameScore(id)
	{
		var query = "mode=cancelGameScore";
		query += "&id=" + id;
		
		var http = new JKL.ParseXML("adminGame.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0) {
			location.reload();
		}
	}

	function removeGame(id)
	{
		var query = "mode=removeGame";
		query += "&id=" + id;
		
		var http = new JKL.ParseXML("adminGame.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0) {
			location.reload();
		}
	}

	function delIT() {
		if(confirm('해당 정보를 삭제하시겠습니까?')) {
			location='game/1x2game.php?mode=del_exe&idx=&page=&page_list=&search=&kwd=&type=';
		}
		else {
			return false;
		}
	}

	function stIT(st) {
		var d=document.game;
		var chk = 0;
		var msg

		if (st=='Y') {
				msg = '진행';
			}else if(st=='N') {
				msg = '강제종료';
			}else if(st=='P') {
				msg = '배팅차단';
			}else {
				msg = '완료';
			}



		for(i=0;i<d.elements.length;i++) {
			if(d.elements[i].checked==true) { chk++; }
		}

		if(!chk) { alert('게임을 선택하세요'); return; }

		if(confirm(msg+' 처리 하시겠습니까?')) {
			d.action='game/1x2game.php?mode=update_exe&st='+st;
			d.submit();
		}
		else {
			return;
		}
	}

	function allcheck() {
		var d=document.game;
		var chk = 0;
		for(i=0;i<d.elements.length;i++) {
			if(d.ac.checked==true) {
				d.elements[i].checked=true;
			}
			else {
				d.elements[i].checked=false;
			}
		}
	}

	function gametypeIT() {
		var d=document.regist;
		if(d.gametype_set.value=='handicap') {
			d.x_by.disabled=true;
			d.handicap_title.disabled=false;
			document.all['td_title'].innerHTML='핸디캡설명';
			document.all['1x2_dp'].style.display='none';
			document.all['handicap_dp'].style.display='';
		}
		else {
			d.x_by.disabled=false;
			d.handicap_title.disabled=true;
			document.all['td_title'].innerHTML='무승부';
			document.all['1x2_dp'].style.display='';
			document.all['handicap_dp'].style.display='none';
		}
	}


	function upIT() {
		var d=document.game;
		var chk = 0;
		for(i=0;i<d.all['win[]'].length;i++) {
			alert(d.all['win[]'][i].value);
			if(d.all['win[]'][i].value!='') {
				alert(d.all['score[]'][i].value);
				alert(d.all['score2[]'][i].value);
				if(!d.all['score[]'][i].value || !d.all['score2[]'][i].value) { 
					alert('스코어를 입력하세요');
					d.all['score[]'][i].focus();
				}
				else {
					chk++;
				}
			}
			alert(d.all['win[]'].length);
		}
		alert("haha");
		alert("chk="+chk);
		if(!chk) { alert('승패를 입력하실 게임의 결과를 선택하시고 스코어를 입력하세요'); return; }

		if(confirm('게임결과를 입력하시겠습니까?\n\n입력하시면 자동으로 게임은 종료됩니다')) {
			d.action='game/1x2game.php?mode=update_all_exe';
			d.submit();
		}
		else {
			return;
		}
	}


</SCRIPT>
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td height="30"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td> * 게임정보를 조회하시거나 수정 , 삭제 하실 수 있습니다.</td>

                                <td align="right"><a href='adminGame.aspx?mode=viewRegisterGameForm&type=wdl'><img src='images/admin/but_input.gif' border=0></a></td>
                              </tr>
                          </table></td>
                        </tr>
							<form method='get' name='search'>
							<input type='hidden' name='pageIndex' value='0'/>
							<input type='hidden' name='mode' value='viewGameList'/>
							<input type='hidden' name='type' value='wdl'/>
						 <tr>
                          <td align='left' height=30>
						리그명
						<select name='leagueId' onChange='this.form.submit()'>
							<option value=''>전체</option>
							<%
							if (leagueList != null) {
								for (League league : leagueList) {
									
							%>
							<option value='<%=league.getId()%>' <%=leagueId.equals(league.getId())?"selected":""%>> <%=league.getName()%> </option>
							<%
								}
							}
							%>
						</select>
						경기상태
						<select name='status' onChange='this.form.submit()'>
							<option value=''>전체</option>
							<option value='<%=Code.GAME_STATUS_READY%>' <%=status.equals(Code.GAME_STATUS_READY)?"selected":""%>><%=Code.getValue(Code.GAME_STATUS_READY)%></option>
							<option value='<%=Code.GAME_STATUS_RUN%>' <%=status.equals(Code.GAME_STATUS_RUN)?"selected":""%>><%=Code.getValue(Code.GAME_STATUS_RUN)%></option>
							<option value='<%=Code.GAME_STATUS_END%>' <%=status.equals(Code.GAME_STATUS_END)?"selected":""%>><%=Code.getValue(Code.GAME_STATUS_END)%></option>
							<option value='<%=Code.GAME_STATUS_CANCEL%>' <%=status.equals(Code.GAME_STATUS_CANCEL)?"selected":""%>><%=Code.getValue(Code.GAME_STATUS_CANCEL)%></option>	
						 </select>
						배팅상태
						<select name='betStatus' onChange='this.form.submit()'>
							<option value=''>전체</option>
							<option value='<%=Code.BETTING_STATUS_ACCEPT%>' <%=betStatus.equals(Code.BETTING_STATUS_ACCEPT)?"selected":""%>><%=Code.getValue(Code.BETTING_STATUS_ACCEPT)%></option>
							<option value='<%=Code.BETTING_STATUS_DENY%>' <%=betStatus.equals(Code.BETTING_STATUS_DENY)?"selected":""%>><%=Code.getValue(Code.BETTING_STATUS_DENY)%></option>	
						 </select>

						 경기일자
						<input type='text' name='gameDate'value='' size=10 readonly onClick="popUpCalendar(this,gameDate,'yyyy-mm-dd');" style="cursor:hand">
				 
						 <select name='search'>
							 <option value='homeTeam' <%=search.equals("homeTeam")?"selected":""%>>홈팀명</option>
						 	<option value='awayTeam' <%=search.equals("awayTeam")?"selected":""%>>원정팀명</option>
						 </select>
						 <input type='text' name='keyword' value='<%=keyword%>'>
						 <input type='submit' value='검 색'>
						  </td>
                        </tr>
						<!--
						<tr>
							<td>
								<font color='#FFFF00'> ■ </font>핸디캡 경기 / □ 1x2 경기
								</td>
							</tr>
						</tr>
						-->
						</form>
							 <form method='get' name='game'>
						<tr>
							<td colspan='3'><b>
							게임진행: <img src="images/admin/btn_run.jpg">
							게임대기: <img src="images/admin/btn_ready.jpg">
							게임종료: <img src="images/admin/btn_end.jpg">
							게임취소: <img src="images/admin/btn_cancel.jpg">
							</b>
							<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">

                              <tr align="center" bgcolor="#E4E4E4">
								<td width=5%>번호</td>
								<td>리그명</td>
								<td>경기시각</td>
								<td>홈팀</td>
								<td>원정팀</td>
								<td>승</td>
								<td>무</td>
								<td>패</td>								
								<td>스코어</td>
								<td>결과</td>
								<td>배팅</td>
								<td>상태</td>
								<td>기능</td>
							  </tr>

							<%
							if (gameList != null) {
								for (Game game : gameList) {
									
							%>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%><a href="adminGame.aspx?mode=viewUpdateGameForm&type=wdl&id=<%=game.getId()%>"><%=game.getId()%></a></td>
								<td><%=game.getLeagueName()%></td>

								<td><%=game.getGameDateStr()%></td>
								<td><%=game.getHomeTeam()%></td>
								<td><%=game.getAwayTeam()%></td>
								<td><%=game.getWinRateStr()%></td>
								<td><%=game.getDrawRateStr()%></td>
								<td><%=game.getLoseRateStr()%></td>
								<td>
									<%
									if (game.getStatus().equals(Code.GAME_STATUS_RUN)) {
									%>
									<input id='homeScore_<%=game.getId()%>' type='text' name='homeScore' value='<%=XwinUtil.nvl(game.getHomeScore())%>' size=2>
									:
									<input id='awayScore_<%=game.getId()%>' type='text' name='awayScore' value='<%=XwinUtil.nvl(game.getAwayScore())%>' size=2>
									<%
									} else {
									%>
									<%=XwinUtil.nvl(game.getHomeScore())%> : <%=XwinUtil.nvl(game.getAwayScore())%>							
									<%
									}
									%>
								</td>
								<td><%=Code.getValue(game.getResult())%></td>
								<td>
							<select name='betStatus_<%=game.getId()%>' onchange='changeBetStatus(<%=game.getId()%>, this)'>
								<option value='<%=Code.BETTING_STATUS_ACCEPT%>' <%=game.getBetStatus().equals(Code.BETTING_STATUS_ACCEPT)?"selected":""%>><%=Code.getValue(Code.BETTING_STATUS_ACCEPT)%></option>
								<option value='<%=Code.BETTING_STATUS_DENY%>' <%=game.getBetStatus().equals(Code.BETTING_STATUS_DENY)?"selected":""%>><%=Code.getValue(Code.BETTING_STATUS_DENY)%></option>
							</select>
								</td>								
								<td><B><%=Code.getValue(game.getStatus())%></B></td>
								<td>
									<%
										if (game.getStatus().equals(Code.GAME_STATUS_RUN) == false) {
									%>
									<img src="images/admin/btn_run.jpg" onclick='runGame(<%=game.getId()%>)' style='cursor:hand'>
									<%
										}
										if (game.getStatus().equals(Code.GAME_STATUS_RUN)) {
									%>															
									<img src="images/admin/btn_end.jpg" onclick='endGame(<%=game.getId()%>)' style='cursor:hand'>
									<%
										}
										if (game.getStatus().equals(Code.GAME_STATUS_READY) == false) {
									%>
									<img src="images/admin/btn_ready.jpg" onclick='readyGame(<%=game.getId()%>)' style='cursor:hand'>
									<%
										}
										if (game.getStatus().equals(Code.GAME_STATUS_CANCEL) == false) {
									%>
									<img src="images/admin/btn_cancel.jpg" onclick='cancelGame(<%=game.getId()%>)' style='cursor:hand'>
									<%
										}										
									%>
								</td>
							  </tr>
							<%
								}
							}
							%>
                          </table></td>
                        </tr>						
                        <tr>
                          <td align='center' height=50>
<%
	int pIdx = 0;
	if (pageIndex != null)
		pIdx = Integer.parseInt(pageIndex);
	int pageNum = (int) Math.ceil(totalCount / ROWSIZE);
	int startPage = ((int)(pIdx / SHOWPAGE)) * SHOWPAGE;
	int nextPage = startPage + 15;
	
	if (startPage > 0) {
%>
		<a href='javascript:goPage(<%=startPage - 1%>)'>&lt;&lt;&lt;</a>
<%
	}
	int i = 0, c = 0;
	for (c = 0, i = startPage ; i < pageNum && c < SHOWPAGE ; i++, c++) {
		if (i == pIdx) {
%>
			<b> <%=i+1%> </b>
<%
		} else {
%>		
			<a href='javascript:goPage(<%=i%>)'>[ <%=i+1%> ]</a>
<%			
		}
	}
	if (i < pageNum) {
%>
		<a href='javascript:goPage(<%=i%>)'>&gt;&gt;&gt;</a>
<%
	}
%>
					      </td>
                        </tr>    						
						</form>
                      </table>
                      
		  <!-- 세부 내용 끝 -->

                </td>
              </tr>
          </table></td>
        </tr>
    </table></td>
  </tr>
</table>
</td></tr></table>
<!-- 페이지 내용 -->
<%@ include file="../admin_footer.jsp"%>
