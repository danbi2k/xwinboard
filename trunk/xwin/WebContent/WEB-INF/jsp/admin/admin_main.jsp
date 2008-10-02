<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

<%@ include file="admin_header.jsp"%>

<%
	List<Member> memberList = (List<Member>) request.getAttribute("memberList");
	List<MoneyIn> moneyInList = (List<MoneyIn>) request.getAttribute("moneyInList");
	List<MoneyOut> moneyOutList = (List<MoneyOut>) request.getAttribute("moneyOutList");
%>

		  <!-- 좌측 메뉴 -->
		  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="45" background="imgae/leftm_bg.gif" style="padding-left:20px" class="sub_menu_left"> QuickMenu</td>
              </tr>
              <tr>
                <td align="right"><table width="96%"  border="0" cellpadding="5" cellspacing="1" bgcolor="D9D9D9"> 
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin/images/admin/leftm_icon.gif" width="9" height="9"><a href="adminInfo.aspx?mode=viewAdminInfo"> 관리자정보관리</a></td>
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
                    <td height="30" background="images/admin/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 최근가입회원</td>
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
                              <%
                              if (memberList != null) {
                            	  for (Member member : memberList) {
                              %>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=10%><%=member.getId()%></td>
								<td width=15%><a href='adminMember.aspx?mode=viewMemberDetail&userId=<%=member.getUserId()%>'><%=member.getUserId()%></a></td>
								<td width=15%><%=member.getNickName()%></td>
								<td width=15%><%=member.getJoinDateStr()%></td>
							  </tr>
							<%
                            	  }
                              }
							%>
					
</table>							</td>
							<td width=50% valign='top'>
							<table width="100%"  border="0" cellspacing="0" cellpadding="0">
                  <!-- 서버 타이틀 -->
				  <tr>
                    <td height="30" background="images/admin/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 최근문의사항</td>
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
								<td width=100% colspan='4' align='center'>등록된 문의사항이 없습니다.</td>
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
                    <td height="30" background="images/admin/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 최근충전신청</td>
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
 							  <%
                              if (moneyInList != null) {
                            	  for (MoneyIn moneyIn : moneyInList) {
                              %>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=10%><%=moneyIn.getId()%></td>
								<td width=15%><%=moneyIn.getName()%></td>
								<td width=15%><%=moneyIn.getMoney()%></td>
								<td width=15%><%=moneyIn.getReqDateStr()%></td>
							  </tr>
							<%
                            	  }
                              }
							%>
					
</table>							</td>
							<td width=50% valign='top'>
							<table width="100%"  border="0" cellspacing="0" cellpadding="0">
                  <!-- 서버 타이틀 -->
				  <tr>
                    <td height="30" background="images/admin/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 최근환전신청</td>
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
							 <%
                              if (moneyOutList != null) {
                            	  for (MoneyOut moneyOut : moneyOutList) {
                              %>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=10%><%=moneyOut.getId()%></td>
								<td width=15%><%=moneyOut.getName()%></td>
								<td width=15%><%=moneyOut.getMoney()%></td>
								<td width=15%><%=moneyOut.getReqDateStr()%></td>
							  </tr>
							<%
                            	  }
                              }
							%>
					
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

<%@ include file="admin_footer.jsp"%>
