<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>
<%
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	Game game = (Game) request.getAttribute("Game");
	String type = request.getParameter("type");	
%>
		  <!-- 좌측 메뉴 -->
		  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
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
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminBetting.aspx"> 배팅관리</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="game/calc.php"> 정산관리</a></td>
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
                    <td height="30" background="/admin_mode/image/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 경기관리 - 승무패</td>
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
	function checkIT() {
		var d=document.registerGame;
		if(!d.leagueId.value) { alert('리그명을 선택하세요'); d.reagueId.focus(); return false; }
		//if(!d.gamedate.value) { alert('게시일을 선택하세요'); d.gamedate.focus(); return false; }f
		if(!d.gameDate.value) { alert('경기 시작 시각(일자)을 선택하세요'); d.gameDate.focus(); return false; }
		if(!d.gameHour.value) { alert('경기 시작 시각(시)을 선택하세요'); d.gameHour.focus(); return false; }
		if(!d.gameMinute.value) { alert('경기 시작 시각(분)을 선택하세요'); d.gameMinute.focus(); return false; }
		//if(!d.gametime4.value) { alert('경기 시작 시각(초)을 선택하세요'); d.gametime4.focus(); return false; }
		if(!d.homeTeam.value) { alert('홈팀명을 입력하세요'); d.homeTeam.focus(); return false; }
		if(!d.winRate.value) { alert('홈팅 배당률을 입력하세요'); d.winRate.focus(); return false; }		
		if(!d.awayTeam.value) { alert('원정팀명을 입력하세요'); d.awayTeam.focus(); return false; }
		if(!d.loseRate.value) { alert('원정팀명 배당률을 입력하세요'); d.loseRate.focus(); return false; }
		if(!d.drawRate.value) { alert('무승부 배당률을 입력하세요'); d.drawRate.focus(); return false; }
		/*
		if(d.gametype_set.value=='1x2') {
			if(!d.x_by.value) { alert('무승부 배당률을 입력하세요'); d.x_by.focus(); return false; }
		}
		else {
			if(!d.handicap_title.value) { alert('핸디캡을 입력하세요'); return false; }
		}*/

		var query = "mode=registerGame";
		query += "&type=wdl";
		query += "&leagueId=" + d.leagueId.value;
		query += "&gameDate=" + d.gameDate.value;
		query += "&gameHour=" + d.gameHour.value;
		query += "&gameMinute=" + d.gameMinute.value;
		query += "&homeTeam=" + d.homeTeam.value;
		query += "&winRate=" + d.winRate.value;
		query += "&awayTeam=" + d.awayTeam.value;
		query += "&loseRate=" + d.loseRate.value;
		query += "&drawRate=" + d.drawRate.value;

		var http = new JKL.ParseXML("adminGame.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resulXml.code == 0) {
			location.href = "adminGame.aspx?mode=viewGameList&type=wdl";
		}
	}

	function delIT() {
		if(confirm('해당 정보를 삭제하시겠습니까?')) {
			location='/admin_mode/game/1x2game.php?mode=del_exe&idx=&page=&page_list=&search=&kwd=&type=';
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
			d.action='/admin_mode/game/1x2game.php?mode=update_exe&st='+st;
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
			d.action='/admin_mode/game/1x2game.php?mode=update_all_exe';
			d.submit();
		}
		else {
			return;
		}
	}


</SCRIPT>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">		
              <tr>
                <td height="30"><table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
                    <form method='post' name='registerGame' onSubmit="return checkIT()">
						<!--
					 <tr bgcolor="E7E7E7">
                        <td align="center" bgcolor="E7E7E7" width="15%">게임종류</td>
                        <td bgcolor="#FFFFFF"  colspan=3>
						<select name='gametype' onChange="gametypeIT()">
						<option value='1x2'>1x2</option>
						<option value='handicap'>핸디캡</option>
						</select>
						</td>
                      </tr>	
					  -->
					  <tr bgcolor="E7E7E7">
                        <td align="center" bgcolor="E7E7E7" width="15%">리그명</td>
                        <td bgcolor="#FFFFFF"  colspan=3>
						<select name='leagueId'>
							<%
							if (leagueList != null) {
								for (League league : leagueList) {
									
							%>
							<option value='<%=league.getId()%>' > <%=league.getName()%> </option>
							<%
								}
							}
							%>
						</select>

						</td>
                      </tr>		
					   <!--tr bgcolor="E7E7E7">
                        <td align="center" bgcolor="E7E7E7" width="15%">게시일자</td>
                        <td bgcolor="#FFFFFF"  colspan=3><input type='text' name='gamedate' size=10 readonly onClick="popUpCalendar(this,gamedate,'yyyy-mm-dd');" style="cursor:hand"></td>
                      </tr-->		
					   <tr bgcolor="E7E7E7">
                        <td align="center" bgcolor="E7E7E7" width="15%">게임시간</td>
                        <td bgcolor="#FFFFFF"  colspan=3><input type='text' name='gameDate' size=10 readonly onClick="popUpCalendar(this,gameDate,'yyyy-mm-dd');" style="cursor:hand">
						<select name='gameHour'>
												<option value='0'>00</option>
												<option value='1'>01</option>
												<option value='2'>02</option>
												<option value='3'>03</option>
												<option value='4'>04</option>
												<option value='5'>05</option>
												<option value='6'>06</option>
												<option value='7'>07</option>
												<option value='8'>08</option>
												<option value='9'>09</option>
												<option value='10'>10</option>
												<option value='11'>11</option>
												<option value='12'>12</option>
												<option value='13'>13</option>
												<option value='14'>14</option>
												<option value='15'>15</option>
												<option value='16'>16</option>
												<option value='17'>17</option>
												<option value='18'>18</option>
												<option value='19'>19</option>
												<option value='20'>20</option>
												<option value='21'>21</option>
												<option value='22'>22</option>
												<option value='23'>23</option>
												</select>
						시
						<select name='gameMinute'>
												<option value='0'>00</option>
												<option value='1'>01</option>
												<option value='2'>02</option>
												<option value='3'>03</option>
												<option value='4'>04</option>
												<option value='5'>05</option>
												<option value='6'>06</option>
												<option value='7'>07</option>
												<option value='8'>08</option>
												<option value='9'>09</option>
												<option value='10'>10</option>
												<option value='11'>11</option>
												<option value='12'>12</option>
												<option value='13'>13</option>
												<option value='14'>14</option>
												<option value='15'>15</option>
												<option value='16'>16</option>
												<option value='17'>17</option>
												<option value='18'>18</option>
												<option value='19'>19</option>
												<option value='20'>20</option>
												<option value='21'>21</option>
												<option value='22'>22</option>
												<option value='23'>23</option>
												<option value='24'>24</option>
												<option value='25'>25</option>
												<option value='26'>26</option>
												<option value='27'>27</option>
												<option value='28'>28</option>
												<option value='29'>29</option>
												<option value='30'>30</option>
												<option value='31'>31</option>
												<option value='32'>32</option>
												<option value='33'>33</option>
												<option value='34'>34</option>
												<option value='35'>35</option>
												<option value='36'>36</option>
												<option value='37'>37</option>
												<option value='38'>38</option>
												<option value='39'>39</option>
												<option value='40'>40</option>
												<option value='41'>41</option>
												<option value='42'>42</option>
												<option value='43'>43</option>
												<option value='44'>44</option>
												<option value='45'>45</option>
												<option value='46'>46</option>
												<option value='47'>47</option>
												<option value='48'>48</option>
												<option value='49'>49</option>
												<option value='50'>50</option>
												<option value='51'>51</option>
												<option value='52'>52</option>
												<option value='53'>53</option>
												<option value='54'>54</option>
												<option value='55'>55</option>
												<option value='56'>56</option>
												<option value='57'>57</option>
												<option value='58'>58</option>
												<option value='59'>59</option>
												</select>
						분

						<!-- select name='gametime4'>
												<option value='0'>00</option>
												<option value='1'>01</option>
												<option value='2'>02</option>
												<option value='3'>03</option>
												<option value='4'>04</option>
												<option value='5'>05</option>
												<option value='6'>06</option>
												<option value='7'>07</option>
												<option value='8'>08</option>
												<option value='9'>09</option>
												<option value='10'>10</option>
												<option value='11'>11</option>
												<option value='12'>12</option>
												<option value='13'>13</option>
												<option value='14'>14</option>
												<option value='15'>15</option>
												<option value='16'>16</option>
												<option value='17'>17</option>
												<option value='18'>18</option>
												<option value='19'>19</option>
												<option value='20'>20</option>
												<option value='21'>21</option>
												<option value='22'>22</option>
												<option value='23'>23</option>
												<option value='24'>24</option>
												<option value='25'>25</option>
												<option value='26'>26</option>
												<option value='27'>27</option>
												<option value='28'>28</option>
												<option value='29'>29</option>
												<option value='30'>30</option>
												<option value='31'>31</option>
												<option value='32'>32</option>
												<option value='33'>33</option>
												<option value='34'>34</option>
												<option value='35'>35</option>
												<option value='36'>36</option>
												<option value='37'>37</option>
												<option value='38'>38</option>
												<option value='39'>39</option>
												<option value='40'>40</option>
												<option value='41'>41</option>
												<option value='42'>42</option>
												<option value='43'>43</option>
												<option value='44'>44</option>
												<option value='45'>45</option>
												<option value='46'>46</option>
												<option value='47'>47</option>
												<option value='48'>48</option>
												<option value='49'>49</option>
												<option value='50'>50</option>
												<option value='51'>51</option>
												<option value='52'>52</option>
												<option value='53'>53</option>
												<option value='54'>54</option>
												<option value='55'>55</option>
												<option value='56'>56</option>
												<option value='57'>57</option>
												<option value='58'>58</option>
												<option value='59'>59</option>
												</select>
						초

						</td-->
                      </tr>		
					     <tr bgcolor="E7E7E7">
                        <td align="center" bgcolor="E7E7E7" width="15%">홈팀</td>
                        <td bgcolor="#FFFFFF" width=35%>
						팀명 <input type='text' name='homeTeam'>
						<!--배당률 <input type='text' name='a1_by' size=5>-->
						</td>
						 <td align="center" bgcolor="E7E7E7" width="15%">원정팀</td>
                        <td bgcolor="#FFFFFF" width="35%">
						팀명 <input type='text' name='awayTeam'>
						<!--배당률 <input type='text' name='a1_by' size=5>-->
						</td>
                      </tr>	
					  <!--
					     <tr bgcolor="E7E7E7">
                        <td align="center" bgcolor="E7E7E7" width="15%"><div id='td_title'>무승부</div></td>
                        <td bgcolor="#FFFFFF"  colspan=3>	
						<table border=0 width=100% id='1x2_dp'>
							<tr>
								<Td>배당률 <input type='text' name='x_by' size=5></td>
							</tr>
						</table>
						<table border=0 width=100% id='handicap_dp' style='display:none'>
							<tr>
								<Td><input type='text' name='handicap_title' size=50></td>
							</tr>
						</table>
						</td>
                      </tr>		
					  -->
					   					     <tr bgcolor="E7E7E7">
                        <td align="center" bgcolor="E7E7E7" width="15%">배당률</td>
                        <td bgcolor="#FFFFFF"  colspan=3>
						승 <input type='text' name='winRate' size=5> 무 <input type='text' name='drawRate' size=5> 패 <input type='text' name='loseRate' size=5>					
						</td>
                      </tr>		
					 
				
                </table>
				</td>
              </tr>
              <tr>
                <td height="50" align="center"><table width="2%"  border="0" cellspacing="5" cellpadding="0">
                              <tr>
                                <td><input type='image' src="images/admin/but_input.gif" border="0"></td>                               
                                <td><img src="images/admin/but_cancel.gif" border="0" onClick="history.back()" style="cursor:hand"></td>
                              </tr>
                          </table></td>
              </tr>
              </form>
              <tr>
                <td>&nbsp;</td>
              </tr>              
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
