<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>


<%
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	String keyword = XwinUtil.nvl(request.getParameter("keyword"));
%>
 <%@ include file="../admin_header.jsp"%>
		  <!-- 좌측 메뉴 -->
		  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="45" background="imgae/leftm_bg.gif" style="padding-left:20px" class="sub_menu_left"> 게임관리</td>
              </tr>
              <tr>
                <td align="right"><table width="96%"  border="0" cellpadding="5" cellspacing="1" bgcolor="D9D9D9"> 
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminGame.aspx?mode=viewGameList&type=wdl"> 경기관리 - 승무패</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminGame.aspx?mode=viewGameList&type=handy"> 경기관리 - 핸디캡</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminGame.aspx?mode=viewGameList&type=oe"> 경기관리 - 홀짝</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminBetting.aspx?mode=viewBettingList"> 배팅관리</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminLeague.aspx?mode=viewLeagueList"> 리그관리</a></td>
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
                    <td height="30" background="images/admin/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 리그관리</td>
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
		d.action='game/index.php?mode=modify_exe';
		d.submit();
	}

	function delIT() {
		if(confirm('해당 정보를 삭제하시겠습니까?')) {
			location='game/index.php?mode=del_exe&idx=&page=&page_list=&search=&kwd=&type=';
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
                                <td align="right"><a href='adminLeague.aspx?mode=viewRegisterLeagueForm'><img src='images/admin/but_input.gif' border=0></a></td>
                              </tr>
                          </table></td>
                        </tr>
							<form method='post' name='search' action='adminLeague.aspx'>
							<input type="hidden" name="mode" value="viewLeagueList"/>
						 <tr>
                          <td align='left' height=30>
						 <select name='search'>
						 <option value='name' selected>리그명</option>
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
								<td width=20%>번호</td>
								<td width=20%>이미지</td>
								<td width=80%>리그명</td>
							  </tr>
							<%
							if (leagueList != null) {
								for (League league : leagueList) {
							%>
												 
                              <tr align='center' bgcolor='#ffffff'>
								<td width=20%><%=league.getId()%></td>
								<td width=20%><img src='<%=league.getImage()%>' width='20' height='12' border=0></td>
								<td width=80%><a href='adminLeague.aspx?mode=viewUpdateLeagueForm&id=<%=league.getId()%>'><%=league.getName()%></a></td>
							  </tr>
							<%
								}
							}
							%>
                          </table></td>
                        </tr>
                        <tr>
                          <td align='center' height=50>
						 &nbsp;<b>1</b>&nbsp;<a href='game/index.php?page=2&page_list=1&&search=&kwd='>[2]</a>&nbsp;<a href='game/index.php?page=3&page_list=1&&search=&kwd='>[3]</a>&nbsp;<a href='game/index.php?page=4&page_list=1&&search=&kwd='>[4]</a>&nbsp;<a href='game/index.php?page=5&page_list=1&&search=&kwd='>[5]</a>&nbsp;&nbsp;						  </td>
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
