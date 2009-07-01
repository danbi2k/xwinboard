<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.admin.*" %>
<%@ page import="com.xwin.domain.user.*" %>

<%@include file="../header.jsp"%>

<%
	List<BankBook> bankBookList = (List<BankBook>) request.getAttribute("bankBookList");
	BankBook bankBook = null;
	if (bankBookList != null) {
		int size = bankBookList.size();
		String mobile = member.getMobile();
		String lastDigit = mobile.substring(mobile.length()-1);
		int digit = Integer.parseInt(lastDigit);
		bankBook = bankBookList.get(digit % size);
	}
%>

<div class='sub_ti1'>
		<img src='img/sub_incash_ti.gif' alt='캐쉬충전' class='ml10 mr10 fl'>
		<div class='sub_ti_desc'></div>
		<div class='state_bar'>
			<div class='state_bar_txt'>
			<span class='name'><%=member.getNickName()%></span> 님
			<span class='cash'>· Cash:<span class='val'><%=XwinUtil.comma3(member.getBalance())%></span></span> 
			<span class='apple'>· Apple:<span class='val'><%=XwinUtil.comma3(member.getPoint())%></span></span> 
			<!-- span class='link'><a href='betlog.php?mode=viewMyBettingList'>배팅내역보기</a></span -->
			</div>
		</div>
		<div class='sub_ti_bar'></div>
		</div>


		<div id='sub_content1'>
			<div class='incash'>
				<h3>· 캐쉬충전 방법</h3>
				<div class='box'>
					1. 입금(충전)하실 금액을 "입금예정액"에 기록합니다.<br>
					2. 입금자명에 이체시 "보내는분"과 동일한 이름을 기록합니다.<br>
					3. 입금계좌에 인터넷뱅킹, 폰뱅킹, 무통장입금, ATM등의 방법으로 입금합니다.<br>
					  <b>※(주의): 입력하신 정보(입금예정액/입금자명)와 실제입금금액/입금자명이 동일하여야 합니다.</b><br>
					  <b>※(주의): 신청하신 후 1시간 이내에 입금되지 않으면 취소 처리됩니다.</b>
				</div>


				<div class='tab'>
				<img src='img/sub_incash_on_ti.gif' onclick="location.href='earncache.php?mode=viewMoneyInRequest'" style="cursor:hand;">
				<img src='img/sub_incashlist_off_ti.gif' class='img_bt' onclick="location.href='earncache.php?mode=viewMoneyInRequestList'" style="cursor:hand;">
				</div>
				<div class='box tabbox'>
					<form name="frm" method="post">
					<input type='hidden' name='bankBookId' value='<%=bankBook.getId()%>'/>
					<table>
					<tr>
						<th>은행명</th>
						<td><%=bankBook.getBankName()%></td>
					</tr>
					<tr>
						<th>계좌번호</th>
						<td><%=bankBook.getNumber()%></td>
					</tr>
					<tr>
						<th>예금주</th>
						<td><%=bankBook.getName()%></td>
					</tr>
					<tr>
						<th>입금액</th>
						<td>
							<div class='fl'>
							<input class="input_text" name="money" type="text" value="" maxlength="11" style="IME-MODE: disabled;text-align:right;" onkeyup="only123(this); comma3Input(this);" onblur=""> 원<BR>
							<font color="orange"><b></b></font>
							</div>
							<div class='fl ml15 pl5'>
							</div>
						</td>
					</tr>
					<tr>
						<th>입금자명</th>
						<td><input class="input_text" name="name" maxlength="7" type="text" value=""><font color="orange"></td>
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