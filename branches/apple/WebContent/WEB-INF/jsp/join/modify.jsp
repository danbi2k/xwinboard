<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.user.*"%>

<%@include file="../header.jsp"%>
<%
	String phone[] = null;
	String email[] = null;
	
	String _mobile = member.getMobile();
	String _email = member.getEmail();
	if (_mobile != null) {
		phone = _mobile.split("-");		
	}
	if (_email != null) {
		email = _email.split("@"); 
	} 
	
	boolean needBank = member.getBankName() == null || member.getBankName().length() == 0;
	boolean needExpire = member.getPasswordExpire().equals("Y");
%>
<div class='sub_ti1'>
		<img src='img/sub_member_modify_ti.gif' alt='회원정보변경' class='ml10 mr10 fl'>
		<div class='sub_ti_desc'>· 회원정보를 변경합니다.</div>
		<div class='state_bar'>
			<div class='state_bar_txt'>
			<span class='name'><%=member.getNickName()%></span> 님
			<span class='cash'>· Cash:<span class='val'><%=XwinUtil.comma3(member.getBalance())%></span></span> 
			<span class='apple'>· Apple:<span class='val'><%=XwinUtil.comma3(member.getPoint())%></span></span> 
			<!-- span class='link'><a href='myBet.aspx?mode=viewMyBettingList'>배팅내역보기</a></span -->
			</div>
		</div>
		<div class='sub_ti_bar'></div>
		</div>


		<div id='sub_content1'>
			<div class='member_modify'>
				<h3>· 회원정보변경안내</h3>
				<div class='box'>
					1. 회원정보는 패스워드만 변경이 가능합니다.<br>
					2. 기타 정보 변경을 원하시는 회원님은 고객센터로 요청해 주십시오.
				</div>
				<h3>· 회원정보변경</h3>
				<div class='box'>
					<form name='frm_mem'>
					<input type="hidden" name="userId" value="<%=member.getUserId()%>">
					<input type="hidden" name="phone1" value="<%=phone[0]%>"/>
					<input type="hidden" name="phone2" value="<%=phone[1]%>"/>
					<input type="hidden" name="phone3" value="<%=phone[2]%>"/>
					<input type="hidden" name="email1" value="<%=email[0]%>"/>
					<input type="hidden" name="email2" value="<%=email[1]%>">
					<input type="hidden" name="pin" value="<%=member.getPin()%>"/>
						<table>
						<tr>
							<th>아이디</th>
							<td><%=member.getUserId()%></td>
						</tr>
						<tr>
							<th>닉네임</th>
							<td><%=member.getNickName()%></td>
						</tr>
						<tr>	
							<th>이메일</th>
							<td><%=member.getEmail()%></td>
						</tr>
						<tr>	
							<th>환전계좌번호</th>
							<td><%=member.getBankName()%> <%=member.getBankNumber()%> <%=member.getBankOwner()%></td>
						</tr>
						<tr>
							<th>휴대폰번호</th>
							<td><%=member.getMobile()%> <img src='img/member_callnum_bt.gif' alt='인증번호요청' class='img_bt' onclick="sendAuthNumber()"> <br>
							<input type='checkbox' name='smsCheck' class='input_check' <%=member.getGetSms().equals("Y")?"checked":""%>> 경기결과SMS수신</td>
						</tr>
						<tr>
							<th>새 패스워드</th>
							<td><input type='password' name='password1' class='input_text w100'></td>
						</tr>
						<tr>
							<th>새 패스워드 확인 </th>
							<td><input type='password' name='password2' class='input_text w100'></td>
						</tr>
						<tr>
							<th>인증번호</th>
							<td><input type='text' name='phonePin' class='input_text w100'></td>
						</tr>
						</table>

					</form>
				</div>
				<!-- end box -->
				<div class='member_bt'>
				<img src='img/member_modifyok_bt.gif' alt='수정완료' class='img_bt' onclick="FnMemModify(frm_mem);">
				</div>
				<!-- end member_bt -->

				<!-- end box -->
				<h3>· 탈퇴신청</h3>
				<div class='exit'>
				탈퇴신청을 하시면, 관리자가 확인후 탈퇴를 처리해 드립니다.
캐쉬 잔액이 있을경우 환전 요청을 먼저 하시기 바랍니다. 
				</div>
				<!-- end exit -->

				<!-- end box -->
				<div class='member_bt'>
				<img src='img/member_exit_bt.gif' alt='탈퇴신청' class='img_bt' onclick="FnMemOut();"> 
				</div>
				<!-- end member_bt -->

	

			</div>
			<!-- end member_modify -->
		</div>
		<!-- sub_content1 -->

<script>
function sendAuthNumber(){
	var f = document.frm_mem;
	if (!f.phone2.value && f.phone2.value.length < 3) {
		alert("전화번호를 확인하시고 다시 넣어주세요");
		return;
	}

	if (!f.phone3.value && f.phone3.value.length < 4) {
		alert("전화번호를 확인하시고 다시 넣어주세요");
		return;
	}
	
	var query = "mode=sendAuthNumber";
	query += "&phone=" + f.phone1.value + "-" + f.phone2.value + "-" + f.phone3.value;
	
	var http = new JKL.ParseXML("member.aspx", query);
	var result = http.parse();

	alert(result.resultXml.message); 
}
</script>

<%@include file="../footer.jsp"%>