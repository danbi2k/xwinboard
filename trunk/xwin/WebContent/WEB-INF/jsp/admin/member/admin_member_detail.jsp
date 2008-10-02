<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	Member member = (Member) request.getAttribute("member");
%>
 
		  <!-- 좌측 메뉴 -->
		  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="45" background="imgae/leftm_bg.gif" style="padding-left:20px" class="sub_menu_left"> 회원관리</td>

              </tr>
              <tr>
                <td align="right"><table width="96%"  border="0" cellpadding="5" cellspacing="1" bgcolor="D9D9D9"> 
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminMember.aspx?mode=viewAdminMember"> 회원관리</a></td>
    </tr>
	<tr>
		<!-- td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="member/login_status.php"> 로그인현황</a></td -->

    </tr>
	<!--tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="member/contents.php"> 컨텐츠관리</a></td>
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
                    <td height="30" background="images/admin/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 회원관리</td>
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

		
		d.action='member/index.php?mode=modify_exe';
		d.submit();
	}

	function delIT(userid) {
		if(confirm('해당 정보를 삭제하시겠습니까?')) {
			location='member/index.php?mode=del_exe&userid='+userid+'&page=1&page_list=1&search=&kwd=&type=';
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
			d.action='member/index.php?mode=recharge&userid=ori7907&page=1&page_list=1&search=&kwd=&type=';
		}
	}


</SCRIPT>
		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td height="30"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                              <tr>

                                <td> * 회원정보를 조회하시거나 수정 , 삭제 하실 수 있습니다.</td>
                                <td align="right"></td>
                              </tr>
                          </table></td>
                        </tr>
						<form method=post name='regist'>
                        <tr>
							<td height=30 colspan='3' align='right'></td>

						</tr>
						<tr>
							<td colspan='3'>
							<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
                              <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=20%>회원아이디</td>
								<td width=80% bgcolor='#ffffff' align='left'><%=member.getUserId()%></td>
							  </tr>

							    <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=20%>닉네임</td>
								<td width=80% bgcolor='#ffffff' align='left'><%=member.getNickName()%></td>
							  </tr>
							    <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=20%>보유금액</td>
								<td width=80% bgcolor='#ffffff' align='left'><%=member.getBalance()%> 원
								</td>

							  </tr>
						     <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=20%>비밀번호</td>
								<td width=80% bgcolor='#ffffff' align='left'><input type='text' name='passwd' value='<%=member.getPassword()%>'>
								</td>
							  </tr>
							  <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=20%>연락처</td>

								<td width=80% bgcolor='#ffffff' align='left'><input type='text' size='40' name='hp' value='<%=member.getMobile()%>'></a>
								</td>
							  </tr>
							  <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=20%>EMAIL</td>
								<td width=80% bgcolor='#ffffff' align='left'><input type='email' size='40' name='email' value='<%=member.getEmail()%>'></a>
								</td>
							  </tr>

							   <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=20%>회원상태</td>
								<td width=80% bgcolor='#ffffff' align='left'>
								<input type='radio' name='status' value='<%=Code.USER_STATUS_NORMAL%>' <%=member.getStatus().equals(Code.USER_STATUS_NORMAL)?"checked":""%>> 정상 
								<input type='radio' name='status' value='<%=Code.USER_STATUS_SECEDE%>' <%=member.getStatus().equals(Code.USER_STATUS_SECEDE)?"checked":""%>> 탈퇴
								<input type='radio' name='status' value='<%=Code.USER_STATUS_SECEDE_REQ%>' <%=member.getStatus().equals(Code.USER_STATUS_SECEDE_REQ)?"checked":""%>> 탈퇴요청
								</td>
							  </tr>
							   <tr align="center" bgcolor="#E4E4E4" height=20>

								<td width=20%>회원종류</td>
								<td width=80% bgcolor='#ffffff' align='left'>
								<input type='radio' name='memtype' value='<%=Code.USER_GRADE_NORMAL%>' <%=member.getGrade().equals(Code.USER_GRADE_NORMAL)?"checked":""%>> 일반 
								<input type='radio' name='memtype' value='<%=Code.USER_GRADE_VIP%>' <%=member.getGrade().equals(Code.USER_GRADE_VIP)?"checked":""%>> VIP
								</td>
							  </tr>
							 </table>
							 <BR>													
							<table border=0 width=100% cellpadding=0 cellspacing=0 id='uploadform'>
							  <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=100% bgcolor='#ffffff' align='center'>
								
								<img src='images/admin/but_modify.gif' border=0 onclick="checkIT()">
								<!--img src="images/admin/but_s_del.gif" border=0 onClick="delIT('ori7907')" style='cursor:hand' -->
								<img src='images/admin/but_cancel.gif' border=0 onClick="history.back()" style="cursor:hand">
								</td>
							  </tr>
							 </table>
							</td>
						</tr>
															
						</form>
                                </table></td>

                              </tr>
							
                          </table>
						  <BR>

<!--
						  <form method='post' name='charge' onSubmit='return chargeIT()'>
						<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
                              <tr align="center" bgcolor="#E4E4E4">
								<td>충전/삭감금액</td>
								<td align='left' bgcolor='#ffffff'><input type='text' name='amt' value=''> *1 이상이면 충전 , -1 이하면 차감됩니다.</td>

							  </tr>
                              <tr align="center" bgcolor="#E4E4E4">
								<td>내역</td>
								<td align='left' bgcolor='#ffffff'><input type='text' name='msg' size=50 value=''> </td>
							  </tr>
                              <tr align="center" bgcolor="#FFFFFF">
								<td colspan='2'><input type=image src='images/admin/but_input.gif' border=0 align='absmiddle'></td>
							  </tr>

						</table>
						</form>

						  
						  <BR>
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
								<td width=5%>5</td>
								<td>ori7907</a></td>
								<td>250,000</td>
								<td>1,111</td>
								<td>251,111</td>

								<td>텟</td>
								<td>2008-09-30 00:54:38</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>4</td>
								<td>ori7907</a></td>
								<td>350,000</td>

								<td>-100,000</td>
								<td>250,000</td>
								<td>배팅완료</td>
								<td>2008-05-27 00:41:48</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>3</td>

								<td>ori7907</a></td>
								<td>400,000</td>
								<td>-50,000</td>
								<td>350,000</td>
								<td>배팅완료</td>
								<td>2008-05-27 00:41:14</td>

							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>2</td>
								<td>ori7907</a></td>
								<td>500,000</td>
								<td>-100,000</td>
								<td>400,000</td>

								<td>배팅완료</td>
								<td>2008-05-27 00:40:46</td>
							  </tr>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%>1</td>
								<td>ori7907</a></td>
								<td>0</td>

								<td>500,000</td>
								<td>500,000</td>
								<td>충전완료</td>
								<td>2008-05-27 00:38:42</td>
							  </tr>
					

									</table>
						  </td>

                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                        </tr>                      
                      </table>
    -->                    
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