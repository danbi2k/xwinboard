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
                <td height="45" background="imgae/leftm_bg.gif" style="padding-left:20px" class="sub_menu_left"> 회원관리</td>
              </tr>
              <tr>
                <td align="right"><table width="96%"  border="0" cellpadding="5" cellspacing="1" bgcolor="D9D9D9"> 
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin_mode/image/leftm_icon.gif" width="9" height="9"><a href="/admin_mode/member/"> 회원관리</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin_mode/image/leftm_icon.gif" width="9" height="9"><a href="/admin_mode/member/login_status.php"> 로그인현황</a></td>
    </tr>
	<!--tr>
		<td bgcolor="#FFFFFF"><img src="/admin_mode/image/leftm_icon.gif" width="9" height="9"><a href="/admin_mode/member/contents.php"> 컨텐츠관리</a></td>
    </tr-->
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
                    <td height="30" background="/admin_mode/image/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 회원관리</td>
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
		if(!d.passwd.value) { alert('비밀번호를 입력하세요'); d.passwd.focus(); return false; }
		d.action='/admin_mode/member/index.php?mode=modify_exe';
		d.submit();
	}

	function delIT(userid) {
		if(confirm('해당 정보를 삭제하시겠습니까?')) {
			location='/admin_mode/member/index.php?mode=del_exe&userid='+userid+'&page=&page_list=&search=&kwd=&type=';
		}
		else {
			return false;
		}
	}


	function chargeIT() {
		var d=document.charge;
		if(!d.amt.value) { alert('금액을 입력하세요'); d.amt.focus(); return false; }
		if(!d.msg.value) { alert('내역을 입력하세요'); d.msg.focus(); return false; }
		if(!confirm('금액을 충전/삭감 하시겠습니까?')) {
			return false;
		}
		else {
			d.action='/admin_mode/member/index.php?mode=recharge&userid=&page=&page_list=&search=&kwd=&type=';
		}
	}


</SCRIPT>
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td height="30"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td> * 관리자정보를 조회하시거나 수정 , 삭제 하실 수 있습니다.</td>
                                <td align="right"></td>
                              </tr>
                          </table></td>
                        </tr>
							<form method='post' name='search' action='/admin_mode/member/index.php'>
						 <tr>
                          <td align='left' height=30>
						  <select name='memtype' onChange='this.form.submit()'>
						  <option value='' selected>전체</option>
						  <option value='normal' >일반</option>
						  <option value='vip' >VIP</option>
						  </select>
						 <select name='search'>
						 <option value='userid' >회원아이디</option>
						 <option value='nickname' >회원닉네임</option>
						 <option value='hp' >휴대전화</option>
						 <option value='email' >EMAIL</option>
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
								<td width=5%>번호</td>
								<td width=10%>회원종류</td>
								<td width=10%>아이디</td>
								<td width=15%>닉네임</td>
								<td width=10%>보유금액</td>
								<td width=15%>휴대전화</td>
								<td width=20%>EMAIL</td>
								<td width=15%>가입일</td>
							  </tr>
							 
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>14</td>
								<td width=10%>일반</td>
								<td width=10%><a href='/admin_mode/member/index.php?mode=read&userid=ori7907&page=1&page_list=1&search=&kwd=&type=&memtype=normal'>ori7907</a></td>
								<td width=15%>TOTO J</td>
								<td width=10%>251,111</td>
								<td width=15%>010-5673-3321</td>
								<td width=20%>ewt32@yahoo.co.kr</td>
								<td width=15%>2008-05-27 00:35:12</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>13</td>
								<td width=10%>일반</td>
								<td width=10%><a href='/admin_mode/member/index.php?mode=read&userid=181818&page=1&page_list=1&search=&kwd=&type=&memtype=normal'>181818</a></td>
								<td width=15%>일지매</td>
								<td width=10%>1,000,000</td>
								<td width=15%>011-234-5522</td>
								<td width=20%>fkfdkldkl@hanmail.net</td>
								<td width=15%>2008-05-26 21:11:31</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>12</td>
								<td width=10%>일반</td>
								<td width=10%><a href='/admin_mode/member/index.php?mode=read&userid=alltt&page=1&page_list=1&search=&kwd=&type=&memtype=normal'>alltt</a></td>
								<td width=15%>alltt</td>
								<td width=10%>0</td>
								<td width=15%>010-111-1111</td>
								<td width=20%>alltt@netian.com</td>
								<td width=15%>2008-05-26 18:42:42</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>11</td>
								<td width=10%>일반</td>
								<td width=10%><a href='/admin_mode/member/index.php?mode=read&userid=개똥이1&page=1&page_list=1&search=&kwd=&type=&memtype=normal'>개똥이1</a></td>
								<td width=15%>개똥이1</td>
								<td width=10%>0</td>
								<td width=15%>010-123-123</td>
								<td width=20%>123@yahoo.co.kr</td>
								<td width=15%>2008-05-26 16:37:40</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>10</td>
								<td width=10%>일반</td>
								<td width=10%><a href='/admin_mode/member/index.php?mode=read&userid=개똥이&page=1&page_list=1&search=&kwd=&type=&memtype=normal'>개똥이</a></td>
								<td width=15%>개똥이</td>
								<td width=10%>2,280,000</td>
								<td width=15%>010-123-123</td>
								<td width=20%>123@yahoo.co.kr</td>
								<td width=15%>2008-05-26 16:36:40</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>9</td>
								<td width=10%>일반</td>
								<td width=10%><a href='/admin_mode/member/index.php?mode=read&userid=zxcvb&page=1&page_list=1&search=&kwd=&type=&memtype=normal'>zxcvb</a></td>
								<td width=15%>토토신</td>
								<td width=10%>0</td>
								<td width=15%>011-9964-7411</td>
								<td width=20%>atfrt@fretgerdg</td>
								<td width=15%>2008-05-25 17:54:56</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>8</td>
								<td width=10%>일반</td>
								<td width=10%><a href='/admin_mode/member/index.php?mode=read&userid=ori7903&page=1&page_list=1&search=&kwd=&type=&memtype=normal'>ori7903</a></td>
								<td width=15%>빠라디자인</td>
								<td width=10%>0</td>
								<td width=15%>016-2345-2465</td>
								<td width=20%>rytjwe4256@hanmail.net</td>
								<td width=15%>2008-05-25 17:54:29</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>7</td>
								<td width=10%>일반</td>
								<td width=10%><a href='/admin_mode/member/index.php?mode=read&userid=12qwaszx&page=1&page_list=1&search=&kwd=&type=&memtype=normal'>12qwaszx</a></td>
								<td width=15%>최강베팅</td>
								<td width=10%>1,000,000</td>
								<td width=15%>011-9964-7411</td>
								<td width=20%>atfrt@fsdgfedgdr</td>
								<td width=15%>2008-05-25 17:52:07</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>6</td>
								<td width=10%>일반</td>
								<td width=10%><a href='/admin_mode/member/index.php?mode=read&userid=12345&page=1&page_list=1&search=&kwd=&type=&memtype=normal'>12345</a></td>
								<td width=15%>럭셔리토토</td>
								<td width=10%>0</td>
								<td width=15%>011-9964-7411</td>
								<td width=20%>atfrt@sdfdsgf</td>
								<td width=15%>2008-05-25 17:50:39</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>5</td>
								<td width=10%>일반</td>
								<td width=10%><a href='/admin_mode/member/index.php?mode=read&userid=ori7906&page=1&page_list=1&search=&kwd=&type=&memtype=normal'>ori7906</a></td>
								<td width=15%>운영자</td>
								<td width=10%>0</td>
								<td width=15%>010-5683-5683</td>
								<td width=20%>ewuyg4@hanmail.net</td>
								<td width=15%>2008-05-25 17:50:22</td>
							  </tr>
					

							
                          </table></td>
                        </tr>
                        <tr>
                          <td align='center' height=50>
						 &nbsp;<b>1</b>&nbsp;<a href='/admin_mode/member/index.php?page=2&page_list=1&&search=&kwd=&memtype='>[2]</a>&nbsp;&nbsp;						  </td>
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
