<html>
<head>
<title>관리자페이지</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/admin_mode/common/style.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="/lib/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" src="../../js/main.js"></SCRIPT>
</head>	
<body>

<!-- 로고 및 상단 메뉴 -->
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
 <tr>
  <td>
  <table width="950"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="60"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="7%"><a href="/admin_mode/main.php"><img src="/admin_mode/image/logo.gif" width="170" height="60" border="0"></a></td>
          <td width="42%"><table width="360"  border="0" cellspacing="0" cellpadding="0">
              <tr>
				<!--td width="72" height="60" align="center" style="padding-top:35px" background="/admin_mode/image/topm41.gif"><a href="/admin_mode/members/" class="menu" >회원관리</a>
			
				</td-->

                <td width="72" height="60" background="/admin_mode/image/topm11.gif" align="center" style="padding-top:35px"><a href="/admin_mode/admin/" class="menu" >관리자정보</a></td>
                <td width="72" height="60" background="/admin_mode/image/topm21.gif" align="center" style="padding-top:35px"><a href="/admin_mode/member/" class="menu" >회원관리</a></td>
                <td width="72" height="60" background="/admin_mode/image/topm31.gif" align="center" style="padding-top:35px"><a href="/admin_mode/calc/" class="menu" >입출금관리</a></td>
                <td width="72" height="60" background="/admin_mode/image/topm41.gif" align="center" style="padding-top:35px"><a href="/admin_mode/game/" class="menu" >경기관리</a></td>
                <td width="72" height="60" background="/admin_mode/image/topm51.gif" align="center" style="padding-top:35px"><a href="/admin_mode/board/?db_name=일반게시판" class="menu" >게시판관리</a></td>
			
                <!--td width="72" height="60"  align="center" style="padding-top:35px" background="/admin_mode/image/topm31.gif"><a href="/admin_mode/school" class="menu" >학교관리</a></td-->                
				</tr>
          </table></td>
		  <td width="34%" valign="bottom" align="center">
		  <iframe src='/admin_mode/ip.php' style='width:250px;height:25px;border:0px' scrolling=no frameborder=0></iframe>
		  </td>
		  <td width="17%" valign="bottom" style="padding-bottom:5px"> <a href="/" target="_blank">  바로가기</a> | <a href="/admin_mode/logout.php">로그아웃</a> &nbsp;</td>
        </tr>
    </table></td>
  </tr>
  </table>
  </td>
 </tr>
</table>
<!-- 로고 및 상단 메뉴 -->
<!-- 상단 이미지 -->
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="000000">
 <tr>
  <td>
  <table width="950" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" bgcolor="000000"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="175">&nbsp;</td>
          <td class="fcolorWhite"></td>
        </tr>
    </table></td>
  </tr>

  </table>
  </td>
 </tr>
</table><!-- 상단 이미지 -->
<!-- 페이지 내용 -->
<table width="100%"  border="0" cellpadding="0" cellspacing="0" >
 <tr>
  <td>
<table width="950" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="100%" valign="top"><table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="170" height="500" background="/admin_mode/image/left_bg.gif" valign="top">
		  <!-- 좌측 메뉴 -->
		  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="45" background="imgae/leftm_bg.gif" style="padding-left:20px" class="sub_menu_left"> 게임관리</td>
              </tr>
              <tr>
                <td align="right"><table width="96%"  border="0" cellpadding="5" cellspacing="1" bgcolor="D9D9D9"> 
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin_mode/image/leftm_icon.gif" width="9" height="9"><a href="/admin_mode/game/1x2game.php"> 경기관리 - 승무패</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin_mode/image/leftm_icon.gif" width="9" height="9"><a href="/admin_mode/game/hcgame.php?handitype=handicap"> 경기관리 - (야구)핸디캡</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin_mode/image/leftm_icon.gif" width="9" height="9"><a href="/admin_mode/game/hcgame_SC.php?handitype=handicap_SC"> 경기관리 - (축구)핸디캡</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin_mode/image/leftm_icon.gif" width="9" height="9"><a href="/admin_mode/game/bat.php"> 배팅관리</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin_mode/image/leftm_icon.gif" width="9" height="9"><a href="/admin_mode/game/calc.php"> 정산관리</a></td>
    </tr>
	<!--
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin_mode/image/leftm_icon.gif" width="9" height="9"><a href="/admin_mode/game/time.php"> 배팅시간입력</a></td>
    </tr>
	-->
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin_mode/image/leftm_icon.gif" width="9" height="9"><a href="/admin_mode/game/"> 리그관리</a></td>
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
                    <td height="30" background="/admin_mode/image/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 배팅관리</td>
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
		var d=document.regist;
		if(!d.tbl_cat_idx.value) { alert('리그명을 입력하세요'); d.tbl_cat_idx.focus(); return false; }
		if(!d.gamedate.value) { alert('게시일을 선택하세요'); d.gamedate.focus(); return false; }
		if(!d.gametime.value) { alert('경기 시작 시각(일자)을 선택하세요'); d.gametime.focus(); return false; }
		if(!d.gametime2.value) { alert('경기 시작 시각(시)을 선택하세요'); d.gametime2.focus(); return false; }
		if(!d.gametime3.value) { alert('경기 시작 시각(분)을 선택하세요'); d.gametime3.focus(); return false; }
		if(!d.a1.value) { alert('홈팀명을 입력하세요'); d.a1.focus(); return false; }
		if(!d.a1_by.value) { alert('홈팀 배당률을 입력하세요'); d.a1_by.focus(); return false; }
		if(!d.x_by.value) { alert('무승부 배당률을 입력하세요'); d.x_by.focus(); return false; }
		if(!d.a2.value) { alert('원정팀명을 입력하세요'); d.a2.focus(); return false; }
		if(!d.a2_by.value) { alert('원정팀 배당률을 입력하세요'); d.a2_by.focus(); return false; }
		d.action='/admin_mode/game/bat.php';
		d.submit();
	}

	function delIT() {
		if(confirm('해당 정보를 삭제하시겠습니까?')) {
			location='/admin_mode/game/bat.php?mode=del_exe&idx=&page=&page_list=&search=&kwd=&type=';
		}
		else {
			return false;
		}
	}

	function stIT() {
		var d=document.game;
		var chk = 0;
		for(i=0;i<d.elements.length;i++) {
			if(d.elements[i].checked==true) { chk++; }
		}

		if(!chk) { alert('정산하실 배팅을 선택하세요'); return; }

		if(confirm('정산 처리 하시겠습니까?')) {
			d.action='/admin_mode/game/bat.php?mode=update_exe';
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
				if(d.elements[i].disabled==false) {
					d.elements[i].checked=true;
				}
			}
			else {
				if(d.elements[i].disabled==false) {
					d.elements[i].checked=false;
				}
			}
		}
	}

	function cancelIT() {
		var d=document.game;
		var chk = 0;
		for(i=0;i<d.elements.length;i++) {
			if(d.elements[i].checked==true) { chk++; }
		}

		if(!chk) { alert('취소하실 배팅을 선택하세요'); return; }

		if(confirm('취소 처리 하시겠습니까?\n\n\n\취소하시면 배팅금액은 환불됩니다.')) {
			d.action='/admin_mode/game/bat.php?mode=cancel_exe';
			d.submit();
		}
		else {
			return;
		}
	}


</SCRIPT>
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">                      
							<form method='post' name='search' action='/admin_mode/game/bat.php'>
						 <tr>
                          <td align='left' height=30>
						  	게임종류
						<select name='gametype' onChange='this.form.submit()'>
						<option value='' selected>전체</option>
						<option value='1x2' >프로토</option>
						<option value='handicap' >(야구)핸디캡</option>
                        <option value='handicap_SC' >(축구)핸디캡</option>
						</select>
						 리그명
						 <select name='tbl_cat_idx'>
						 <option value=''>전체</option>
						 						<option value='30' > Fre. National Cup </option>
												<option value='38' >A 매치</option>
												<option value='28' >Aus.내셔널싸커</option>
												<option value='21' >Aus.막스분데스</option>
												<option value='19' >Bel.주필러리그</option>
												<option value='42' >Bel.트위드클라쎄</option>
												<option value='48' >Cze.2nd League</option>
												<option value='25' >Cze.감부리누스</option>
												<option value='16' >Dan. 슈퍼리가엔</option>
												<option value='37' >Eng. 프리미어</option>
												<option value='40' >Eng.League Two</option>
												<option value='34' >Euro U21 Qualifiers</option>
												<option value='35' >Fin. League2</option>
												<option value='2' >Fin.베이카우스</option>
												<option value='44' >Fre. Fa Cup</option>
												<option value='14' >Fre.르샹피오나</option>
												<option value='3' >Ger.분데스리가</option>
												<option value='22' >Gre.내셔널리그</option>
												<option value='49' >Hun.스포르니</option>
												<option value='39' >Ire. 프리미어</option>
												<option value='46' >Ita. Fa Cup</option>
												<option value='31' >Ita. FA Cup</option>
												<option value='6' >Ita.세리에A</option>
												<option value='17' >J-League</option>
												<option value='43' >Jp. Cup</option>
												<option value='36' >Jpn.Kirin Cup</option>
												<option value='7' >K-League</option>
												<option value='9' >KBO</option>
												<option value='8' >MLB</option>
												<option value='45' >NBA</option>
												<option value='11' >Net.에레디비지</option>
												<option value='18' >Nor.엘리트세리..</option>
												<option value='10' >NPB</option>
												<option value='15' >por.엑스트라...</option>
												<option value='20' >Por.프리메이라</option>
												<option value='26' >Rom.디비지아A</option>
												<option value='13' >Rus.프리미어</option>
												<option value='29' >Ser.슈퍼리가</option>
												<option value='47' >Sing.League</option>
												<option value='33' >Spa. 세군다2부</option>
												<option value='4' >Spa.프리메라</option>
												<option value='50' >Svk.코르곤</option>
												<option value='41' >Swe.슈페르탄</option>
												<option value='23' >Swe.알스벤스칸</option>
												<option value='24' >Swi.나치오날A</option>
												<option value='12' >Tur.슈퍼리가</option>
												<option value='27' >Usa.MLS</option>
												 </select>

						 경기일자 <input type='text' name='sdate'value='' size=10 readonly onClick="popUpCalendar(this,sdate,'yyyy-mm-dd');" style="cursor:hand">

						 회원아이디 <input type='text' name='kwd' value='' size=12>
						 <input type='submit' value='검 색'>
						  </td>
                        </tr>  
						<tr>
							<td>
								<font color='#FFFF00'> ■ </font>(야구)핸디캡 경기 / <font color='#D0EFFF'> ■ </font>(축구)핸디캡 경기 / □ 프로토 경기
								</td>
							</tr>
						</tr>
						</form>
						<form method='post' name='game'>
						<tr>
							<td colspan='3'>
							<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
                              <tr align="center" bgcolor="#E4E4E4">
								<td></td>
								<td width=5%>번호</td>
								<td>아이디</td>
								<td>경기시간</td>
								<td>배팅시간</td>
								<td>홈팀</td>
								<td>x/핸디캡</td>
								<td>원정팀</td>
								<td>유저배팅</td>
								<td>배팅금액</td>
								<td>경기결과</td>
							  </tr>
							 
	
                              <tr align='center' bgcolor='#ffffff'>
								<td rowspan='1'><input type='checkbox' name='groupno[]' value='2008052700413686719420483ada30c65d5'></td>								<td width=5%><font color='#000000'>7</td>
								<td><font color='#000000'>181818</a></td>
								<td><font color='#000000'>08-05-27 19:20</td>
								<td><font color='#000000'>08-05-27 00:41</td>
								<td><font color='#000000'>일본 (1.85)</td>
																								
								<td><font color='#000000'>2.8</td>
																<td><font color='#000000'>파라과이 (2.25)</td>
								<td><font color='#000000'>1</td>
								<td><font color='#000000'>1,000,000</td>
								<td><font color='#000000'><B></b>(N)<BR></td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=100% colspan='11'>
								배당률 : 1.85&nbsp; /&nbsp; 배팅금액 : 1,000,000&nbsp; / 당첨금액 : 0 원
								</td>
							</tr>

	
                              <tr align='center' bgcolor='#ffffff'>
								<td rowspan='3'><input type='checkbox' name='groupno[]' value='2008052700414814972115485026483ada3c62ea3'></td>								<td width=5%><font color='#000000'>6</td>
								<td><font color='#000000'>ori7907</a></td>
								<td><font color='#000000'>08-05-27 02:00</td>
								<td><font color='#000000'>08-05-27 00:41</td>
								<td><font color='#000000'>랜드스코로나 (1.7)</td>
																								
								<td><font color='#000000'>2.9</td>
																<td><font color='#000000'>오그리테 (3.2)</td>
								<td><font color='#000000'>1</td>
								<td><font color='#000000'>100,000</td>
								<td><font color='#000000'><B></b>(N)<BR></td>
							  </tr>
	
                              <tr align='center' bgcolor='#ffffff'>
																<td width=5%><font color='#000000'>6</td>
								<td><font color='#000000'>ori7907</a></td>
								<td><font color='#000000'>08-05-27 01:00</td>
								<td><font color='#000000'>08-05-27 00:41</td>
								<td><font color='#000000'>REAC버다페스트 (6)</td>
																								
								<td><font color='#000000'>3.5</td>
																<td><font color='#000000'>버다페스트MTK (1.3)</td>
								<td><font color='#000000'>2</td>
								<td><font color='#000000'>100,000</td>
								<td><font color='#000000'><B></b>(N)<BR></td>
							  </tr>
	
                              <tr align='center' bgcolor='#ffffff'>
																<td width=5%><font color='#000000'>6</td>
								<td><font color='#000000'>ori7907</a></td>
								<td><font color='#000000'>08-05-27 00:55</td>
								<td><font color='#000000'>08-05-27 00:41</td>
								<td><font color='#000000'>프라하 (1.65)</td>
																								
								<td><font color='#000000'>2.9</td>
																<td><font color='#000000'>풀넥 (3.1)</td>
								<td><font color='#000000'>1</td>
								<td><font color='#000000'>100,000</td>
								<td><font color='#000000'><B></b>(N)<BR></td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=100% colspan='11'>
								배당률 : 3.65&nbsp; /&nbsp; 배팅금액 : 100,000&nbsp; / 당첨금액 : 0 원
								</td>
							</tr>

	
                              <tr align='center' bgcolor='#ffffff'>
								<td rowspan='1'><input type='checkbox' name='groupno[]' value='2008052700411220591566483ada181e849'></td>								<td width=5%><font color='#000000'>5</td>
								<td><font color='#000000'>181818</a></td>
								<td><font color='#000000'>08-05-27 03:00</td>
								<td><font color='#000000'>08-05-27 00:41</td>
								<td><font color='#000000'>폴란드 (1.21)</td>
																								
								<td><font color='#000000'>3.3</td>
																<td><font color='#000000'>마케도니아 (6)</td>
								<td><font color='#000000'>1</td>
								<td><font color='#000000'>1,000,000</td>
								<td><font color='#000000'><B></b>(N)<BR></td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=100% colspan='11'>
								배당률 : 1.21&nbsp; /&nbsp; 배팅금액 : 1,000,000&nbsp; / 당첨금액 : 0 원
								</td>
							</tr>

	
                              <tr align='center' bgcolor='#ffffff'>
								<td rowspan='2'><input type='checkbox' name='groupno[]' value='20080527004114797150797784483ada1ac432d'></td>								<td width=5%><font color='#000000'>4</td>
								<td><font color='#000000'>ori7907</a></td>
								<td><font color='#000000'>08-05-27 01:00</td>
								<td><font color='#000000'>08-05-27 00:41</td>
								<td><font color='#000000'>바사 (2.4)</td>
																								
								<td><font color='#000000'>3.1</td>
																<td><font color='#000000'>템페레 (1.9)</td>
								<td><font color='#000000'>X</td>
								<td><font color='#000000'>50,000</td>
								<td><font color='#000000'><B></b>(N)<BR></td>
							  </tr>
	
                              <tr align='center' bgcolor='#ffffff'>
																<td width=5%><font color='#000000'>4</td>
								<td><font color='#000000'>ori7907</a></td>
								<td><font color='#000000'>08-05-27 00:55</td>
								<td><font color='#000000'>08-05-27 00:41</td>
								<td><font color='#000000'>프라하 (1.65)</td>
																								
								<td><font color='#000000'>2.9</td>
																<td><font color='#000000'>풀넥 (3.1)</td>
								<td><font color='#000000'>1</td>
								<td><font color='#000000'>50,000</td>
								<td><font color='#000000'><B></b>(N)<BR></td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=100% colspan='11'>
								배당률 : 5.12&nbsp; /&nbsp; 배팅금액 : 50,000&nbsp; / 당첨금액 : 0 원
								</td>
							</tr>

	
                              <tr align='center' bgcolor='#ffffff'>
								<td rowspan='1'><input type='checkbox' name='groupno[]' value='20080527004044465916032483ad9fc40d99'></td>								<td width=5%><font color='#000000'>3</td>
								<td><font color='#000000'>181818</a></td>
								<td><font color='#000000'>08-05-27 03:00</td>
								<td><font color='#000000'>08-05-27 00:41</td>
								<td><font color='#000000'>스웨덴 (1.2)</td>
																								
								<td><font color='#000000'>3.3</td>
																<td><font color='#000000'>슬로베니아 (6)</td>
								<td><font color='#000000'>1</td>
								<td><font color='#000000'>1,000,000</td>
								<td><font color='#000000'><B></b>(N)<BR></td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=100% colspan='11'>
								배당률 : 1.20&nbsp; /&nbsp; 배팅금액 : 1,000,000&nbsp; / 당첨금액 : 0 원
								</td>
							</tr>

	
                              <tr align='center' bgcolor='#ffffff'>
								<td rowspan='2'><input type='checkbox' name='groupno[]' value='200805270040468110373793638483ad9fe7c6b4'></td>								<td width=5%><font color='#000000'>2</td>
								<td><font color='#000000'>ori7907</a></td>
								<td><font color='#000000'>08-05-27 01:00</td>
								<td><font color='#000000'>08-05-27 00:40</td>
								<td><font color='#000000'>바사 (2.4)</td>
																								
								<td><font color='#000000'>3.1</td>
																<td><font color='#000000'>템페레 (1.9)</td>
								<td><font color='#000000'>1</td>
								<td><font color='#000000'>100,000</td>
								<td><font color='#000000'><B></b>(N)<BR></td>
							  </tr>
	
                              <tr align='center' bgcolor='#ffffff'>
																<td width=5%><font color='#000000'>2</td>
								<td><font color='#000000'>ori7907</a></td>
								<td><font color='#000000'>08-05-27 00:55</td>
								<td><font color='#000000'>08-05-27 00:40</td>
								<td><font color='#000000'>프라하 (1.65)</td>
																								
								<td><font color='#000000'>2.9</td>
																<td><font color='#000000'>풀넥 (3.1)</td>
								<td><font color='#000000'>1</td>
								<td><font color='#000000'>100,000</td>
								<td><font color='#000000'><B></b>(N)<BR></td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=100% colspan='11'>
								배당률 : 3.96&nbsp; /&nbsp; 배팅금액 : 100,000&nbsp; / 당첨금액 : 0 원
								</td>
							</tr>

	
                              <tr align='center' bgcolor='#ffffff'>
								<td rowspan='2'><input type='checkbox' name='groupno[]' value='20080527003912041920178483ad9a007a12'></td>								<td width=5%><font color='#000000'>1</td>
								<td><font color='#000000'>181818</a></td>
								<td><font color='#000000'>08-05-27 03:00</td>
								<td><font color='#000000'>08-05-27 00:39</td>
								<td><font color='#000000'>폴란드 (1.21)</td>
																								
								<td><font color='#000000'>3.3</td>
																<td><font color='#000000'>마케도니아 (6)</td>
								<td><font color='#000000'>1</td>
								<td><font color='#000000'>1,000,000</td>
								<td><font color='#000000'><B></b>(N)<BR></td>
							  </tr>
	
                              <tr align='center' bgcolor='#ffffff'>
																<td width=5%><font color='#000000'>1</td>
								<td><font color='#000000'>181818</a></td>
								<td><font color='#000000'>08-05-27 03:00</td>
								<td><font color='#000000'>08-05-27 00:39</td>
								<td><font color='#000000'>스웨덴 (1.2)</td>
																								
								<td><font color='#000000'>3.3</td>
																<td><font color='#000000'>슬로베니아 (6)</td>
								<td><font color='#000000'>1</td>
								<td><font color='#000000'>1,000,000</td>
								<td><font color='#000000'><B></b>(N)<BR></td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=100% colspan='11'>
								배당률 : 1.45&nbsp; /&nbsp; 배팅금액 : 1,000,000&nbsp; / 당첨금액 : 0 원
								</td>
							</tr>



							
                          </table></td>
                        </tr>
                        <tr>
                          <td align='center' height=50>
						 &nbsp;<b>1</b>&nbsp;&nbsp;						  </td>
						  <td align='right'>
						  <input type='button' value='배팅취소' onClick='cancelIT()'>
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
<!-- 하단 copy -->

  <table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="5" bgcolor="CDCDCD"> </td>
  </tr>
  <tr>
    <td height="40" align="center" bgcolor="E7E7E7">Copyright ⓒ 2008 <b>bwin-Kor</b> All rights reserved.</td>
  </tr>
  </table>
<!-- 하단 copy-->
</body>
</html>
