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
                <td height="45" background="imgae/leftm_bg.gif" style="padding-left:20px" class="sub_menu_left"> 관리자정보</td>
              </tr>
              <tr>
                <td align="right"><table width="96%"  border="0" cellpadding="5" cellspacing="1" bgcolor="D9D9D9"> 
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin_mode/image/leftm_icon.gif" width="9" height="9"><a href="/admin_mode/admin"> 관리자정보관리</a></td>
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
                    <td height="30" background="/admin_mode/image/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 관리자정보관리</td>
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
<!--
		function checkIT() {
		var d=document.regist;
		if(!d.passwd.value) { alert('비밀번호를 입력하세요'); d.passwd.focus(); return false; }
		d.action='/admin_mode/admin/index.php?mode=modify_exe';
		d.submit();
	}
//-->
</SCRIPT>
		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td height="30"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td> * 관리자정보를 수정 하실 수 있습니다.</td>
                                <td align="right"></td>
                              </tr>
                          </table></td>
                        </tr>
						<form method=post name='regist' onSubmit="return checkIT()" action='/admin_mode/admin/index.php' enctype="multipart/form-data">
                        <tr>
							<td height=30 colspan='3' align='right'></td>
						</tr>
						<tr>
							<td colspan='3'>
							<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
                              <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=20%>관리자아이디</td>
								<td width=80% bgcolor='#ffffff' align='left'>admin								</td>
							  </tr>	
							  <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=20%>관리자명</td>
								<td width=80% bgcolor='#ffffff' align='left'><input type='text' name='name' value='관리자'>
								</td>
							  </tr>	
						     <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=20%>비밀번호</td>
								<td width=80% bgcolor='#ffffff' align='left'><input type='text' name='passwd' value='1234'>
								</td>
							  </tr>							 
							  <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=20%>EMAIL</td>
								<td width=80% bgcolor='#ffffff' align='left'><input type='email' size='40' name='email' value='proto@proto.co.kr'></a>
								</td>
							  </tr>
							  <input type='hidden' name='userid' value='admin'>
							  <input type='hidden' name='page' value=''>
							  <input type='hidden' name='page_list' value=''>
							  <input type='hidden' name='search' value=''>
							  <input type='hidden' name='kwd' value=''>
							 </table>
							 <BR>													
							<table border=0 width=100% cellpadding=0 cellspacing=0 id='uploadform'>
							  <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=100% bgcolor='#ffffff' align='center'>
								<input type=image src='../image/but_modify.gif' border=0>
								<img src='../image/but_cancel.gif' border=0 onClick="history.back()" style="cursor:hand">
								</td>
							  </tr>
							 </table>
							</td>
						</tr>
															
						</form>
                                </table></td>
                              </tr>
							
                          </table></td>
                        </tr>
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
