<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setAttribute("isIndex", Boolean.TRUE);
%>
<%@include file="../header.jsp"%>
<div class='sub_ti1'>
		<img src='img/sub_member_ti.gif' alt='회원가입' class='ml10 mr10 fl'>
		<div class='sub_ti_desc'></div>
		<div class='sub_ti_bar'></div>
		</div>


		<div id='sub_content1'>
			<div class='member_modify'>
				<h3>· 가입신청서</h3>
				<div class='box'>
					<form name='frm_reg'>
						<input name="password" type="hidden" value=""/>
						<input name="pin" type="hidden" value=""/>
						<table>
						<tr>
							<th>아이디</th>
							<td><input type='text' name='userId' class='input_text w100' onfocusout='abc123(this)' onkeyup='abc123(this)'> <font color="yellow">★ 영문과 숫자 조합이 가능합니다</font></td>
						</tr>
						<tr>
							<th>패스워드</th>
							<td><input type='password' name='password1' class='input_text w100'></td>
						</tr>
						<tr>
							<th>패스워드 확인 </th>
							<td><input type='password' name='password2' class='input_text w100'></td>
						</tr>
						<tr>
							<th>별명</th>
							<td><input type='text' name='nickName' class='input_text w100'></td>
						</tr>
						<tr>
							<th>핸드폰번호</th>
							<td>
								<select class="w100" name="phone1">
									<option value="010" >010</option>
									<option value="011" >011</option>
									<option value="016" >016</option>
									<option value="017" >017</option>
									<option value="018" >018</option>
									<option value="019" >019</option>
								</select> -
								<input type='text' name='phone2' class='input_text w40'> -
								<input type='text' name='phone3' class='input_text w40'>
								<img src='img/member_callnum_bt.gif' alt='인증번호요청' class='img_bt' onclick="sendAuthNumber()"> <br>
								배팅 결과 문자 수신 요청 <input type='checkbox' name='smsCheck' class='input_check' checked>
							</td>
						</tr>
						<tr>
							<th>가입인증번호</th>
							<td><input type='text' name='phonePin' class='input_text w100'> <font color="yellow">★ 대소문자를 정확히 구분해 주세요. 전송시 시간이 다소 걸릴 수 있습니다.</font></td>
						</tr>
						<tr>	
							<th>이메일</th>
							<td><input type='text' name='email1' class='input_text w90'>&nbsp;@&nbsp;
								<input type='text' name='email2' class='input_text w90'></td>
						</tr>
						<tr>	
							<th>계좌번호</th>
							<td>
								은행명 :
								<select class="member" name="bankName">
								<option value="">--선택--</option>
									<option value='국민' style=''>국민</option><option value='기업' style=''>기업</option><option value='농협' style=''>농협</option><option value='신한' style=''>신한</option><option value='조흥' style=''>조흥</option><option value='외환' style=''>외환</option><option value='우체국' style=''>우체국</option><option value='SC제일' style=''>SC제일</option><option value='하나' style=''>하나</option><option value='한국시티' style=''>한국시티</option><option value='한미' style=''>한미</option><option value='우리' style=''>우리</option><option value='경남' style=''>경남</option><option value='광주' style=''>광주</option><option value='대구' style=''>대구</option><option value='도이치' style=''>도이치</option><option value='부산' style=''>부산</option><option value='산업' style=''>산업</option><option value='수협' style=''>수협</option><option value='전북' style=''>전북</option><option value='제주' style=''>제주</option><option value='새마을' style=''>새마을</option><option value='신협' style=''>신협</option><option value='HSBC' style=''>HSBC</option><option value='상호저축' style=''>상호저축</option>
								</select>
								계좌번호 : <input type='text' name='bankNumber' class='input_text w120'>
								예금주 : <input type='text' name='bankOwner' class='input_text w90'><br>
							</td>
						</tr>
						<tr>	
							<th>프랜드 아이디</th> 
							<td><input type='text' name='introducerId' class='input_text w100'> <font color="yellow">★ 로그인아이디를 적어주세요. 닉네임을 적으시면 안됩니다.</font></td>
						</tr>
						</table>

					</form>
				</div>
				<!-- end box -->
				<div class='member_bt'>
				<img src='img/board_writeok_bt.gif' alt='작성완료' class='img_bt' onclick="FnMemReg(frm_reg);"> 
				</div>
				<!-- end member_bt -->

				<!-- end box -->
				<!-- end exit -->

				<!-- end box -->
				<!-- end member_bt -->

	

			</div>
			<!-- end member_modify -->
		</div>
		<!-- sub_content1 -->

<script>
function sendAuthNumber(){
	var f = document.frm_reg;
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
	
	var http = new JKL.ParseXML("user.php", query);
	var result = http.parse();

	alert(result.resultXml.message); 
}
</script>
<%@include file="../footer.jsp"%>

