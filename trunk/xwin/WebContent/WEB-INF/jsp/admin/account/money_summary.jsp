<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.admin.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	List<Account> accountList = (List<Account>) request.getAttribute("accountList");
%>

		  <!-- 좌측 메뉴 -->
		  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="45" background="imgae/leftm_bg.gif" style="padding-left:20px" class="sub_menu_left"> 입출금관리</td>
              </tr>
              <tr>
                <td align="right"><table width="96%"  border="0" cellpadding="5" cellspacing="1" bgcolor="D9D9D9"> 
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminAccount.aspx?mode=viewMoneyIn"> 입금현황</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminAccount.aspx?mode=viewMoneyOut"> 출금현황</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminAccount.aspx?mode=viewMoneySummary"> 내역관리</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminAccount.aspx?mode=viewMoneyCalculation"> 입출금 정산</a></td>
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
                    <td height="30" background="images/admin/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 내역관리</td>
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
							<form method='post' name='search' action='adminAccount.aspx'>
							<input type='hidden' name='mode' value='viewMoneySummary'/>
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
							<%
							if (accountList != null) {
								for (Account account : accountList) {
							%>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%><%=account.getId()%></td>
								<td><B><%=account.getUserId()%></B></td>
								<td><%=account.getOldBalance()%></td>
								<td><%=account.getMoney()%></td>
								<td><%=account.getBalance()%></td>
								<td><%=Code.getValue(account.getType())%></td>
								<td><%=account.getDateStr()%></td>
							  </tr>
							<%
								}
							}
							%>

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
