<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="header.jsp"%>
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

	<tr><td width="100"><img src="images/title_memberinfo.gif"></td><td>회원정보를 수정합니다.</td></td>
	</table>
</td></tr>
<tr><td valign="top" align="center">

	<form name="frm_mem" method="post">
	<input type="hidden" name="nick"  value="후지모토">
	<input type="hidden" name="phone">
	<input type="hidden" name="email">

	<table width="800" style="margin-top:10">
	<tr><td><b>회원 정보 수정</td></tr>
	</table>

	<table width="800" bgcolor="#333333" cellpadding="5" style="border:1 solid #909090;">
	<colgroup>
	<col width="150" align="center">
	<col width="650">
	</colgroup>

	<tr><td>회원아이디</td>
		<td>huzi</td></tr>
	<tr><td>비밀번호 변경</td>
		<td><input class="member" name="pw" type="password"></td></tr>
	<tr><td>비밀번호 변경 확인</td>
		<td><input class="member" name="pw2" type="password"></td></tr>
	<tr><td>닉네임</td>

		<td><table cellpadding="0" cellspacing="0"><tr>
			<td><input class="member" name="nick_input" type="text" value="후지모토"></td>
			<td><img src="images/btn_dualcheck.gif" onclick="check_nick(frm_mem);" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';" hspace="5"></td>
			</tr></table>
		</td></tr>
	<tr><td>휴대폰번호</td>
		<td><select class="member" name="phone1">
			<option value="010" selected>010</option>

			<option value="011" >011</option>
			<option value="016" >016</option>
			<option value="017" >017</option>
			<option value="018" >018</option>
			<option value="019" >019</option>
			</select> -
			<input class="member" name="phone2" type="text" size="4" maxlength="4" value="1111" style='IME-MODE: inactive'> -
			<input class="member" name="phone3" type="text" size="4" maxlength="4" value="1111" style='IME-MODE: inactive'>

			</td></tr>
	<tr><td>이메일</td>
		<td><input class="member" name="email1" type="text" value="huzi.kenta" style='IME-MODE: inactive' onchange="han_clear(this);" onblur="han_clear(this);"> @
			<input class="member" name="email2" type="text" value="gmail.com" style='IME-MODE: inactive' onchange="han_clear(this);" onblur="han_clear(this);"></td></tr>
	
	</table>

	<table width="800" style="margin-top:10">
	<tr><td align="center">

		<img src="images/btn_modifyok.gif" onclick="FnMemModify(frm_mem);" style="cursor:hand;" hspace="5">		
		<img src="images/btn_cancle.gif" onclick="location.href='/';" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';" hspace="5">

	</td></tr>
	</table>

	</form>



	<table width="800" style="margin-top:10">
	<tr><td><b>탈퇴 신청</td></tr>

	</table>

	<table width="800" height="50" bgcolor="#333333" cellpadding="15" style="border:1 solid #909090;">
	<tr><td>
		
		탈퇴신청을 하시면, 관리자가 확인후 탈퇴를 처리해 드립니다.<br>
		머니 잔액이 있을경우 출금 요청을 먼저 하시기 바랍니다.
		
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

<%@include file="footer.jsp"%>