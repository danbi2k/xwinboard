<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="admin_header.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
		function checkIT() {
		var d=document.regist;
		if(!d.passwd.value) { alert('비밀번호를 입력하세요'); d.passwd.focus(); return false; }

		var query = "mode=updateAdminInfo";
		query += "&nickName=" + d.name.value;
		query += "&password=" + d.passwd.value;
		query += "&mobile=" + d.phone.value;
		query += "&email=" + d.email.value;

		var http = new JKL.ParseXML("adminInfo.aspx", query);
		var result = http.parse();
		alert(result.resultXml.message);
		if (result.resultXml.code == 0) {
		}
		else {
		}
	}
//-->
</SCRIPT>
		  <!-- 좌측 메뉴 -->
		  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="45" background="imgae/leftm_bg.gif" style="padding-left:20px" class="sub_menu_left"> 관리자정보</td>
              </tr>
              <tr>
                <td align="right"><table width="96%"  border="0" cellpadding="5" cellspacing="1" bgcolor="D9D9D9"> 
	<tr>
		<td bgcolor="#FFFFFF"><img src="/admin_mode/image/leftm_icon.gif" width="9" height="9"><a href="adminInfo.aspx?mode=viewAdminInfo"> 관리자정보관리</a></td>
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
					
		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td height="30"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td> * 관리자정보를 수정 하실 수 있습니다.</td>
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
								<td width=20%>관리자아이디</td>
								<td width=80% bgcolor='#ffffff' align='left'><%=admin.getUserId()%></td>
							  </tr>	
							  <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=20%>관리자명</td>
								<td width=80% bgcolor='#ffffff' align='left'><input type='text' name='name' value='<%=admin.getNickName()%>'>
								</td>
							  </tr>	
						     <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=20%>비밀번호</td>
								<td width=80% bgcolor='#ffffff' align='left'><input type='text' name='passwd' value='<%=admin.getPassword()%>'>
								</td>
							  </tr>		
							<tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=20%>전화번호</td>
								<td width=80% bgcolor='#ffffff' align='left'><input type='text' size='40' name='phone' value='<%=admin.getMobile()%>'></a>
								</td>
							  </tr>					 
							  <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=20%>EMAIL</td>
								<td width=80% bgcolor='#ffffff' align='left'><input type='text' size='40' name='email' value='<%=admin.getEmail()%>'></a>
								</td>
							  </tr>
							 </table>
							 <BR>													
							<table border=0 width=100% cellpadding=0 cellspacing=0 id='uploadform'>
							  <tr align="center" bgcolor="#E4E4E4" height=20>
								<td width=100% bgcolor='#ffffff' align='center'>
								<img src='image/but_modify.gif' border=0 onclick="checkIT()" style="cursor:hand">
								<img src='image/but_cancel.gif' border=0 onClick="history.back()" style="cursor:hand">
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

 <%@ include file="admin_footer.jsp"%>