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
<!--
<table width="985" height="26" bgcolor="#333333" style="border:1 solid #efefef;">
<tr>
	<td align="center" width="60">Notice</td>
	<td width="*">공지사항나오는곳...</td>
	<td align="center" width="80">[이전][다음]</td>
</tr>
</table>

-->

<Script>
function SetNICK(nick){
	var frm = document.all.frm_mem;
	frm.nick.value = nick;
	frm.nick_input.value = nick;
}
</Script>

<table width="960" height="400" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	
<table width="900" style="border-bottom:1 solid #909090;">
	<tr>
		<td width="100"><img src="images/title_memberinfo.gif"></td>
		<td>회원정보를 수정합니다.</td>
	</tr>
	</table>
</td></tr>
<tr><td valign="top" align="center">

	<form name="frm_mem">
	<input type="hidden" name="userId" value="<%=member.getUserId()%>">
	<input type="hidden" name="phone1" value="<%=phone[0]%>"/>
	<input type="hidden" name="phone2" value="<%=phone[1]%>"/>
	<input type="hidden" name="phone3" value="<%=phone[2]%>"/>
	<input type="hidden" name="email1" value="<%=email[0]%>"/>
	<input type="hidden" name="email2" value="<%=email[1]%>">
	<table width="800" style="margin-top:10">
	<tr><td><b>회원 정보 수정</b></td></tr>
	</table>

	<table width="800" bgcolor="#333333" cellpadding="5" style="border:1 solid #909090;">
	<colgroup>
	<col width="150" align="center">
	<col width="650">
	</colgroup>

	<tr><td>회원아이디</td>
		<td><%=member.getUserId()%></td></tr>
	<tr><td>새 비밀번호</td>
		<td><input class="member" name="password1" type="password"></td></tr>
	<tr><td>새 비밀번호 확인</td>
		<td><input class="member" name="password2" type="password"></td></tr>
	<tr><td>닉네임</td>
		<td><%=member.getNickName()%></td>
	<tr><td>휴대폰번호</td>
		<td><%=member.getMobile()%>
			<input type="button" value="인증번호전송" onclick="sendAuthNumber()"/><br>
			<input type="checkbox" name="smsCheck" <%=member.getGetSms().equals("Y")?"checked":""%>/>  체크 하시면 경기결과를 문자로 전송해 드립니다.	
			</td></tr>
	<tr><td>인증번호</td>
		<td><input class="member" name="phonePin" type="password"></td></tr>
	<tr><td>이메일</td>
		<td><%=member.getEmail()%></td></tr>
	
	<%if (needBank) { %>
	<tr><td>환전계좌번호</td>
		<td>	
			은행명 :
			<select class="member" name="bankName">
			<option value="">--선택--</option>
				<option value='국민' style=''>국민</option><option value='기업' style=''>기업</option><option value='농협' style=''>농협</option><option value='신한' style=''>신한</option><option value='조흥' style=''>조흥</option><option value='외환' style=''>외환</option><option value='우체국' style=''>우체국</option><option value='SC제일' style=''>SC제일</option><option value='하나' style=''>하나</option><option value='한국시티' style=''>한국시티</option><option value='한미' style=''>한미</option><option value='우리' style=''>우리</option><option value='경남' style=''>경남</option><option value='광주' style=''>광주</option><option value='대구' style=''>대구</option><option value='도이치' style=''>도이치</option><option value='부산' style=''>부산</option><option value='산업' style=''>산업</option><option value='수협' style=''>수협</option><option value='전북' style=''>전북</option><option value='제주' style=''>제주</option><option value='새마을' style=''>새마을</option><option value='신협' style=''>신협</option><option value='HSBC' style=''>HSBC</option><option value='상호저축' style=''>상호저축</option>
			</select>
			계좌번호 : <input class="member" name="bankNumber" type="text" size="20" maxlength="20" value="" style='IME-MODE: inactive'>
			예금주 : <input class="member" name="bankOwner" type="text" size="16" maxlength="16" value="" style='IME-MODE: inactive'><br>
			<font color="orange">※ 환전은 가입시 등록하신 환전계좌로만 가능하며 환전계좌 변경시에는 고객센터를 이용해 요청해주시면 본인인증과정을 거쳐 변경해 드립니다.</font>
			</td></tr>
	<%} else { %>
	<tr><td>환전계좌번호</td>
		<td><%=member.getBankName()%> <%=member.getBankNumber()%> <%=member.getBankOwner()%></td>
	<%} %>
	</tr>
	<tr><td valign=top><b><font color=#FF9933>새 환전비밀번호<br>[사이트 해킹방지용<br> 비밀번호입니다]</font></b></td>
		<td><input class="member" name="pin" type="password" value=""/>
	</tr>
	</table>

	<table width="800" style="margin-top:10">
	<tr><td align="center">

		<img src="images/btn_modifyok.gif" onclick="FnMemModify(frm_mem);" style="cursor:hand;" hspace="5">		
		<img src="images/btn_cancle.gif" onclick="location.href='/';" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';" hspace="5">

	</td></tr>
	</table>

	</form>



	<table width="800" style="margin-top:10">
	<tr><td><b>탈퇴 신청</b></td></tr>

	</table>

	<table width="800" height="50" bgcolor="#333333" cellpadding="15" style="border:1 solid #909090;">
	<tr><td>
		
		탈퇴신청을 하시면, 관리자가 확인후 탈퇴를 처리해 드립니다.<br>
		머니 잔액이 있을경우 환전 요청을 먼저 하시기 바랍니다.
		
	</td></tr>
	</table>

	<table width="800" style="margin-top:10">

	<tr><td align="center">
		
		
		<img src="images/btn_outside.gif" onclick="FnMemOut();" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';">
		

	</td></tr>
	</table>

	<br><br>

</td></tr>
</table>

<script>
<%
if (needBank) {
%>
alert("환전계좌를 등록해 주십시오\n환전업무는 등록된 환전계좌로만 가능하며 환전계좌 변경시에는\n고객센터로 문의해주시면 본인인증절차를 거쳐 변경해드립니다");
<%
}
%>

<%
if (needExpire) {
%>
alert("비밀번호가 만료되었습니다\n비밀번호를 변경해 주십시오\n");
<%
}
%>

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