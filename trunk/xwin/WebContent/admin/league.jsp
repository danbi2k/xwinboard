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
                    <td height="30" background="/admin_mode/image/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 리그관리</td>
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
		if(!d.name.value) { alert('리그명을 입력하세요'); d.name.focus(); return false; }
		d.action='/admin_mode/game/index.php?mode=modify_exe';
		d.submit();
	}

	function delIT() {
		if(confirm('해당 정보를 삭제하시겠습니까?')) {
			location='/admin_mode/game/index.php?mode=del_exe&idx=&page=&page_list=&search=&kwd=&type=';
		}
		else {
			return false;
		}
	}

</SCRIPT>
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td height="30"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td> * 리그를 조회하시거나 수정 , 삭제 하실 수 있습니다.</td>
                                <td align="right"><a href='/admin_mode/game/index.php?mode=write'><img src='/admin_mode/image/but_input.gif' border=0></a></td>
                              </tr>
                          </table></td>
                        </tr>
							<form method='post' name='search' action='/admin_mode/game/index.php'>
						 <tr>
                          <td align='left' height=30>
						 <select name='search'>
						 <option value='name' >리그명</option>
						 </select>
						 <input type='text' name='kwd' value=''>
						 <input type='submit' value='검 색'>
						  </td>
                        </tr>  
						</form>
						<tr>
							<td colspan='3'>
							<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
                              <tr align="center" bgcolor="#E4E4E4">
								<td width=20%>번호</td>
								<td width=20%>이미지</td>
								<td width=80%>리그명</td>
							  </tr>
							 
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>47</td>
								<td width=20%><img src='/upload/cat/50.gif' width='20' height='12' border=0></td>
								<td width=80%><a href='/admin_mode/game/index.php?mode=read&idx=50&page=1&page_list=1&search=&kwd=&type='>Svk.코르곤</a></td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>46</td>
								<td width=20%><img src='/upload/cat/49.gif' width='20' height='12' border=0></td>
								<td width=80%><a href='/admin_mode/game/index.php?mode=read&idx=49&page=1&page_list=1&search=&kwd=&type='>Hun.스포르니</a></td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>45</td>
								<td width=20%><img src='/upload/cat/48.gif' width='20' height='12' border=0></td>
								<td width=80%><a href='/admin_mode/game/index.php?mode=read&idx=48&page=1&page_list=1&search=&kwd=&type='>Cze.2nd League</a></td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>44</td>
								<td width=20%><img src='/upload/cat/47.gif' width='20' height='12' border=0></td>
								<td width=80%><a href='/admin_mode/game/index.php?mode=read&idx=47&page=1&page_list=1&search=&kwd=&type='>Sing.League</a></td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>43</td>
								<td width=20%><img src='/upload/cat/46.gif' width='20' height='12' border=0></td>
								<td width=80%><a href='/admin_mode/game/index.php?mode=read&idx=46&page=1&page_list=1&search=&kwd=&type='>Ita. Fa Cup</a></td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>42</td>
								<td width=20%><img src='/upload/cat/45.gif' width='20' height='12' border=0></td>
								<td width=80%><a href='/admin_mode/game/index.php?mode=read&idx=45&page=1&page_list=1&search=&kwd=&type='>NBA</a></td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>41</td>
								<td width=20%><img src='/upload/cat/44.gif' width='20' height='12' border=0></td>
								<td width=80%><a href='/admin_mode/game/index.php?mode=read&idx=44&page=1&page_list=1&search=&kwd=&type='>Fre. Fa Cup</a></td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>40</td>
								<td width=20%><img src='/upload/cat/43.gif' width='20' height='12' border=0></td>
								<td width=80%><a href='/admin_mode/game/index.php?mode=read&idx=43&page=1&page_list=1&search=&kwd=&type='>Jp. Cup</a></td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>39</td>
								<td width=20%><img src='/upload/cat/42.gif' width='20' height='12' border=0></td>
								<td width=80%><a href='/admin_mode/game/index.php?mode=read&idx=42&page=1&page_list=1&search=&kwd=&type='>Bel.트위드클라쎄</a></td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>38</td>
								<td width=20%><img src='/upload/cat/41.gif' width='20' height='12' border=0></td>
								<td width=80%><a href='/admin_mode/game/index.php?mode=read&idx=41&page=1&page_list=1&search=&kwd=&type='>Swe.슈페르탄</a></td>
							  </tr>
					

							
                          </table></td>
                        </tr>
                        <tr>
                          <td align='center' height=50>
						 &nbsp;<b>1</b>&nbsp;<a href='/admin_mode/game/index.php?page=2&page_list=1&&search=&kwd='>[2]</a>&nbsp;<a href='/admin_mode/game/index.php?page=3&page_list=1&&search=&kwd='>[3]</a>&nbsp;<a href='/admin_mode/game/index.php?page=4&page_list=1&&search=&kwd='>[4]</a>&nbsp;<a href='/admin_mode/game/index.php?page=5&page_list=1&&search=&kwd='>[5]</a>&nbsp;&nbsp;						  </td>
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
