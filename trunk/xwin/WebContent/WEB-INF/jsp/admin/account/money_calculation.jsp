<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

		  <!-- 좌측 메뉴 -->
		  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="45" background="imgae/leftm_bg.gif" style="padding-left:20px" class="sub_menu_left"> 입출금관리</td>
              </tr>
              <tr>
                <td align="right"><table width="96%"  border="0" cellpadding="5" cellspacing="1" bgcolor="D9D9D9"> 
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin_mode/image/leftm_icon.gif" width="9" height="9"><a href="adminAccount.aspx?mode=viewMoneyIn"> 입금현황</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin_mode/image/leftm_icon.gif" width="9" height="9"><a href="adminAccount.aspx?mode=viewMoneyOut"> 출금현황</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin_mode/image/leftm_icon.gif" width="9" height="9"><a href="adminAccount.aspx?mode=viewMoneySummary"> 내역관리</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin_mode/image/leftm_icon.gif" width="9" height="9"><a href="adminAccount.aspx?mode=viewMoneyCalculation"> 입출금 정산</a></td>
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
                    <td height="30" background="/admin_mode/image/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 내역관리</td>
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
		if(confirm('환전하시겠습니까?')) {			
			d.action='/admin_mode/calc/trans.php';
		}
		else {
			return false;
		}
	}

	function delIT() {
		if(confirm('해당 정보를 삭제하시겠습니까?\n\n삭제하셔도 해당 유저의 환전금액이 삭제되지는 않습니다.')) {
			location='/admin_mode/calc/trans.php?mode=del_exe&idx=&page=&page_list=&search=&kwd=&type=';
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
                                <td> * 유저들의 입출금 내역을 조회하실 수 있습니다.</td>
                              </tr>
                          </table></td>
                        </tr>
							<form method='post' name='search' action='/admin_mode/calc/trans.php'>
						 <tr>
                          <td align='left' height=30>						
						 <select name='search'>
						 <option value='userid' >회원아이디</option>
						 </select>
						 <input type='text' name='kwd' value=''>
						
						일자별검색
						 <input type='text' name='sdate' size=10 readonly onClick="popUpCalendar(this,sdate,'yyyy-mm-dd');" style="cursor:hand" value=''>
						 ~
						 <input type='text' name='edate' size=10 readonly onClick="popUpCalendar(this,edate,'yyyy-mm-dd');" style="cursor:hand" value=''>		

						 <input type='submit' value='검 색'>
						  </td>
                        </tr>  
						</form>
						<tr>
							<td colspan='3'>
							<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
                              <tr align="center" bgcolor="#E4E4E4">
								<td width=5%>번호</td>
								<td>아이디</td>
								<td>거래전금액</td>
								<td>거래금액</td>
								<td>거래후금액</td>
								<td>내역</td>
								<td>일자</td>
							  </tr>
							 
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>141</td>
								<td><B>개똥이</B>(개똥이)</td>
								<td>2,280,000</td>
								<td>3,000,000</td>
								<td>5,280,000</td>
								<td>충전완료</td>
								<td>2008-10-01 18:16:48</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>140</td>
								<td><B>ori7907</B>(TOTO J)</td>
								<td>250,000</td>
								<td>1,111</td>
								<td>251,111</td>
								<td>텟</td>
								<td>2008-09-30 00:54:38</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>139</td>
								<td><B>개똥이</B>(개똥이)</td>
								<td>2,300,000</td>
								<td>-20,000</td>
								<td>2,280,000</td>
								<td>환전신청</td>
								<td>2008-09-30 00:50:21</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>138</td>
								<td><B>개똥이</B>(개똥이)</td>
								<td>1,300,000</td>
								<td>1,000,000</td>
								<td>2,300,000</td>
								<td>배팅취소환급</td>
								<td>2008-09-29 20:01:23</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>137</td>
								<td><B>개똥이</B>(개똥이)</td>
								<td>0</td>
								<td>1,300,000</td>
								<td>1,300,000</td>
								<td>당첨금지급완료</td>
								<td>2008-09-24 20:04:19</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>136</td>
								<td><B>개똥이</B>(개똥이)</td>
								<td>1,000,000</td>
								<td>-1,000,000</td>
								<td>0</td>
								<td>배팅완료</td>
								<td>2008-09-24 19:41:04</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>135</td>
								<td><B>개똥이</B>(개똥이)</td>
								<td>0</td>
								<td>1,000,000</td>
								<td>1,000,000</td>
								<td>게임취소로인한 머니환급</td>
								<td>2008-09-24 19:30:30</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>134</td>
								<td><B>개똥이</B>(개똥이)</td>
								<td>1,000,000</td>
								<td>-1,000,000</td>
								<td>0</td>
								<td>배팅완료</td>
								<td>2008-09-24 19:28:27</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>133</td>
								<td><B>181818</B>(일지매)</td>
								<td>2,000,000</td>
								<td>-1,000,000</td>
								<td>1,000,000</td>
								<td>배팅완료</td>
								<td>2008-05-27 00:41:57</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>132</td>
								<td><B>ori7907</B>(TOTO J)</td>
								<td>350,000</td>
								<td>-100,000</td>
								<td>250,000</td>
								<td>배팅완료</td>
								<td>2008-05-27 00:41:48</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>131</td>
								<td><B>181818</B>(일지매)</td>
								<td>3,000,000</td>
								<td>-1,000,000</td>
								<td>2,000,000</td>
								<td>배팅완료</td>
								<td>2008-05-27 00:41:32</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>130</td>
								<td><B>ori7907</B>(TOTO J)</td>
								<td>400,000</td>
								<td>-50,000</td>
								<td>350,000</td>
								<td>배팅완료</td>
								<td>2008-05-27 00:41:14</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>129</td>
								<td><B>181818</B>(일지매)</td>
								<td>4,000,000</td>
								<td>-1,000,000</td>
								<td>3,000,000</td>
								<td>배팅완료</td>
								<td>2008-05-27 00:41:04</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>128</td>
								<td><B>ori7907</B>(TOTO J)</td>
								<td>500,000</td>
								<td>-100,000</td>
								<td>400,000</td>
								<td>배팅완료</td>
								<td>2008-05-27 00:40:46</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>127</td>
								<td><B>181818</B>(일지매)</td>
								<td>5,000,000</td>
								<td>-1,000,000</td>
								<td>4,000,000</td>
								<td>배팅완료</td>
								<td>2008-05-27 00:39:32</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>126</td>
								<td><B>ori7907</B>(TOTO J)</td>
								<td>0</td>
								<td>500,000</td>
								<td>500,000</td>
								<td>충전완료</td>
								<td>2008-05-27 00:38:42</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>125</td>
								<td><B>12qwaszx</B>(최강베팅)</td>
								<td>0</td>
								<td>1,000,000</td>
								<td>1,000,000</td>
								<td>충전완료</td>
								<td>2008-05-27 00:38:36</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>124</td>
								<td><B>181818</B>(일지매)</td>
								<td>0</td>
								<td>5,000,000</td>
								<td>5,000,000</td>
								<td>충전완료</td>
								<td>2008-05-27 00:37:55</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>123</td>
								<td><B>12qwaszx</B>(최강베팅)</td>
								<td>0</td>
								<td>7,000,000</td>
								<td>7,000,000</td>
								<td>환전취소</td>
								<td>2008-05-25 17:39:59</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>122</td>
								<td><B>ttall</B>()</td>
								<td>0</td>
								<td>500,000</td>
								<td>500,000</td>
								<td>환전취소</td>
								<td>2008-05-25 17:39:55</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>121</td>
								<td><B>12qwaszx</B>(최강베팅)</td>
								<td>0</td>
								<td>3,000,000</td>
								<td>3,000,000</td>
								<td>환전취소</td>
								<td>2008-05-25 17:39:51</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>120</td>
								<td><B>12qwaszx</B>(최강베팅)</td>
								<td>0</td>
								<td>100,000</td>
								<td>100,000</td>
								<td>환전취소</td>
								<td>2008-05-25 17:39:47</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>119</td>
								<td><B>ori7901</B>(화랑)</td>
								<td>0</td>
								<td>50,000</td>
								<td>50,000</td>
								<td>환전취소</td>
								<td>2008-05-25 17:39:43</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>118</td>
								<td><B>babokim1</B>()</td>
								<td>15,619,500</td>
								<td>5,000</td>
								<td>15,624,500</td>
								<td>게임취소로인한 머니환급</td>
								<td>2008-05-25 17:34:33</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>117</td>
								<td><B>babokim1</B>()</td>
								<td>15,519,500</td>
								<td>100,000</td>
								<td>15,619,500</td>
								<td>게임취소로인한 머니환급</td>
								<td>2008-05-25 17:34:33</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>116</td>
								<td><B>babokim1</B>()</td>
								<td>15,269,500</td>
								<td>250,000</td>
								<td>15,519,500</td>
								<td>게임취소로인한 머니환급</td>
								<td>2008-05-25 17:34:33</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>115</td>
								<td><B>babokim1</B>()</td>
								<td>14,769,500</td>
								<td>500,000</td>
								<td>15,269,500</td>
								<td>게임취소로인한 머니환급</td>
								<td>2008-05-25 17:34:29</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>114</td>
								<td><B>babokim1</B>()</td>
								<td>14,764,500</td>
								<td>5,000</td>
								<td>14,769,500</td>
								<td>게임취소로인한 머니환급</td>
								<td>2008-05-25 17:34:20</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>113</td>
								<td><B>babokim1</B>()</td>
								<td>14,714,500</td>
								<td>50,000</td>
								<td>14,764,500</td>
								<td>게임취소로인한 머니환급</td>
								<td>2008-05-25 17:34:20</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>112</td>
								<td><B>babokim1</B>()</td>
								<td>14,214,500</td>
								<td>500,000</td>
								<td>14,714,500</td>
								<td>게임취소로인한 머니환급</td>
								<td>2008-05-25 17:34:20</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>111</td>
								<td><B>babokim1</B>()</td>
								<td>14,209,500</td>
								<td>5,000</td>
								<td>14,214,500</td>
								<td>게임취소로인한 머니환급</td>
								<td>2008-05-25 17:34:14</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>110</td>
								<td><B>babokim1</B>()</td>
								<td>14,204,500</td>
								<td>5,000</td>
								<td>14,209,500</td>
								<td>게임취소로인한 머니환급</td>
								<td>2008-05-25 17:34:14</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>109</td>
								<td><B>babokim1</B>()</td>
								<td>14,199,500</td>
								<td>5,000</td>
								<td>14,204,500</td>
								<td>게임취소로인한 머니환급</td>
								<td>2008-05-25 17:34:14</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>108</td>
								<td><B>babokim1</B>()</td>
								<td>14,194,500</td>
								<td>5,000</td>
								<td>14,199,500</td>
								<td>게임취소로인한 머니환급</td>
								<td>2008-05-25 17:34:14</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>107</td>
								<td><B>12qwaszx</B>(최강베팅)</td>
								<td>57,707,500</td>
								<td>5,000</td>
								<td>57,712,500</td>
								<td>게임취소로인한 머니환급</td>
								<td>2008-05-25 17:33:57</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>106</td>
								<td><B>12qwaszx</B>(최강베팅)</td>
								<td>57,702,500</td>
								<td>5,000</td>
								<td>57,707,500</td>
								<td>게임취소로인한 머니환급</td>
								<td>2008-05-25 17:33:57</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>105</td>
								<td><B>12qwaszx</B>(최강베팅)</td>
								<td>52,702,500</td>
								<td>5,000,000</td>
								<td>57,702,500</td>
								<td>충전완료</td>
								<td>2008-05-25 16:32:46</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>104</td>
								<td><B>12qwaszx</B>(최강베팅)</td>
								<td>52,707,500</td>
								<td>-5,000</td>
								<td>52,702,500</td>
								<td>배팅완료</td>
								<td>2008-05-25 16:31:13</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>103</td>
								<td><B>12qwaszx</B>(최강베팅)</td>
								<td>52,712,500</td>
								<td>-5,000</td>
								<td>52,707,500</td>
								<td>배팅완료</td>
								<td>2008-05-25 16:30:39</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>102</td>
								<td><B>babokim1</B>()</td>
								<td>14,130,000</td>
								<td>64,500</td>
								<td>14,194,500</td>
								<td>당첨금지급완료</td>
								<td>2008-05-25 01:31:27</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>101</td>
								<td><B>12qwaszx</B>(최강베팅)</td>
								<td>52,700,000</td>
								<td>12,500</td>
								<td>52,712,500</td>
								<td>당첨금지급완료</td>
								<td>2008-05-25 01:31:27</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>100</td>
								<td><B>12qwaszx</B>(최강베팅)</td>
								<td>52,705,000</td>
								<td>-5,000</td>
								<td>52,700,000</td>
								<td>배팅완료</td>
								<td>2008-05-25 01:29:00</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>99</td>
								<td><B>babokim1</B>()</td>
								<td>14,135,000</td>
								<td>-5,000</td>
								<td>14,130,000</td>
								<td>배팅완료</td>
								<td>2008-05-25 01:28:54</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>98</td>
								<td><B>babokim1</B>()</td>
								<td>13,635,000</td>
								<td>500,000</td>
								<td>14,135,000</td>
								<td>배팅취소환급</td>
								<td>2008-05-25 01:26:37</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>97</td>
								<td><B>babokim1</B>()</td>
								<td>12,275,000</td>
								<td>1,360,000</td>
								<td>13,635,000</td>
								<td>당첨금지급완료</td>
								<td>2008-05-25 01:20:53</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>96</td>
								<td><B>babokim1</B>()</td>
								<td>12,775,000</td>
								<td>-500,000</td>
								<td>12,275,000</td>
								<td>배팅완료</td>
								<td>2008-05-25 01:19:17</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>95</td>
								<td><B>babokim1</B>()</td>
								<td>13,275,000</td>
								<td>-500,000</td>
								<td>12,775,000</td>
								<td>배팅완료</td>
								<td>2008-05-25 01:19:07</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>94</td>
								<td><B>babokim1</B>()</td>
								<td>13,775,000</td>
								<td>-500,000</td>
								<td>13,275,000</td>
								<td>배팅완료</td>
								<td>2008-05-25 01:18:58</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>93</td>
								<td><B>babokim1</B>()</td>
								<td>12,895,000</td>
								<td>880,000</td>
								<td>13,775,000</td>
								<td>당첨금지급완료</td>
								<td>2008-05-25 01:17:39</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>92</td>
								<td><B>babokim1</B>()</td>
								<td>9,265,000</td>
								<td>3,630,000</td>
								<td>12,895,000</td>
								<td>당첨금지급완료</td>
								<td>2008-05-25 01:17:39</td>
							  </tr>
					

							
                          </table></td>
                        </tr>
                        <tr>
                          <td align='center' height=50>
						 &nbsp;<b>1</b>&nbsp;<a href='/admin_mode/calc/trans.php?page=2&page_list=1&&search=&kwd=&sdate=&edate='>[2]</a>&nbsp;<a href='/admin_mode/calc/trans.php?page=3&page_list=1&&search=&kwd=&sdate=&edate='>[3]</a>&nbsp;&nbsp;						  </td>
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
