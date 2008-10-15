<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.domain.user.*" %>

<%@include file="../header.jsp"%>

<%
	List<BankBook> bankBookList = (List<BankBook>) request.getAttribute("bankBookList");
%>

<!--
<table width="985" height="26" bgcolor="#333333" style="border:1 solid #efefef;">
<tr>
	<td align="center" width="60">Notice</td>
	<td width="*">공지사항나오는곳...</td>
	<td align="center" width="80">[이전][다음]</td>
</tr>
</table>

-->

<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_inmoney.gif"></td><td>입금계좌를 통해 머니를 충전합니다.</td></td>

	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">

	<table width="800" style="margin-top:10">
	<tr><td><b>머니 충전 방법</b></td></tr>
	</table>
	<table width="800" bgcolor="#333333" cellpadding="10" style="border:1 solid #909090;">
	<tr><td style="line-height:20px;">
		1. 입금하실 금액과 입금자명을 입력하고 [머니충전] 신청을 합니다.<br>

		2. 입금하실 계좌 번호를 꼭! 확인합니다. <br>
		3. 인터넷뱅킹, 폰뱅킹, 무통장입금, ATM이체 등의 방법으로 입금을 합니다.<br>
		4. 입금후 5분~10분 이내에 입금확인 처리가 됩니다.<br>
		※ 입력하신 정보(입금액/입금자명)와 실제입금금액/입금자명이 동일해야만 처리가 가능합니다.<br>
	</td></tr>
	</table>

	<table width="800" cellpadding="0" cellspacing="0" style="margin-top:15">
	<tr><td>
		<table  cellpadding="0" cellspacing="0" >
		<tr><td><img src="images/tab_inmoney.gif"		onclick="location.href='moneyIn.aspx?mode=viewMoneyInRequest'" style="cursor:hand;"></td>
			<td><img src="images/tab_inmoney_list.gif" onclick="location.href='moneyIn.aspx?mode=viewMoneyInRequestList'" style="cursor:hand;filter:gray();" hspace="3"></td>
		</tr></table>
	</td></tr>
	</table>

	
	
	<form name="frm" method="post">

	<table width="800" bgcolor="#333333" cellpadding="10" style="border:1 solid #909090;">
	<colgroup>
	<col width="100" align="center">
	<col width="700">
	</colgroup>
	<tr><td>아이디</td>
		<td><%=member.getUserId()%></td></tr>

	<tr><td>입금계좌</td>
		<td>
			
				<select name="bankBookId" style="font-size:18px;font-weight:bold;color:orange;background-color:black;">
				
				<%
				if (bankBookList != null) {
					for (BankBook bankBook : bankBookList) {
				%>
				<option value="<%=bankBook.getId()%>">[<%=bankBook.getBankName()%>] <%=bankBook.getNumber()%> (<%=bankBook.getName()%>)　　</option>				<%
					}
				}
				%>				
				</select> <font color="orange">☜ 계좌번호 꼭 확인하세요!
			
		</td></tr>
	<tr><td>입금예정액</td>

		<td><table width="100%" cellpadding="0" cellspacing="0"><tr>
			<td width="170"><input class="member" name="money" type="text" value="" maxlength="11" style="IME-MODE: disabled;text-align:right;" onkeyup="only123(this); comma3Input(this);" onblur=""> 원<td>
			<td>

				<table>
				<tr>
				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:black;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='10,000';frm.name.focus();">1만원</span></td>
				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:black;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='20,000';frm.name.focus();">2만원</span></td>

				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:black;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='30,000';frm.name.focus();">3만원</span></td>
				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:black;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='50,000';frm.name.focus();">5만원</span></td>
				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='100,000';frm.name.focus();">10만원</span></td>
				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='150,000';frm.name.focus();">15만원</span></td>
				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='200,000';frm.name.focus();">20만원</span></td>
				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='250,000';frm.name.focus();">25만원</span></td>

				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='300,000';frm.name.focus();">30만원</span></td>
				</tr>
				<tr>
				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='500,000';frm.name.focus();">50만원</span></td>
				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='600,000';frm.name.focus();">60만원</span></td>
				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='700,000';frm.name.focus();">70만원</span></td>
				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='800,000';frm.name.focus();">80만원</span></td>

				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='900,000';frm.name.focus();">90만원</span></td>
				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='1,000,000';frm.name.focus();">100만원</span></td>
				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='2,000,000';frm.name.focus();">200만원</span></td>
				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='3,000,000';frm.name.focus();">300만원</span></td>
				<td><span style="width:48;height:16;background:url('images/btn_money_bg.gif');color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:5;cursor:hand" onclick="frm.money.value='5,000,000';frm.name.focus();">500만원</span></td>
				</tr>

				</table>

			</td></tr>
			</table>
		</td></tr>
	<tr><td>입금자</td>
		<td><input class="member" name="name" maxlength="7" type="text" value=""><font color="orange"> ☜ 이체시 '보내는분'과 동일해야 합니다.</td></tr>
	
	</table>

	<table width="800" style="margin-top:10">
	<tr><td align="center">	

		
		<img src="images/btn_inmoney.gif" onclick="FnInMoney_Submit(frm);" style="cursor:hand">
		

		<img src="images/btn_cancle.gif" onclick="location.href='/';" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';" hspace="5">

	</td></tr>
	</table>

	</form>

	


	<br><br>


</td></tr>
</table>

<%@include file="../footer.jsp"%>