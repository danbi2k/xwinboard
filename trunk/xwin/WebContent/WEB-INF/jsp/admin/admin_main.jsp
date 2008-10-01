<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>관리자페이지</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8>
<link href="/xwin/common/style.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" src="js/main.js"></SCRIPT>
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
          <td width="7%"><a href="main.php"><img src="image/logo.gif" width="170" height="60" border="0"></a></td>
          <td width="42%"><table width="360"  border="0" cellspacing="0" cellpadding="0">
              <tr>
				<!--td width="72" height="60" align="center" style="padding-top:35px" background="image/topm41.gif"><a href="members/" class="menu" >회원관리</a>
			
				</td-->

                <td width="72" height="60" background="image/topm11.gif" align="center" style="padding-top:35px"><a href="admin/" class="menu" >관리자정보</a></td>
                <td width="72" height="60" background="image/topm21.gif" align="center" style="padding-top:35px"><a href="member/" class="menu" >회원관리</a></td>
                <td width="72" height="60" background="image/topm31.gif" align="center" style="padding-top:35px"><a href="calc/" class="menu" >입출금관리</a></td>
                <td width="72" height="60" background="image/topm41.gif" align="center" style="padding-top:35px"><a href="game/" class="menu" >경기관리</a></td>
                <td width="72" height="60" background="image/topm51.gif" align="center" style="padding-top:35px"><a href="board/?db_name=일반게시판" class="menu" >게시판관리</a></td>
			
                <!--td width="72" height="60"  align="center" style="padding-top:35px" background="image/topm31.gif"><a href="school" class="menu" >학교관리</a></td-->                
				</tr>
          </table></td>
		  <td width="34%" valign="bottom" align="center">
		  </td>
		  <td width="17%" valign="bottom" style="padding-bottom:5px"> <a href="/" target="_blank">  바로가기</a> | <a href="logout.php">로그아웃</a> &nbsp;</td>
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
          <td width="170" height="500" background="image/left_bg.gif" valign="top">
		  <!-- 좌측 메뉴 -->
		  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="45" background="imgae/leftm_bg.gif" style="padding-left:20px" class="sub_menu_left"> QuickMenu</td>
              </tr>
              <tr>
                <td align="right"><table width="96%"  border="0" cellpadding="5" cellspacing="1" bgcolor="D9D9D9"> 
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin/image/leftm_icon.gif" width="9" height="9"><a href="/admin/admin"> 관리자정보관리</a></td>
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
				 
				  <!-- 서버 타이틀 -->
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td><!----컨텐츠---->
                      <table border=0 width=100%>
						<Tr>
							<td width=50% valign='top'>
							<table width="100%"  border="0" cellspacing="0" cellpadding="0">
                  <!-- 서버 타이틀 -->
				  <tr>
                    <td height="30" background="image/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 최근가입회원</td>
                  </tr>
                  <tr>
                    <td height="1" bgcolor="CDCDCD"> </td>
                  </tr>
                  <tr>
                    <td height="2" bgcolor="E7E7E7"> </td>
                  </tr>
</table>
<BR>
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
                              <tr align="center" bgcolor="#E4E4E4">
								<td width=5%>번호</td>
								<td width=15%>아이디</td>
								<td width=15%>닉네임</td>
								<td width=15%>가입일</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=10%>1</td>
								<td width=15%><a href='./member/?mode=read&userid=ori7907&page=&page_list=&search=&kwd=&type='>ori7907</a></td>
								<td width=15%>TOTO J</td>
								<td width=15%>2008-05-27 00:35:12</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=10%>2</td>
								<td width=15%><a href='./member/?mode=read&userid=181818&page=&page_list=&search=&kwd=&type='>181818</a></td>
								<td width=15%>일지매</td>
								<td width=15%>2008-05-26 21:11:31</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=10%>3</td>
								<td width=15%><a href='./member/?mode=read&userid=alltt&page=&page_list=&search=&kwd=&type='>alltt</a></td>
								<td width=15%>alltt</td>
								<td width=15%>2008-05-26 18:42:42</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=10%>4</td>
								<td width=15%><a href='./member/?mode=read&userid=개똥이1&page=&page_list=&search=&kwd=&type='>개똥이1</a></td>
								<td width=15%>개똥이1</td>
								<td width=15%>2008-05-26 16:37:40</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=10%>5</td>
								<td width=15%><a href='./member/?mode=read&userid=개똥이&page=&page_list=&search=&kwd=&type='>개똥이</a></td>
								<td width=15%>개똥이</td>
								<td width=15%>2008-05-26 16:36:40</td>
							  </tr>
					
</table>							</td>
							<td width=50% valign='top'>
							<table width="100%"  border="0" cellspacing="0" cellpadding="0">
                  <!-- 서버 타이틀 -->
				  <tr>
                    <td height="30" background="image/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 최근문의사항</td>
                  </tr>
                  <tr>
                    <td height="1" bgcolor="CDCDCD"> </td>
                  </tr>
                  <tr>
                    <td height="2" bgcolor="E7E7E7"> </td>
                  </tr>
</table>
<BR>
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
                              <tr align="center" bgcolor="#E4E4E4">
								<td width=5%>번호</td>
								<td width=15%>이름</td>
								<td width=15%>연락처</td>
								<td width=15%>작성일</td>
							  </tr>
                              <tr align="center" bgcolor="#FFFFFF">
								<td width=100% colspan='6' align='center'>등록된 회원이 없습니다.</td>
							  </tr>
					
</table>							</td>
						</tr>
						<tr>
							<td colspan='2' height=30></td>
						</tr>
						<Tr>
							<td width=50% valign='top'>
							<table width="100%"  border="0" cellspacing="0" cellpadding="0">
                  <!-- 서버 타이틀 -->
				  <tr>
                    <td height="30" background="image/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 최근충전신청</td>
                  </tr>
                  <tr>
                    <td height="1" bgcolor="CDCDCD"> </td>
                  </tr>
                  <tr>
                    <td height="2" bgcolor="E7E7E7"> </td>
                  </tr>
</table>
<BR>
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
                              <tr align="center" bgcolor="#E4E4E4">
								<td width=5%>번호</td>
								<td width=15%>이름</td>
								<td width=15%>금액</td>
								<td width=15%>신청일</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=10%>1</td>
								<td width=15%><a href='./calc/?mode=read&idx=12&page=&page_list=&search=&kwd=&type='>개똥이</a></td>
								<td width=15%>3,000,000</td>
								<td width=15%>2008-09-30 00:37:26</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=10%>2</td>
								<td width=15%><a href='./calc/?mode=read&idx=11&page=&page_list=&search=&kwd=&type='>최강</a></td>
								<td width=15%>1,000,000</td>
								<td width=15%>2008-05-27 00:38:25</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=10%>3</td>
								<td width=15%><a href='./calc/?mode=read&idx=10&page=&page_list=&search=&kwd=&type='>정현주</a></td>
								<td width=15%>500,000</td>
								<td width=15%>2008-05-27 00:38:16</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=10%>4</td>
								<td width=15%><a href='./calc/?mode=read&idx=9&page=&page_list=&search=&kwd=&type='>일지매</a></td>
								<td width=15%>5,000,000</td>
								<td width=15%>2008-05-27 00:36:15</td>
							  </tr>
					
</table>							</td>
							<td width=50% valign='top'>
							<table width="100%"  border="0" cellspacing="0" cellpadding="0">
                  <!-- 서버 타이틀 -->
				  <tr>
                    <td height="30" background="image/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 최근환전신청</td>
                  </tr>
                  <tr>
                    <td height="1" bgcolor="CDCDCD"> </td>
                  </tr>
                  <tr>
                    <td height="2" bgcolor="E7E7E7"> </td>
                  </tr>
</table>
<BR>
<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
                              <tr align="center" bgcolor="#E4E4E4">
								<td width=5%>번호</td>
								<td width=15%>회원아이디</td>
								<td width=15%>금액</td>
								<td width=15%>신청일</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=10%>1</td>
								<td width=15%><a href='./calc/exchange.php?mode=read&idx=6&page=&page_list=&search=&kwd=&type='>개똥이</a></td>
								<td width=15%>20,000</td>
								<td width=15%>2008-09-30 00:50:21</td>
							  </tr>
					
</table>							</td>
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
