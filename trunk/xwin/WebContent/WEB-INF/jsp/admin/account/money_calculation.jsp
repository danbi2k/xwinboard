<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="java.util.*"%>

 <%@ include file="../admin_header.jsp"%>

		  <!-- 좌측 메뉴 -->
		  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="45" background="imgae/leftm_bg.gif" style="padding-left:20px" class="sub_menu_left"> 입환전관리</td>
              </tr>
              <tr>
                <td align="right"><table width="96%"  border="0" cellpadding="5" cellspacing="1" bgcolor="D9D9D9"> 
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminAccount.aspx?mode=viewMoneyIn"> 입금현황</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminAccount.aspx?mode=viewMoneyOut"> 환전현황</a></td>
    </tr>
	<tr>
		<td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminAccount.aspx?mode=viewMoneySummary"> 내역관리</a></td>
    </tr>
	<tr>
		<!-- td bgcolor="#FFFFFF"><img src="images/admin/leftm_icon.gif" width="9" height="9"><a href="adminAccount.aspx?mode=viewMoneyCalculation"> 입환전 정산</a></td-->
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
                    <td height="30" background="images/admin/tit_bg.gif" style="padding-left:15px" class="sub_tit"> 입환전 정산</td>
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
<!--
	function insert_date(D1, D2){
		document.getElementById("sdate").value = D1;
		document.getElementById("edate").value = D2;
		document.search.submit();
	}
//-->
</SCRIPT>


	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
		<form method='post' name='search' action='/admin_mode/calc/in_out.php'>
		 <tr>
			<td align='left' height=30>						
			&nbsp;[<A HREF="/admin_mode/calc/in_out.php">전체</A>]
			</td>
			<td align='right' height=30 style="padding-right:10px">	
				<A HREF="#" onclick="insert_date('2008-07-03','2008-10-01')"><img src="images/admin/90.gif" border="0" align="absmiddle"></A>
		 <A HREF="#" onclick="insert_date('2008-08-02','2008-10-01')"><img src="images/admin/60.gif" border="0" align="absmiddle"></A>
		 <A HREF="#" onclick="insert_date('2008-09-01','2008-10-01')"><img src="images/admin/30.gif" border="0" align="absmiddle"></A>
		 <A HREF="#" onclick="insert_date('2008-09-24','2008-10-01')"><img src="images/admin/7.gif" border="0" align="absmiddle"></A>
		 <A HREF="#" onclick="insert_date('2008-09-30','2008-10-01')"><img src="images/admin/1.gif" border="0" align="absmiddle"></A>
		 <A HREF="#" onclick="insert_date('2008-10-01','2008-10-01')"><img src="images/admin/0.gif" border="0" align="absmiddle"></A>
				
				 <input type='text' name='sdate' size=10 readonly onClick="popUpCalendar(this,sdate,'yyyy-mm-dd');" style="cursor:hand" value=''>
				 ~
				 <input type='text' name='edate' size=10 readonly onClick="popUpCalendar(this,edate,'yyyy-mm-dd');" style="cursor:hand" value=''>		

				 <input type='submit' value='검 색'>
			</td>
		</tr>  
		</form>
	</table>


	<TABLE width='99%' cellpadding='10' cellspacing='1' border='0' bgcolor='#C0C0C0' align='center'>
		<TR bgcolor='#F5F5F5' align='center'>
			<TD></TD>
			<TD><B>총충전액</B> (①)</TD>
			<TD><B>총환전액</B> (②)</TD>
			<TD><B>거래차액</B> (① - ②)</TD>
			<TD><B>회원보유액</B> (③)</TD>
			<TD><B>정산액</B> (① - (② + ③))</TD>
		</TR>
		<TR bgcolor='#FFFFFF'>
			<TD align='center'><B>금액</B></TD>
			<TD align='center'>10,500,000원</TD>
			<TD align='center'>20,000원</TD>
			<TD align='center'>10,480,000원</TD>
			<TD align='center'>6,280,000원</TD>
			<TD align='center'>4,200,000원</TD>
		</TR>
		<TR bgcolor='#FFFFFF'>
			<TD align='center'>횟수</TD>
			<TD align='center'>5</TD>
			<TD align='center'>1</TD>
			<TD align='center'>-</TD>
			<TD align='center'>2</TD>
			<TD align='center'>-</TD>
		</TR>
	</TABLE>
<!-- *** 현재 배팅액 : 2000000 -->
                      
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
