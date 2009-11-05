<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.user.*"%>
<%@ page import="com.xwin.domain.*"%>

<%@include file="../header.jsp"%>

			<tr><td><img src="img/menu16.jpg" border="0"></td></tr>
			<tr><td style="padding-left:27px;"><img src="img/member_title.gif"border="0"></td>
			</tr>
</table>


<form name="frm_reg">
	<input name="password" type="hidden" value=""/>
     <table align="center" cellpadding="0" cellspacing="0" width="771"   background="img/bar1.gif">
    <tr>
        <td width="771" height="37" align="center" valign="middle" background="img/bar_bg.gif" class="menubar" style="font-weight: bold">
           회원가입양식        </td>
    </tr>
</table>
 <table align="center" cellpadding="0" cellspacing="0" width="771" height="213">
    <tr>
        <td width="771" height="132" background="img/minit_02.jpg" valign="top" style="padding:20">
           <table border=0 cellspacing=0 cellpadding=0 width=700 align="center">

<col width=100></col>
<col width=7></col>
<col width=500></col>



 

<tr>
 <td align=right class=menubar height=40height=40>아이디</td>
 <td></td>
 <td><input type=text name=userId maxlength=200 class=input2> <font color="red">★ 영문과 숫자 조합이 가능합니다</font></td>
</tr>


<tr>
 <td align=right class=menubar height=40>패스워드</td>
 <td></td>
 <td> <input type=password name=password1 maxlength=200 class=input2 > </td>
</tr>

<tr>
 <td align=right class=menubar height=40>패스워드 확인</td>
 <td></td>
 <td><input type=password name=password2 maxlength=200 class=input2 ></td>
</tr>
<tr>
 <td align=right class=menubar height=40>닉네임</td>
 <td></td>
 <td><input type=text name=nickName maxlength=200 class=input2></td>
</tr>
<tr>
 <td align=right class=menubar height=40>모바일PIN번호</td>
 <td></td>
 <td><input type=text name=pin maxlength=200 class=input2 onfocusout='only123(this)' onkeyup='only123(this)'> <font color="red">★ 원하시는 숫자 6자리를 입력해주세요.</font></td>
</tr>
<tr>
 <td align=right class=menubar height=40>핸드폰번호</td>
 <td></td>
 <td>
 	<select class="input2" name="phone1">
			<option value="010" >010</option>
			<option value="011" >011</option>
			<option value="016" >016</option>
			<option value="017" >017</option>
			<option value="018" >018</option>
			<option value="019" >019</option>
			</select> -
			<input class="input2" name="phone2" type="text" size="4" maxlength="4" value="" style='IME-MODE: inactive'> -
			<input class="input2" name="phone3" type="text" size="4" maxlength="4" value="" style='IME-MODE: inactive'>
	<img src="img/send.jpg" border="0" align="absmiddle" onClick="sendAuthNumber()"/><BR>
	배팅 결과 문자 수신 요청 <input type="checkbox" name="smsCheck" checked/>
</td>
</tr>
<tr>
 <td align=right class=menubar height=40>가입인증번호</td>
 <td></td>
 <td><input type="text" name=phonePin maxlength=200 class=input2 ></td>
</tr>
<tr>
 <td align=right class=menubar height=40>이메일</td>
 <td></td>
 <td><input class="input2" name="email1" type="text" value="" style='IME-MODE: inactive' onChange="han_clear(this);" onBlur="han_clear(this);"> @
			<input class="input2" name="email2" type="text" value="" style='IME-MODE: inactive' onChange="han_clear(this);" onBlur="han_clear(this);">
			<select class="input2" onChange="setEmail(this)">
				<option value=''>직접입력</option>
				<option value='naver.com'>naver.com</option>
				<option value='hanmail.net'>hanmail.net</option>
				<option value='hotmail.com'>hotmail.com</option>
				<option value='nate.com'>nate.com</option>
				<option value='yahoo.co.kr'>yahoo.co.kr</option>
				<option value='empas.com'>empas.com</option>
				<option value='dreamwiz.com'>dreamwiz.com</option>
				<option value='freechal.com'>freechal.com</option>
				<option value='lycos.co.kr'>lycos.co.kr</option>
				<option value='korea.com'>korea.com</option>
				<option value='gmail.com'>gmail.com</option>
				<option value='hanmir.com'>hanmir.com</option>
				<option value='paran.com'>paran.com</option>
			</select></td>
</tr>
<tr>
 <td align=right class=menubar height=40>계좌번호</td>
 <td></td>
 <td>은행명 :
			<select class="input2" name="bankName">
			<option value="">--선택--</option>
				<option value='국민' style=''>국민</option><option value='기업' style=''>기업</option><option value='농협' style=''>농협</option><option value='신한' style=''>신한</option><option value='조흥' style=''>조흥</option><option value='외환' style=''>외환</option><option value='우체국' style=''>우체국</option><option value='SC제일' style=''>SC제일</option><option value='하나' style=''>하나</option><option value='한국시티' style=''>한국시티</option><option value='한미' style=''>한미</option><option value='우리' style=''>우리</option><option value='경남' style=''>경남</option><option value='광주' style=''>광주</option><option value='대구' style=''>대구</option><option value='도이치' style=''>도이치</option><option value='부산' style=''>부산</option><option value='산업' style=''>산업</option><option value='수협' style=''>수협</option><option value='전북' style=''>전북</option><option value='제주' style=''>제주</option><option value='새마을' style=''>새마을</option><option value='신협' style=''>신협</option><option value='HSBC' style=''>HSBC</option><option value='상호저축' style=''>상호저축</option>
			</select>
			계좌번호 : <input class="input2" name="bankNumber" type="text" size="20" maxlength="20" value="" style='IME-MODE: inactive'>
			예금주 : <input class="input2" name="bankOwner" type="text" size="16" maxlength="16" value="" style='IME-MODE: inactive'><br>
			<font color="orange">
		  </td>
</tr>
</table>

        </td>
    </tr>
    <tr>
        <td width="771" height="44" background="img/minit_03.jpg">
            <p>&nbsp;</p>
        </td>
    </tr>
</table>
          <table align="center" cellpadding="0" cellspacing="0" width="771" height="40">
	        <tr>
			    <td width="771" height="40" align="center"><img onClick="FnMemReg(frm_reg);" src="img/join.jpg" border="0" align="absmiddle">&nbsp;<img src="img/back.jpg" onClick="location.reload();" border="0" align="absmiddle">
				</td>
			</tr>
		    
     </table>
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

function setEmail(obj)
{
	document.frm_reg.email2.value = obj.value
}

global_login = false;
</script>

<%@include file="../footer.jsp"%>