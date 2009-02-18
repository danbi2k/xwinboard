<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.domain.user.*" %>

<%@include file="../header.jsp"%>

<%
	List<BankBook> bankBookList = (List<BankBook>) request.getAttribute("bankBookList");
%>

<div class='sub_ti1'>
		<img src='img/sub_incash_ti.gif' alt='캐쉬충전' class='ml10 mr10 fl'>
		<div class='sub_ti_desc'>· 입금계좌를 통해 캐쉬를 충전합니다.</div>
		<div class='sub_ti_bar'></div>
		</div>


		<div id='sub_content1'>
			<div class='incash'>
				<h3>· 캐쉬충전 방법</h3>
				<div class='box'>
					1. 입금하실 금액과 입금자명을 입력하고 [캐쉬충전] 신청을 합니다.<br>
					2. 입금하실 계좌 번호를 꼭! 확인합니다. <br>
					3. 인터넷뱅킹, 폰뱅킹, 무통장입금, ATM이체 등의 방법으로 입금을 합니다.<br>
					4. 입금자명과 입금액이 동일시 입금후 2~3분이내 자동충전 처리 됩니다.<br>
					5. 신청하신후 1시간 이내에 입금되지 않은 신청은 자동취소 처리 됩니다.<br>
					<b>※ 입력하신 정보(입금액/입금자명)와 실제입금금액/입금자명이 동일해야만 처리가 가능합니다.</b>
				</div>


				<div class='tab'>
				<img src='img/sub_incash_on_ti.gif' onclick="location.href='moneyIn.aspx?mode=viewMoneyInRequest'" style="cursor:hand;">
				<img src='img/sub_incashlist_off_ti.gif' class='img_bt' onclick="location.href='moneyIn.aspx?mode=viewMoneyInRequestList'" style="cursor:hand;">
				</div>
				<div class='box tabbox'>
					<form name="frm" method="post">
					<table>
					<tr>
						<th>아이디</th>
						<td><%=member.getUserId()%></td>
					</tr>
					<tr>
						<th>입금계좌</th>
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
						</td>
					</tr>
					<tr>
						<th>입금예정액</th>
						<td>
							<div class='fl'>
							<input class="input_text" name="money" type="text" value="" maxlength="11" style="IME-MODE: disabled;text-align:right;" onkeyup="only123(this); comma3Input(this);" onblur=""> 원<BR>
							<font color="orange"><b>※ 직접입력가능</b></font>
							</div>
							<div class='fl ml15 pl5'>
							<span class='cash1'  onclick="frm.money.value='10,000';frm.name.focus();">1만원</span>
							<span class='cash1'  onclick="frm.money.value='20,000';frm.name.focus();">2만원</span>
							<span class='cash1'  onclick="frm.money.value='30,000';frm.name.focus();">3만원</span>
							<span class='cash1'  onclick="frm.money.value='50,000';frm.name.focus();">5만원</span>
							<span class='cash2' onclick="frm.money.value='100,000';frm.name.focus();">10만원</span>
							<span class='cash2' onclick="frm.money.value='150,000';frm.name.focus();">15만원</span>
							<span class='cash2' onclick="frm.money.value='200,000';frm.name.focus();">20만원</span>
							<span class='cash2' onclick="frm.money.value='250,000';frm.name.focus();">25만원</span>
							<span class='cash2' onclick="frm.money.value='300,000';frm.name.focus();">30만원</span>
							<br>
							<span class='cash2' onclick="frm.money.value='500,000';frm.name.focus();">50만원</span>
							<span class='cash2' onclick="frm.money.value='600,000';frm.name.focus();">60만원</span>
							<span class='cash2' onclick="frm.money.value='700,000';frm.name.focus();">70만원</span>
							<span class='cash2' onclick="frm.money.value='800,000';frm.name.focus();">80만원</span>
							<span class='cash2' onclick="frm.money.value='900,000';frm.name.focus();">90만원</span>
							<span class='cash3' onclick="frm.money.value='1,000,000';frm.name.focus();">100만원</span>
							<span class='cash3' onclick="frm.money.value='2,000,000';frm.name.focus();">200만원</span>
							<span class='cash3' onclick="frm.money.value='3,000,000';frm.name.focus();">300만원</span>
							<span class='cash3' onclick="frm.money.value='5,000,000';frm.name.focus();">500만원</span>
							</div>
						</td>
					</tr>
					<tr>
						<th>입금자</th>
						<td><input class="input_text" name="name" maxlength="7" type="text" value=""><font color="orange"> ☜ 이체시 '보내는분'과 동일해야 합니다.</td>
					</tr>
					</table>
					</form>
						
				</div>
				<div class='incash_bt'>
				<img src='img/sub_incash_bt.gif' class='img_bt' onclick="FnInMoney_Submit(frm);" >
				</div>

				
				

			</div>
			<!-- end incash -->
		</div>
		<!-- sub_content1 -->

<%@include file="../footer.jsp"%>