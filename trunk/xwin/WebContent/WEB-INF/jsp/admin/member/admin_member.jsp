<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="../admin_header.jsp"%>

<%
	List<Member> memberList = (List<Member>) request.getAttribute("memberList");
	String grade = XwinUtil.nvl(request.getParameter("grade"));
	String search = XwinUtil.nvl(request.getParameter("search"));
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
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
		<!-- td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="/admin_mode/member/login_status.php"> 로그인현황</a></td -->
    </tr>
	<!--tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="/admin_mode/member/contents.php"> 컨텐츠관리</a></td>
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
							<form method='post' name='search' action='adminMember.aspx'>
							<input type='hidden' name='mode' value='viewAdminMember'/>
						 <tr>
                          <td align='left' height=30>
						  <select name='grade' onChange='this.form.submit()'>
						  <option value='' <%=grade.equals("")?"selected":""%>>전체</option>
						  <option value='<%=Code.USER_GRADE_NORMAL%>' <%=grade.equals(Code.USER_GRADE_NORMAL)?"selected":""%>>일반</option>
						  <option value='<%=Code.USER_GRADE_VIP%>' <%=grade.equals(Code.USER_GRADE_VIP)?"selected":""%>>VIP</option>
						  </select>
						 <select name='search'>
							 <option value='userId' <%=search.equals("userId")?"selected":""%>>회원아이디</option>
							 <option value='nickName' <%=search.equals("nickName")?"selected":""%>>회원닉네임</option>
							 <option value='mobile' <%=search.equals("mobile")?"selected":""%>>휴대전화</option>
							 <option value='email' <%=search.equals("email")?"selected":""%>>EMAIL</option>
						 </select>
						 <input type='text' name='keyword' value='<%=keyword%>'>
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
							 <%
							 if (memberList != null) {
								 for (Member member : memberList) {
							 %>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%><%=member.getId()%></td>
								<td width=10%><%=Code.getValue(member.getGrade())%></td>
								<td width=10%><a href='adminMember.aspx?mode=viewMemberDetail&userId=<%=member.getUserId()%>'><%=member.getUserId()%></a></td>
								<td width=15%><%=member.getNickName()%></td>
								<td width=10%><%=member.getBalance()%></td>
								<td width=15%><%=member.getMobile()%></td>
								<td width=20%><%=member.getEmail()%></td>
								<td width=15%><%=member.getJoinDateStr()%></td>
							  </tr>
							<%
								 }
							 }
							%>							
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

<%@ include file="../admin_footer.jsp"%>