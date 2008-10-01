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
                    <td height="30" background="/admin_mode/image/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 로그인 현황</td>
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
						<table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td height="30"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td> * 회원들의 로그인 정보를 조회 합니다.</td>
                                <td align="right"></td>
                              </tr>
                          </table></td>
                        </tr>
							<form method='post' name='search' action='/admin_mode/member/login_status.php'>
						 <tr>
                          <td align='left' height=30>
						 <select name='search'>
						 <option value='userid' >회원아이디</option>
						 <option value='nickname' >회원닉네임</option>
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
								<td width=20%>아이디</td>
								<td width=20%>닉네임</td>
								<td width=20%>로그인시간</td>
								<td width=20%>아이피</td>
							  </tr>
							 
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>112</td>
								<td width=20%><a href='index.php?mode=read&userid=개똥이&page=1&page_list=1&search=&kwd=&type='>개똥이</a></td>
								<td width=20%>개똥이</td>
								<td width=20%>2008-09-30 00:37:08</td>
								<td width=20%>127.0.0.1</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>111</td>
								<td width=20%><a href='index.php?mode=read&userid=개똥이&page=1&page_list=1&search=&kwd=&type='>개똥이</a></td>
								<td width=20%>개똥이</td>
								<td width=20%>2008-09-24 20:16:22</td>
								<td width=20%>10.21.49.123</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>110</td>
								<td width=20%><a href='index.php?mode=read&userid=개똥이&page=1&page_list=1&search=&kwd=&type='>개똥이</a></td>
								<td width=20%>개똥이</td>
								<td width=20%>2008-09-24 19:37:52</td>
								<td width=20%>10.21.49.123</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>109</td>
								<td width=20%><a href='index.php?mode=read&userid=개똥이&page=1&page_list=1&search=&kwd=&type='>개똥이</a></td>
								<td width=20%>개똥이</td>
								<td width=20%>2008-09-24 19:27:41</td>
								<td width=20%>127.0.0.1</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>108</td>
								<td width=20%><a href='index.php?mode=read&userid=개똥이&page=1&page_list=1&search=&kwd=&type='>개똥이</a></td>
								<td width=20%>개똥이</td>
								<td width=20%>2008-09-24 17:59:58</td>
								<td width=20%>127.0.0.1</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>107</td>
								<td width=20%><a href='index.php?mode=read&userid=zxcvb&page=1&page_list=1&search=&kwd=&type='>zxcvb</a></td>
								<td width=20%>토토신</td>
								<td width=20%>2008-09-24 17:48:37</td>
								<td width=20%>127.0.0.1</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>106</td>
								<td width=20%><a href='index.php?mode=read&userid=181818&page=1&page_list=1&search=&kwd=&type='>181818</a></td>
								<td width=20%>일지매</td>
								<td width=20%>2008-05-27 00:35:44</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>105</td>
								<td width=20%><a href='index.php?mode=read&userid=ori7907&page=1&page_list=1&search=&kwd=&type='>ori7907</a></td>
								<td width=20%>TOTO J</td>
								<td width=20%>2008-05-27 00:35:24</td>
								<td width=20%>211.177.17.235</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>104</td>
								<td width=20%><a href='index.php?mode=read&userid=12qwaszx&page=1&page_list=1&search=&kwd=&type='>12qwaszx</a></td>
								<td width=20%>최강베팅</td>
								<td width=20%>2008-05-27 00:35:12</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>103</td>
								<td width=20%><a href='index.php?mode=read&userid=zxcvb&page=1&page_list=1&search=&kwd=&type='>zxcvb</a></td>
								<td width=20%>토토신</td>
								<td width=20%>2008-05-27 00:12:00</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>102</td>
								<td width=20%><a href='index.php?mode=read&userid=12qwaszx&page=1&page_list=1&search=&kwd=&type='>12qwaszx</a></td>
								<td width=20%>최강베팅</td>
								<td width=20%>2008-05-27 00:10:08</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>101</td>
								<td width=20%><a href='index.php?mode=read&userid=12345&page=1&page_list=1&search=&kwd=&type='>12345</a></td>
								<td width=20%>럭셔리토토</td>
								<td width=20%>2008-05-27 00:07:09</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>100</td>
								<td width=20%><a href='index.php?mode=read&userid=12345&page=1&page_list=1&search=&kwd=&type='>12345</a></td>
								<td width=20%>베팅가이드</td>
								<td width=20%>2008-05-27 00:06:19</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>99</td>
								<td width=20%><a href='index.php?mode=read&userid=12345&page=1&page_list=1&search=&kwd=&type='>12345</a></td>
								<td width=20%>코리아탑팀</td>
								<td width=20%>2008-05-27 00:05:15</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>98</td>
								<td width=20%><a href='index.php?mode=read&userid=12345&page=1&page_list=1&search=&kwd=&type='>12345</a></td>
								<td width=20%>1bet</td>
								<td width=20%>2008-05-27 00:03:31</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>97</td>
								<td width=20%><a href='index.php?mode=read&userid=12345&page=1&page_list=1&search=&kwd=&type='>12345</a></td>
								<td width=20%>adam</td>
								<td width=20%>2008-05-26 23:59:26</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>96</td>
								<td width=20%><a href='index.php?mode=read&userid=12345&page=1&page_list=1&search=&kwd=&type='>12345</a></td>
								<td width=20%>소나무</td>
								<td width=20%>2008-05-26 23:57:22</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>95</td>
								<td width=20%><a href='index.php?mode=read&userid=12345&page=1&page_list=1&search=&kwd=&type='>12345</a></td>
								<td width=20%>아기조폭</td>
								<td width=20%>2008-05-26 23:56:47</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>94</td>
								<td width=20%><a href='index.php?mode=read&userid=12345&page=1&page_list=1&search=&kwd=&type='>12345</a></td>
								<td width=20%>아기조폭</td>
								<td width=20%>2008-05-26 21:43:48</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>93</td>
								<td width=20%><a href='index.php?mode=read&userid=12345&page=1&page_list=1&search=&kwd=&type='>12345</a></td>
								<td width=20%>아기조폭</td>
								<td width=20%>2008-05-26 21:33:02</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>92</td>
								<td width=20%><a href='index.php?mode=read&userid=181818&page=1&page_list=1&search=&kwd=&type='>181818</a></td>
								<td width=20%>일지매</td>
								<td width=20%>2008-05-26 21:11:40</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>91</td>
								<td width=20%><a href='index.php?mode=read&userid=alltt&page=1&page_list=1&search=&kwd=&type='>alltt</a></td>
								<td width=20%>alltt</td>
								<td width=20%>2008-05-26 18:45:55</td>
								<td width=20%>61.109.243.163</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>90</td>
								<td width=20%><a href='index.php?mode=read&userid=alltt&page=1&page_list=1&search=&kwd=&type='>alltt</a></td>
								<td width=20%>alltt</td>
								<td width=20%>2008-05-26 18:42:50</td>
								<td width=20%>61.109.243.163</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>89</td>
								<td width=20%><a href='index.php?mode=read&userid=zxcvb&page=1&page_list=1&search=&kwd=&type='>zxcvb</a></td>
								<td width=20%>토토신</td>
								<td width=20%>2008-05-26 14:50:31</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>88</td>
								<td width=20%><a href='index.php?mode=read&userid=zxcvb&page=1&page_list=1&search=&kwd=&type='>zxcvb</a></td>
								<td width=20%>1004</td>
								<td width=20%>2008-05-26 14:49:44</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>87</td>
								<td width=20%><a href='index.php?mode=read&userid=zxcvb&page=1&page_list=1&search=&kwd=&type='>zxcvb</a></td>
								<td width=20%>이브라몸이나바쳐</td>
								<td width=20%>2008-05-26 14:46:01</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>86</td>
								<td width=20%><a href='index.php?mode=read&userid=zxcvb&page=1&page_list=1&search=&kwd=&type='>zxcvb</a></td>
								<td width=20%>1004</td>
								<td width=20%>2008-05-26 14:41:52</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>85</td>
								<td width=20%><a href='index.php?mode=read&userid=zxcvb&page=1&page_list=1&search=&kwd=&type='>zxcvb</a></td>
								<td width=20%>백전백승</td>
								<td width=20%>2008-05-26 14:41:10</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>84</td>
								<td width=20%><a href='index.php?mode=read&userid=zxcvb&page=1&page_list=1&search=&kwd=&type='>zxcvb</a></td>
								<td width=20%>백전백승</td>
								<td width=20%>2008-05-26 00:53:37</td>
								<td width=20%>122.35.82.8</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>83</td>
								<td width=20%><a href='index.php?mode=read&userid=12qwaszx&page=1&page_list=1&search=&kwd=&type='>12qwaszx</a></td>
								<td width=20%>최강베팅</td>
								<td width=20%>2008-05-25 23:19:55</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>82</td>
								<td width=20%><a href='index.php?mode=read&userid=ori7901&page=1&page_list=1&search=&kwd=&type='>ori7901</a></td>
								<td width=20%>화랑</td>
								<td width=20%>2008-05-25 23:10:28</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>81</td>
								<td width=20%><a href='index.php?mode=read&userid=12qwaszx&page=1&page_list=1&search=&kwd=&type='>12qwaszx</a></td>
								<td width=20%>최강베팅</td>
								<td width=20%>2008-05-25 22:48:03</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>80</td>
								<td width=20%><a href='index.php?mode=read&userid=ori7901&page=1&page_list=1&search=&kwd=&type='>ori7901</a></td>
								<td width=20%>김군</td>
								<td width=20%>2008-05-25 22:41:38</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>79</td>
								<td width=20%><a href='index.php?mode=read&userid=ori7901&page=1&page_list=1&search=&kwd=&type='>ori7901</a></td>
								<td width=20%>토사장</td>
								<td width=20%>2008-05-25 22:37:27</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>78</td>
								<td width=20%><a href='index.php?mode=read&userid=ori7901&page=1&page_list=1&search=&kwd=&type='>ori7901</a></td>
								<td width=20%>럭셔리토토</td>
								<td width=20%>2008-05-25 22:36:51</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>77</td>
								<td width=20%><a href='index.php?mode=read&userid=12qwaszx&page=1&page_list=1&search=&kwd=&type='>12qwaszx</a></td>
								<td width=20%>최강베팅</td>
								<td width=20%>2008-05-25 22:03:50</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>76</td>
								<td width=20%><a href='index.php?mode=read&userid=ori7901&page=1&page_list=1&search=&kwd=&type='>ori7901</a></td>
								<td width=20%>럭셔리토토</td>
								<td width=20%>2008-05-25 20:34:35</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>75</td>
								<td width=20%><a href='index.php?mode=read&userid=ori7904&page=1&page_list=1&search=&kwd=&type='>ori7904</a></td>
								<td width=20%>rkdndhkd</td>
								<td width=20%>2008-05-25 19:35:42</td>
								<td width=20%>211.177.17.235</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>74</td>
								<td width=20%><a href='index.php?mode=read&userid=ori7903&page=1&page_list=1&search=&kwd=&type='>ori7903</a></td>
								<td width=20%>빠라디자인</td>
								<td width=20%>2008-05-25 19:32:38</td>
								<td width=20%>211.177.17.235</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>73</td>
								<td width=20%><a href='index.php?mode=read&userid=zxcvb&page=1&page_list=1&search=&kwd=&type='>zxcvb</a></td>
								<td width=20%>백전백승</td>
								<td width=20%>2008-05-25 19:31:04</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>72</td>
								<td width=20%><a href='index.php?mode=read&userid=12qwaszx&page=1&page_list=1&search=&kwd=&type='>12qwaszx</a></td>
								<td width=20%>최강베팅</td>
								<td width=20%>2008-05-25 19:26:51</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>71</td>
								<td width=20%><a href='index.php?mode=read&userid=12345&page=1&page_list=1&search=&kwd=&type='>12345</a></td>
								<td width=20%>아기조폭</td>
								<td width=20%>2008-05-25 19:14:57</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>70</td>
								<td width=20%><a href='index.php?mode=read&userid=12qwaszx&page=1&page_list=1&search=&kwd=&type='>12qwaszx</a></td>
								<td width=20%>최강베팅</td>
								<td width=20%>2008-05-25 19:12:52</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>69</td>
								<td width=20%><a href='index.php?mode=read&userid=zxcvb&page=1&page_list=1&search=&kwd=&type='>zxcvb</a></td>
								<td width=20%>백전백승</td>
								<td width=20%>2008-05-25 18:51:39</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>68</td>
								<td width=20%><a href='index.php?mode=read&userid=ori7904&page=1&page_list=1&search=&kwd=&type='>ori7904</a></td>
								<td width=20%>rkdndhkd</td>
								<td width=20%>2008-05-25 18:49:04</td>
								<td width=20%>211.177.17.235</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>67</td>
								<td width=20%><a href='index.php?mode=read&userid=12345&page=1&page_list=1&search=&kwd=&type='>12345</a></td>
								<td width=20%>아기조폭</td>
								<td width=20%>2008-05-25 18:45:13</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>66</td>
								<td width=20%><a href='index.php?mode=read&userid=12qwaszx&page=1&page_list=1&search=&kwd=&type='>12qwaszx</a></td>
								<td width=20%>최강베팅</td>
								<td width=20%>2008-05-25 18:39:59</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>65</td>
								<td width=20%><a href='index.php?mode=read&userid=zxcvb&page=1&page_list=1&search=&kwd=&type='>zxcvb</a></td>
								<td width=20%>백전백승</td>
								<td width=20%>2008-05-25 18:37:46</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>64</td>
								<td width=20%><a href='index.php?mode=read&userid=12345&page=1&page_list=1&search=&kwd=&type='>12345</a></td>
								<td width=20%>아기조폭</td>
								<td width=20%>2008-05-25 18:33:19</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%>63</td>
								<td width=20%><a href='index.php?mode=read&userid=12qwaszx&page=1&page_list=1&search=&kwd=&type='>12qwaszx</a></td>
								<td width=20%>최강베팅</td>
								<td width=20%>2008-05-25 18:30:11</td>
								<td width=20%>211.58.23.69</td>
							  </tr>
					

							
                          </table></td>
                        </tr>
                        <tr>
                          <td align='center' height=50>
						 &nbsp;<b>1</b>&nbsp;<a href='/admin_mode/member/login_status.php?page=2&page_list=1&&search=&kwd='>[2]</a>&nbsp;<a href='/admin_mode/member/login_status.php?page=3&page_list=1&&search=&kwd='>[3]</a>&nbsp;&nbsp;						  </td>
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
