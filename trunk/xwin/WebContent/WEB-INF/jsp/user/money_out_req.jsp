<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%@include file="../header.jsp"%>

<!--
<table width="985" height="26" bgcolor="#333333" style="border:1 solid #efefef;">
<tr>
	<td align="center" width="60">Notice</td>
	<td width="*">공지사항나오는곳...</td>
	<td align="center" width="80">[이전][다음]</td>
</tr>
</table>

-->

<table width="960"  style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_outmoney.gif"></td><td>출금요청을 하시면 머니를 실계좌로 입금해 드립니다.</td>

	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">


	<table width="800" cellpadding="0" cellspacing="0" style="margin-top:15">
	<tr><td>
		<table  cellpadding="0" cellspacing="0" >
		<tr><td><img src="images/tab_outmoney.gif"		 onclick="location.href='moneyOut.aspx?mode=viewMoneyOutRequest'" style="cursor:hand;"></td>
			<td><img src="images/tab_outmoney_list.gif" onclick="location.href='moneyOut.aspx?mode=viewMoneyOutRequestList'" style="cursor:hand;filter:gray();" hspace="3"></td>
		</tr></table>

	</td></tr>
	</table>



	<form name="frm" method="post">

	<table width="800" bgcolor="#333333" cellpadding="10" style="border:1 solid #909090;">
	<colgroup>
	<col width="150" align="center">
	<col width="650">

	</colgroup>
	<tr><td>머니 잔액</td>
		<td><%=member.getBalance()%> 원</td></tr>
	<tr><td>출금 신청액</td>
		<td><input class="member" name="out_money" type="text" value="" maxlength="11" style="IME-MODE: disabled;text-align:right" onkeyup="only123(this);"> 원
			
		</td></tr>
	<tr><td>출금계좌 은행</td>

		<td><select name="account_bank" style="background-color:black;color:white;">
				<option value="">--선택--</option>
				<option value='국민' style=''>국민</option><option value='기업' style=''>기업</option><option value='농협' style=''>농협</option><option value='신한' style=''>신한</option><option value='조흥' style=''>조흥</option><option value='외환' style=''>외환</option><option value='우체국' style=''>우체국</option><option value='SC제일' style=''>SC제일</option><option value='하나' style=''>하나</option><option value='한국시티' style=''>한국시티</option><option value='한미' style=''>한미</option><option value='우리' style=''>우리</option><option value='경남' style=''>경남</option><option value='광주' style=''>광주</option><option value='대구' style=''>대구</option><option value='도이치' style=''>도이치</option><option value='부산' style=''>부산</option><option value='산업' style=''>산업</option><option value='수협' style=''>수협</option><option value='전북' style=''>전북</option><option value='제주' style=''>제주</option><option value='새마을' style=''>새마을</option><option value='신협' style=''>신협</option><option value='HSBC' style=''>HSBC</option><option value='상호저축' style=''>상호저축</option>

			</select>
	<tr><td>출금계좌 번호</td>
		<td><input class="member" name="account_num" type="text" value=""></td></tr>
	<tr><td>출금계좌 수취인</td>
		<td><input class="member" name="account_name" type="text" value=""></td></tr>

	<tr><td>출금 비밀번호</td>
		<td><input class="member" name="pin" type="password" value="">

		회원가입시 입력하신 출금 비밀번호를 입력하세요!)
		</td></tr>

	
	</table>

	<table width="800" style="margin-top:10">
	<tr><td align="center">


		
		<img src="images/btn_outmoney.gif" onclick="FnOutMoney_Submit(frm);" style="cursor:hand">
		

		<img src="images/btn_cancle.gif" onclick="location.href='/';" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';" hspace="5">

	</td></tr>
	</table>

	</form>




</td></tr>
</table>


<%@include file="../footer.jsp"%>