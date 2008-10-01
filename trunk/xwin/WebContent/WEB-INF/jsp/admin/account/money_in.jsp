<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	List<MoneyIn> moneyInList = (List<MoneyIn>) request.getAttribute("moneyInList");
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
                    <td height="30" background="images/admin/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 입금현황</td>
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
		if(confirm('충전하시겠습니까?')) {			
			d.action='calc/index.php';
		}
		else {
			return false;
		}
	}

	function delIT() {
		if(confirm('해당 정보를 삭제하시겠습니까?\n\n삭제하셔도 해당 유저의 충전금액이 삭제되지는 않습니다.')) {
			location='calc/index.php?mode=del_exe&idx=&page=&page_list=&search=&kwd=&type=';
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
                                <td> * 충전신청정보를 조회하시거나 , 삭제 하실 수 있습니다.</td>
                              </tr>
                          </table></td>
                        </tr>
							<form method='post' name='search' action='adminAccount.aspx'>
							<input type='hidden' name='mode' value='viewMoneyIn'/>
						 <tr>
                          <td align='left' height=30>						
						 <select name='search'>
						 <option value='userId' >회원아이디</option>
						 <option value='name' >입금자명</option>
						 </select>
						 <input type='text' name='kwd' value=''>

						  <select name='searchDate'>
						 <option value='procDate' >충전일</option>
						 <option value='reqDate' >신청일</option>
						 </select>
						 <input type='text' name='fromDate' size=10 readonly onClick="popUpCalendar(this,sdate,'yyyy-mm-dd');" style="cursor:hand" value=''>
						 ~
						 <input type='text' name='toDate' size=10 readonly onClick="popUpCalendar(this,edate,'yyyy-mm-dd');" style="cursor:hand" value=''>		
						 <input type='submit' value='검 색'>
						  </td>
                        </tr>  
						</form>
						<tr>
							<td colspan='3'>
							<table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
                              <tr align="center" bgcolor="#E4E4E4">
								<td width=5%>번호</td>
								<td>아이디(닉네임)</td>
								<td>입금자</td>
								<td>충전요청금액</td>
								<td>신청일자</td>
								<td>상태</td>
							  </tr>
							 
							<%
							if (moneyInList != null) {
								for (MoneyIn moneyIn : moneyInList) {
							%>
                              <tr align='center' bgcolor='#ffffff'>
								<td width=5%><%=moneyIn.getId()%></td>
								<td><a href='adminAccount.aspx?mode=viewMoneyInDetail&id=<%=moneyIn.getId()%>'><B><%=moneyIn.getUserId()%></B></a></td>
								<td><a href='adminAccount.aspx?mode=viewMoneyInDetail&id=<%=moneyIn.getId()%>'><%=moneyIn.getName()%></td>
								<td><%=moneyIn.getMoney()%></td>
								<td><%=moneyIn.getReqDateStr()%></td>
								<td><%=Code.getValue(moneyIn.getStatus())%></td>
							  </tr>
							<%
								}
							}
							%>
                          </table></td>
                        </tr>
                        <tr>
                          <td align='center' height=50>
						 &nbsp;<b>1</b>&nbsp;&nbsp;						  </td>
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
