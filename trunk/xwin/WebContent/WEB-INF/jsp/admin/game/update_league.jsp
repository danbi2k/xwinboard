<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	League league = (League) request.getAttribute("league");
%>
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
		d.action='adminLeague.aspx?mode=updateLeague';
		d.submit();
	}

	function delIT() {
		if(confirm('해당 정보를 삭제하시겠습니까?')) {
			location='/admin_mode/game/index.php?mode=del_exe&idx=50&page=1&page_list=1&search=&kwd=&type=';
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

                                <td align="right"></td>
                              </tr>
                          </table></td>
                        </tr>
						<form method=post name='regist' onSubmit="return checkIT()">
                        <tr>
							<td height=30 colspan='3' align='right'></td>
						</tr>
						<tr>

							<td colspan='3'>
							<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
                                <tr bgcolor="E7E7E7">
								<td align="center" bgcolor="E7E7E7" width="15%">리그명</td>
								<td bgcolor="#FFFFFF" width="85%" colspan=3> <input type='text' name='name' size='80' value='<%=league.getName()%>'></td>
							  </tr>	
							    <tr bgcolor="E7E7E7">
                        <td align="center" bgcolor="E7E7E7" width="15%">파일업로드</td>

                        <td bgcolor="#FFFFFF" width="85%" colspan=3> <input type='file' name='filename' size='40'></td>
                      </tr>		
							  <input type='hidden' name='id' value='<%=league.getId()%>'>
							 </table>
							 <BR>													
							<table border=0 width=100% cellpadding=0 cellspacing=0 id='uploadform'>

							  <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=100% bgcolor='#ffffff' align='center'>
								<input type=image src='images/admin/but_modify.gif' border=0>
								<img src="images/admin/but_s_del.gif" border=0 onClick="delIT()" style='cursor:hand'>
								<img src='images/admin/but_cancel.gif' border=0 onClick="history.back()" style="cursor:hand">
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
<%@ include file="../admin_footer.jsp"%>
