<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%@include file="../header.jsp"%>

<div class='sub_ti1'>
		<img src='img/sub_outcash_ti.gif' alt='환전요청' class='ml10 mr10 fl'>
		<div class='sub_ti_desc'>· 환전요청을 하시면 캐쉬를 실계좌로 입금해 드립니다.</div>
		<div class='sub_ti_bar'></div>
		</div>


		<div id='sub_content1'>
			<div class='outcash'>

				<div class='tab'>
				<img src='img/sub_outcash_on_ti.gif' onclick="location.href='moneyOut.aspx?mode=viewMoneyOutRequest'" style="cursor:hand;">
				<img src='img/sub_outcashlist_off_ti.gif' onclick="location.href='moneyOut.aspx?mode=viewMoneyOutRequestList'" style="cursor:hand;">
				</div>
				<div class='box tabbox'>
					<form name='frm'>
					<input type="hidden" name="account_bank" value="<%=member.getBankName()%>"/>
					<input type="hidden" name="account_num" value="<%=member.getBankNumber()%>"/>
					<input type="hidden" name="account_name" value="<%=member.getBankOwner()%>"/>
					<table>
					<tr>
						<th>캐쉬잔액</th>
						<td><%=XwinUtil.comma3(member.getBalance())%> 원</td>
					</tr>
					<tr>
						<th>환전 신청액</th>
						<td><input type='text' class='input_text w100' name='out_money' onkeyup="only123(this); comma3Input(this);"></td>
					</tr>
					<tr>
						<th>환전계좌 은행</th>
						<td><%=member.getBankName()%></td>
					</tr>
					<tr>
						<th>환전계좌 번호</th>
						<td><%=member.getBankNumber()%></td>
					</tr>
					<tr>
						<th>환전계좌 수취인</th>
						<td><%=member.getBankOwner()%></td>
					</tr>
					<tr>
						<th>환전 패스워드</th>
						<td><input type='password' class='input_text w100' name='pin'> *회원가입시 입력하신 환전 패스워드를 입력하세요!</td>
					</tr>
						
					
					</table>
					</form>
				</div>
				

				<div class='outcash_bt'>
				<img src='img/sub_outcash_bt.gif' class='img_bt' onclick="FnOutMoney_Submit(frm);">
				</div>
				

			</div>
			<!-- end outcash -->
		</div>
		<!-- sub_content1 -->


<%@include file="../footer.jsp"%>