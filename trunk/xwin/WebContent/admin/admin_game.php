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
<table width="1200" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="100%" valign="top"><table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="170" height="500" background="/admin_mode/image/left_bg.gif" valign="top">
		  <!-- 좌측 메뉴 -->
		  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="45" background="imgae/leftm_bg.gif" style="padding-left:20px" class="sub_menu_left"> 경기관리</td>
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
		var d=document.regist;
		if(!d.tbl_cat_idx.value) { alert('리그명을 입력하세요'); d.tbl_cat_idx.focus(); return false; }
		if(!d.gamedate.value) { alert('게시일을 선택하세요'); d.gamedate.focus(); return false; }f
		if(!d.gametime.value) { alert('경기 시작 시각(일자)을 선택하세요'); d.gametime.focus(); return false; }
		if(!d.gametime2.value) { alert('경기 시작 시각(시)을 선택하세요'); d.gametime2.focus(); return false; }
		if(!d.gametime3.value) { alert('경기 시작 시각(분)을 선택하세요'); d.gametime3.focus(); return false; }
		if(!d.gametime4.value) { alert('경기 시작 시각(초)을 선택하세요'); d.gametime4.focus(); return false; }
		if(!d.a1.value) { alert('홈팀명을 입력하세요'); d.a1.focus(); return false; }
		if(!d.a1_by.value) { alert('홈팅 배당률을 입력하세요'); d.a1_by.focus(); return false; }
		if(d.gametype_set.value=='1x2') {
			if(!d.x_by.value) { alert('무승부 배당률을 입력하세요'); d.x_by.focus(); return false; }
		}
		else {
			if(!d.handicap_title.value) { alert('핸디캡을 입력하세요'); return false; }
		}
		if(!d.a2.value) { alert('원정팀명을 입력하세요'); d.a2.focus(); return false; }
		if(!d.a2_by.value) { alert('원정팀명 배당률을 입력하세요'); d.a2_by.focus(); return false; }
		d.action='/admin_mode/game/1x2game.php';
	//	d.submit();
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
                          <td height="30"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td> * 게임정보를 조회하시거나 수정 , 삭제 하실 수 있습니다.</td>
                                <td align="right"><a href='/admin_mode/game/1x2game.php?mode=write&handitype=1x2&gametype=1x2'><img src='/admin_mode/image/but_input.gif' border=0></a></td>
                              </tr>
                          </table></td>
                        </tr>
							<form method='post' name='search' action='/admin_mode/game/1x2game.php'>
						 <tr>
                          <td align='left' height=30>
						  <!--
						  게임종류
						<select name='gametype' onChange='this.form.submit()'>
						<option value='' >전체</option>
						<option value='1x2' selected>1x2</option>
						<option value='handicap' >핸디캡</option>
						</select>
						-->
						리그명
						<select name='tbl_cat_idx' onChange='this.form.submit()'>
						<option value='' selected>전체</option>
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
						 <select name='search'>
						 <option value='a1' >홈팀명</option>
						 <option value='a2' >원정팀명</option>
						 </select>
						 <input type='text' name='kwd' value=''>
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
							 <form method='post' name='game'>
						<tr>
							<td colspan='3'>
							<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
                              <tr align="center" bgcolor="#E4E4E4">
								<td width=5%><a onClick="allcheck()" style='cursor:hand'><input type='checkbox' name='ac'></a></td>
								<td width=5%>번호</td>
								<td>리그명</td>
								<td>일자</td>
								<td>경기시간</td>
								<td>홈팀</td>
								<td>원정팀</td>
								<td>승</td>
								<td>
								무</td>
								<td>패</td>
								<td>결과</td>
								<td>스코어</td>
								<td>상태</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%><input type='checkbox' name='idx[]' value='298'></td>
								<td width=5%>77</td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=298&page=1&page_list=1&search=&kwd=&type='>A 매치</a></td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=298&page=1&page_list=1&search=&kwd=&type='>2008-09-23</td>
								<td>2008-09-25 00:00:00</td>
								<td>dddd</td>
								<td>xxxx</td>
								<td>2<BR><B>배팅 : 0원</B></td>
								<td>
																
								2<BR><B>배팅 : 0원</B>
																</td>
								<td>3<BR><B>배팅 : 0원</B>
								</td>
								<td>
								승								</td>
								<td>
																								2:1																</td>
								<td>E</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%><input type='checkbox' name='idx[]' value='297'></td>
								<td width=5%>76</td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=297&page=1&page_list=1&search=&kwd=&type='> Fre. National Cup </a></td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=297&page=1&page_list=1&search=&kwd=&type='>2008-09-24</td>
								<td>2008-09-25 10:00:00</td>
								<td>dd</td>
								<td>xx</td>
								<td>1.5<BR><B>배팅 : 0원</B></td>
								<td>
																
								1.3<BR><B>배팅 : 0원</B>
																</td>
								<td>1.4<BR><B>배팅 : 0원</B>
								</td>
								<td>
								무								</td>
								<td>
																								2:2																</td>
								<td>E</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%><input type='checkbox' name='idx[]' value='295'></td>
								<td width=5%>75</td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=295&page=1&page_list=1&search=&kwd=&type='>Spa. 세군다2부</a></td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=295&page=1&page_list=1&search=&kwd=&type='>2008-05-26</td>
								<td>2008-05-26 00:00:00</td>
								<td>코르도바</td>
								<td>누만시아</td>
								<td>2.2<BR><B>배팅 : 0원</B></td>
								<td>
																
								2.9<BR><B>배팅 : 0원</B>
																</td>
								<td>3<BR><B>배팅 : 0원</B>
								</td>
								<td>
								승								</td>
								<td>
																								3:2																</td>
								<td>E</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%><input type='checkbox' name='idx[]' value='294'></td>
								<td width=5%>74</td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=294&page=1&page_list=1&search=&kwd=&type='>Spa. 세군다2부</a></td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=294&page=1&page_list=1&search=&kwd=&type='>2008-05-26</td>
								<td>2008-05-26 01:00:00</td>
								<td>헤라클레스</td>
								<td>라스팔마스</td>
								<td>2<BR><B>배팅 : 0원</B></td>
								<td>
																
								2.9<BR><B>배팅 : 0원</B>
																</td>
								<td>3.3<BR><B>배팅 : 0원</B>
								</td>
								<td>
								패								</td>
								<td>
																								1:2																</td>
								<td>E</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%><input type='checkbox' name='idx[]' value='293'></td>
								<td width=5%>73</td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=293&page=1&page_list=1&search=&kwd=&type='>Spa. 세군다2부</a></td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=293&page=1&page_list=1&search=&kwd=&type='>2008-05-26</td>
								<td>2008-05-26 01:00:00</td>
								<td>폴리데포르티보 에히도</td>
								<td>엘체CF</td>
								<td>1.8<BR><B>배팅 : 0원</B></td>
								<td>
																
								3.1<BR><B>배팅 : 0원</B>
																</td>
								<td>3.4<BR><B>배팅 : 0원</B>
								</td>
								<td>
								승								</td>
								<td>
																								2:0																</td>
								<td>E</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%><input type='checkbox' name='idx[]' value='292'></td>
								<td width=5%>72</td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=292&page=1&page_list=1&search=&kwd=&type='>Spa. 세군다2부</a></td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=292&page=1&page_list=1&search=&kwd=&type='>2008-05-26</td>
								<td>2008-05-26 01:00:00</td>
								<td>SD 에이바르</td>
								<td>세레즈 CD</td>
								<td>1.8<BR><B>배팅 : 0원</B></td>
								<td>
																
								3.1<BR><B>배팅 : 0원</B>
																</td>
								<td>3.35<BR><B>배팅 : 0원</B>
								</td>
								<td>
								무								</td>
								<td>
																								0:0																</td>
								<td>E</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%><input type='checkbox' name='idx[]' value='291'></td>
								<td width=5%>71</td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=291&page=1&page_list=1&search=&kwd=&type='>Spa. 세군다2부</a></td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=291&page=1&page_list=1&search=&kwd=&type='>2008-05-26</td>
								<td>2008-05-26 01:00:00</td>
								<td>카디즈 FC </td>
								<td>힘나스틱 타라고나</td>
								<td>2.2<BR><B>배팅 : 0원</B></td>
								<td>
																
								2.7<BR><B>배팅 : 0원</B>
																</td>
								<td>3.2<BR><B>배팅 : 0원</B>
								</td>
								<td>
								패								</td>
								<td>
																								0:2																</td>
								<td>E</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%><input type='checkbox' name='idx[]' value='290'></td>
								<td width=5%>70</td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=290&page=1&page_list=1&search=&kwd=&type='>Spa. 세군다2부</a></td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=290&page=1&page_list=1&search=&kwd=&type='>2008-05-26</td>
								<td>2008-05-26 01:00:00</td>
								<td>살라망카</td>
								<td>라싱 페롤</td>
								<td>2.15<BR><B>배팅 : 0원</B></td>
								<td>
																
								2.7<BR><B>배팅 : 0원</B>
																</td>
								<td>3.15<BR><B>배팅 : 0원</B>
								</td>
								<td>
								승								</td>
								<td>
																								2:1																</td>
								<td>E</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%><input type='checkbox' name='idx[]' value='289'></td>
								<td width=5%>69</td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=289&page=1&page_list=1&search=&kwd=&type='>Spa. 세군다2부</a></td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=289&page=1&page_list=1&search=&kwd=&type='>2008-05-26</td>
								<td>2008-05-26 03:30:00</td>
								<td>알라베스</td>
								<td>레알스포르팅 데 히혼</td>
								<td>2.8<BR><B>배팅 : 0원</B></td>
								<td>
																
								2.8<BR><B>배팅 : 0원</B>
																</td>
								<td>2.25<BR><B>배팅 : 0원</B>
								</td>
								<td>
								무								</td>
								<td>
																								0:0																</td>
								<td>E</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%><input type='checkbox' name='idx[]' value='288'></td>
								<td width=5%>68</td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=288&page=1&page_list=1&search=&kwd=&type='>A 매치</a></td>
								<td><a href='/admin_mode/game/1x2game.php?mode=read&idx=288&page=1&page_list=1&search=&kwd=&type='>2008-05-26</td>
								<td>2008-05-26 02:15:00</td>
								<td>스웨덴 U21</td>
								<td>포르투칼 U21</td>
								<td>2.55<BR><B>배팅 : 0원</B></td>
								<td>
																
								3<BR><B>배팅 : 0원</B>
																</td>
								<td>2.45<BR><B>배팅 : 0원</B>
								</td>
								<td>
								무								</td>
								<td>
																								0:0																</td>
								<td>E</td>
							  </tr>
					

							
                          </table></td>
                        </tr>
						<tr>
                          <td align='right' height=40>
						  <input type='button' value='승패적용' onClick="upIT()">
						  <input type='button' value='게임삭제' onClick="stIT('D')">
						  <input type='button' value='강제종료' onClick="stIT('N')">
						  <input type='button' value='게임진행' onClick="stIT('Y')">
						  <input type='button' value='배팅차단' onClick="stIT('P')">
						  </td>
						 </tr>
                        <tr>
                          <td align='center' height=50>
						 &nbsp;<b>1</b>&nbsp;<a href='/admin_mode/game/1x2game.php?page=2&page_list=1&&search=&kwd=&sdate=&gametype=1x2&tbl_cat_idx='>[2]</a>&nbsp;<a href='/admin_mode/game/1x2game.php?page=3&page_list=1&&search=&kwd=&sdate=&gametype=1x2&tbl_cat_idx='>[3]</a>&nbsp;<a href='/admin_mode/game/1x2game.php?page=4&page_list=1&&search=&kwd=&sdate=&gametype=1x2&tbl_cat_idx='>[4]</a>&nbsp;<a href='/admin_mode/game/1x2game.php?page=5&page_list=1&&search=&kwd=&sdate=&gametype=1x2&tbl_cat_idx='>[5]</a>&nbsp;<a href='/admin_mode/game/1x2game.php?page=6&page_list=1&&search=&kwd=&sdate=&gametype=1x2&tbl_cat_idx='>[6]</a>&nbsp;<a href='/admin_mode/game/1x2game.php?page=7&page_list=1&&search=&kwd=&sdate=&gametype=1x2&tbl_cat_idx='>[7]</a>&nbsp;<a href='/admin_mode/game/1x2game.php?page=8&page_list=1&&search=&kwd=&sdate=&gametype=1x2&tbl_cat_idx='>[8]</a>&nbsp;&nbsp;						  </td>
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
    <td height="40" align="center" bgcolor="E7E7E7">Copyright ⓒ 2008 <b>CASHBET24</b> All rights reserved.</td>
  </tr>
  </table>
<!-- 하단 copy-->
</body>
</html>
