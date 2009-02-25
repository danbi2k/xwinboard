<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.xwin.domain.user.*" %>
<%@ page import="com.xwin.infra.util.*" %>

<%@include file="../header.jsp"%>

<div class='sub_ti1'>
		<img src='img/sub_outcash_ti.gif' alt='환전요청' class='ml10 mr10 fl'>
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
			<div class='outcash'>

				<div class='tab'>
				<img src='img/sub_outcash_on_ti.gif' onclick="location.href='sendcache.php?mode=viewMoneyOutRequest'" style="cursor:hand;">
				<img src='img/sub_outcashlist_off_ti.gif' onclick="location.href='sendcache.php?mode=viewMoneyOutRequestList'" style="cursor:hand;">
				</div>
				<div class='box tabbox'>
					<form name='frm'>
					<input type="hidden" name="account_bank" value="<%=member.getBankName()%>"/>
					<input type="hidden" name="account_num" value="<%=member.getBankNumber()%>"/>
					<input type="hidden" name="account_name" value="<%=member.getBankOwner()%>"/>
					<table>	
					<tr>
						<th>입금받을은행</th>
						<td><%=member.getBankName()%></td>
					</tr>
					<tr>
						<th>계좌 번호</th>
						<td><%=member.getBankNumber()%></td>
					</tr>
					<tr>
						<th>예금주</th>
						<td><%=member.getBankOwner()%></td>
					</tr>
					<tr>
						<th>보유캐쉬</th>
						<td><%=XwinUtil.comma3(member.getBalance())%> 원</td>
					</tr>				
					<tr>
						<th>환전금액</th>
						<td>
							<input type='text' class='input_text w100' name='out_money' onkeyup="only123(this); comma3Input(this);">
							※(주의) : 만원 단위만 환전가능합니다
						</td>
					</tr>
					<tr>
						<th>패스워드</th>
						<td><input type='password' class='input_text w100' name='password'></td>
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