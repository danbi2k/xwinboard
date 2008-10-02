<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

<%
	MoneyOut moneyOut = (MoneyOut) request.getAttribute("moneyOut");
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
		<!-- td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminAccount.aspx?mode=viewMoneyCalculation"> 입출금 정산</a></td-->
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
                    <td height="30" background="images/admin/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 출금현황</td>
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
	function checkIT(id) {
		var d=document.regist;
		if(confirm('환전하시겠습니까?')) {			
			var query = "mode=acceptMoneyOutRequest";
			query += "&id=" + id;
			var http = new JKL.ParseXML("adminAccount.aspx", query);
			var result = http.parse();
			alert(result.resultXml.message);
			if (result.resultXml.code == 0) {
				location.reload();		
			} 
		}
	}

	function delIT() {
		if(confirm('해당 정보를 삭제하시겠습니까?\n\n삭제하셔도 해당 유저의 환전금액이 삭제되지는 않습니다.')) {
			location='/admin_mode/calc/exchange.php?mode=del_exe&idx=6&page=1&page_list=1&search=&kwd=&type=';
		}
		else {
			return false;
		}
	}

</SCRIPT>

<table width="100%"  border="0" cellspacing="0" cellpadding="0">		
              <tr>
                <td height="30"><table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="CDCDCD">
                    <form method='post' name='regist' enctype="multipart/form-data" onSubmit="return checkIT()">  
					 <tr bgcolor="E7E7E7">
                        <td align="center" bgcolor="E7E7E7" width="15%">신청자아이디</td>
                        <td bgcolor="#FFFFFF" width="85%" colspan=3><%=moneyOut.getUserId()%></td>
                      </tr>		
					   <tr bgcolor="E7E7E7">
                        <td align="center" bgcolor="E7E7E7" width="15%">환전요청금액</td>
                        <td bgcolor="#FFFFFF" width="85%" colspan=3><%=moneyOut.getMoney()%></td>
                      </tr>		
					 <tr bgcolor="E7E7E7">
                        <td align="center" bgcolor="E7E7E7" width="15%">환전계좌정보</td>
                        <td bgcolor="#FFFFFF" width="85%" colspan=3>(<%=moneyOut.getBankName()%>) <%=moneyOut.getNumber()%> <B>(예금주 : <%=moneyOut.getName()%>)</B></td>
                      </tr>		
					     <tr bgcolor="E7E7E7">
                        <td align="center" bgcolor="E7E7E7" width="15%">요청일자</td>
                        <td bgcolor="#FFFFFF" width="85%" colspan=3><%=moneyOut.getReqDateStr()%></td>
                      </tr>				
					  					   <tr bgcolor="E7E7E7">
                        <td align="center" bgcolor="E7E7E7" width="15%">환전일자</td>
                        <td bgcolor="#FFFFFF" width="85%" colspan=3><%=moneyOut.getProcDateStr()%></td>
                      </tr>		
					  					 
                </table>
				</td>
              </tr>
              <tr>
                <td height="50" align="center"><table width="2%"  border="0" cellspacing="5" cellpadding="0">
                              <tr>
                                <td><img src="images/admin/but_input.gif" border="0" onclick="checkIT(<%=moneyOut.getId()%>)"></td>                               
                                <!--td><img src="images/admin/but_s_del.gif" border="0" onClick='delIT(13)' style='cursor:hand'></td-->                               
                                <td><img src="images/admin/but_cancel.gif" border="0" onClick="history.back()" style="cursor:hand"></td>
                              </tr>
                          </table></td>
              </tr>
			  <input type='hidden' name='mode' value='modify_exe'>
			  <input type='hidden' name='idx' value='6'>
			  <input type='hidden' name='page' value='1'>
			  <input type='hidden' name='page_list' value='1'>
			  <input type='hidden' name='search' value=''>
			  <input type='hidden' name='kwd' value=''>
			  <input type='hidden' name='sdate' value=''>
              </form>
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
