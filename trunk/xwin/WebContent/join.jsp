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
function SetID(id){
	var frm = document.all.frm_reg;
	frm.id.value = id;
	frm.id_input.value = id;
}
function SetRID(r_id){
	var frm = document.all.frm_reg;
	frm.r_id.value = r_id;
}
function SetNICK(nick){
	var frm = document.all.frm_reg;
	frm.nick.value = nick;
	frm.nick_input.value = nick;
}
</Script>

<table width="960" height="400" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">

	<tr><td width="100"><img src="images/title_memberjoin.gif"></td><td>이용약관을 읽으신후 약관에 동의하셔야 합니다.</td></td>
	</table>
</td></tr>
<tr><td valign="top" align="center">

	<form name="frm_reg" method="post">
	<input type="hidden" name="id"    value="">
	<input type="hidden" name="nick"  value="">
	<input type="hidden" name="phone">
	<input type="hidden" name="email">

	<table width="800" style="margin-top:10">
	<tr><td><b>회원이용약관</b></td></tr>
	</table>
	<table width="800" bgcolor="#333333" cellpadding="5" style="border:1 solid #909090;">
	<tr><td style="line-height:20px;">
<span style="width:100%;height:240;OVERFLOW:auto">
<b style='color:white'>1.</b> 10xbet.com(이하 회사)는 회원님이 계정을 가지고 있을 때 아래의 내용에 동의 한다고 가정합니다.<br>

    회원 가입을 통해 고객은 이용약관에 대해 완전히 이해하고 동의하는 것으로 간주됩니다.<br>
    약관및 규정은 꼼꼼히 읽어 보시기를 권장 합니다.<br>
    회사는 회원님들께서 이용약관을 충전 시나 환전 시 또는 배팅을 하실 때나 그 후에도 주기적으로 읽어보시길 권유합니다.<br>
<b style='color:white'>2.</b> 회사는 이용약관을 언제든지 변경하거나 추가 할 수 있습니다.<br>
    이용약관의 변경에 대한 내용은 사이트 내에 공지와 동시에 적용되며, 본 문서에 추가 됩니다. <br>
<b style='color:white'>3.</b> 각 회원님들이 위치하고 계신 국가별 법적인 제한으로 어떤 국가들에서는 사이트들에 대한 접속이 차단될 수도 있습니다.<br>

    그러나 회사는 이에 대한 책임을 지거나 해결 할 수 없으며, 원칙적으로 접속을 제한하지 않습니다.<br>
    단 악의적인 사용자로 판단되었거나, 사이트의 원활한 서비스 제공을 위해 일시적으로 특정 지역에 위치한 회원이나 특정회원의<br>
    접속을 제한할 수 있는 권리가 있습니다.<br>
<b style='color:white'>4.</b> 회원님들이 회원가입을 하시면 가입시의 절차에 따라 자동으로 회원 가입이 승인 됩니다.<br>
    특별히 회원 가입 승인에 제한을 두지 않으나, 악의적인 사용자와 사이트의 원활한 서비스 제고을 위해 승인을 거부 하거나 취소 할 수 있습니다.	
    회사는 회원님들이 가입시 기재한 어떠한 정보도 제	 3자에게 제공하거나 노출하지 않으며, 가능한 모든 방법을 동원하여 회원님들의 정보 보호에	
    만전을 다하고 있습니다만 불가항력적인 이유로 정보가 노출될 수도 있습니다.<br>
<b style='color:white'>5.</b> 회원가입에 연령은 성인 즉 만 19세를 기준으로 합니다. 회사는 19세 미만의 고객이라고 판단되면 언제든지 해당회원의 접근을 제한<br>

   하거나 가입 승인을 취소하거나, 심지어 배팅을 하였다 하더라도 이에 대한 금액 지불을 거부할 수 있습니다.<br>
<b style='color:white'>6.</b> 회원은 자신의 회원아이디와 비밀번호의 비밀엄수에 대한 책임을 가지고 있습니다. 이러한 세부사항을 인지하고 있는 제 3자에 의해 만들어진 배팅이 유효한 것으로 간주 되며, 이에 따른 어떠한 책임도 회사는 지지 않습니다. <br>
    출금비밀번호의 변경은 회원의 보유머니가 없는경우에만 변경될수 있습니다. [아이디 해킹방지를 위해 출금비밀번호제도를 운영합니다]<br>
<b style='color:white'>7.</b> 회원은 언제든지 자신의 배팅머니를 사용하거나 환전신청하여 인출 할 수 있습니다.<br>
<b style='color:white'>8.</b> 만약 회원의 배팅머니와 관련된 배당금의 합계나 충전, 또는 환전에 따른 여러 계산에서 잘못된 점이 있다면 이에 대한 신고와 재확인 요구<br>

   는 회원에게 있습니다. 회원이 신고하거나 재확인 요구를 하지 않아서 발생한 직접 또는 간접적인 모든 배팅이나 충전, 환전 등 배팅 머니와 관련된
    일련의 모든 행위들은 모두 취소 처리 될 것입니다.<br>
<b style='color:white'>9.</b> 회사는 모든 회원님들께 친절하고 편리한 서비스를 제공하는것을 목표로 삼고 있지만, 회사에 악의적인 특정한 계정에 대해서 회원자격을 박탈 할 수 있습니다.<br>
    이러한 경우에 해당 아이디의 모든 배팅머니는 몰수 되고 사이트 내에서의 모든 자격을 잃게 될 것입니다. <br>
    그러나 회원 스스로 회원 자격을 버릴 경우에는 자신의 보유 머니를 언제든지 신청하여 인출 할 수 있습니다.<br>
<b style='color:white'>10.</b> 회사는 모든 서비스를 모든 회원님들께 친절하고 편리하며, 공정하고 투명하게 운영하도록 최선을 다합니다.<br>

      회원은 회사의 모든 서비스를 이용함에 있어 규칙에 따라 정해진 범위 안에서 이용해야만 합니다.<br>
      회사와 회원은 서로 신뢰하고 동반자로서의 관계를 유지하기 위해 노력해야 합니다.<br>
<b style='color:white'>11.</b> 회사는 언제나 정확한 정보를 제공하기 위해 최선의 노력을 다하고 있으나 예기치 않은 오류나 대응할 수 없는 불가 항력<br>
     적인 사항의 경우 이에 따른 결과에 대해 수정할 권리를 가지고 있습니다.<br>
<b style='color:white'>12.</b> 회사는 어떤한 경우에도 불법적인 시도와 타협하거나 거래하지 않으며, 이를 막기 위해 가능한 모든 방법을 동원하고 있습니다.<br>

      회사는 불법적인 시도에 대한 모든 일련의 행위는 모두 취소 처리 하고 지불하지 않을 권리가 있습니다.<br>
<b style='color:white'>13.</b> 이 이용약관은 앞서 공시된 모든 이용약관을 대체 하며 2008년 5월 31일 자로 적용됩니다. <br>
	</td></tr>
	</table>
	<table width="800">
	<tr><td align="right"><input type="checkbox" name="agree" value="Y" checked>회원이용약관 동의</td></tr>
	</table>

	<table width="800" style="margin-top:10">
	<tr><td><b>회원 정보입력</b></td></tr>
	</table>

	<table width="800" bgcolor="#333333" cellpadding="5" style="border:1 solid #909090;">
	<colgroup>
	<col width="150" align="center">
	<col width="650">

	</colgroup>
	<tr><td>회원아이디</td>
		<td><table cellpadding="0" cellspacing="0"><tr>
			<td><input class="member" name="id_input" type="text" value=""></td>
			<td><img src="images/btn_dualcheck.gif" onclick="check_id(frm_reg);" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';" hspace="5"></td>
			</tr></table>
		</td></tr>
	<tr><td>비밀번호</td>

		<td><input class="member" name="pw" type="password"></td></tr>
	<tr><td>비밀번호 확인</td>
		<td><input class="member" name="pw2" type="password"></td></tr>
	<tr><td>닉네임</td>
		<td><table cellpadding="0" cellspacing="0"><tr>
			<td><input class="member" name="nick_input" type="text" value=""></td>
			<td><img src="images/btn_dualcheck.gif" onclick="check_nick(frm_reg);" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';" hspace="5"></td>
			</tr></table>

		</td></tr>
	<tr><td>휴대폰번호</td>
		<td><select class="member" name="phone1">
			<option value="010" >010</option>
			<option value="011" >011</option>
			<option value="016" >016</option>
			<option value="017" >017</option>

			<option value="018" >018</option>
			<option value="019" >019</option>
			</select> -
			<input class="member" name="phone2" type="text" size="4" maxlength="4" value="" style='IME-MODE: inactive'> -
			<input class="member" name="phone3" type="text" size="4" maxlength="4" value="" style='IME-MODE: inactive'>
			</td></tr>
	<tr><td>이메일</td>

		<td><input class="member" name="email1" type="text" value="" style='IME-MODE: inactive' onchange="han_clear(this);" onblur="han_clear(this);"> @
			<input class="member" name="email2" type="text" value="" style='IME-MODE: inactive' onchange="han_clear(this);" onblur="han_clear(this);"></td></tr>
	<tr><td valign=top><b><font color=#FF9933>출금비밀번호<br>[사이트 해킹방지용<br> 비밀번호입니다]</font></b></td>
		<td><input class="member" name="out_pw" type="password" value=""><br>
		본 비밀번호는 최초 회원가입시 1회만 입력되며 이후 수정이 불가능합니다.<br>
                신중하게 입력해주시고 개인 전화번호등 노출이 쉬운번호를 입력하여 피해가<br>

                발생하는경우 책임지지않습니다.<br><b>
                출금요청시 출금비밀번호가 입력되지않는경우 출금신청이 되지않습니다.</b> </td></tr>
	
	</table>

	<table width="800" style="margin-top:10">
	<tr><td align="center">
		<img src="images/btn_join.gif" onclick="FnMemReg(frm_reg);" style="cursor:hand;" hspace="5">
		<img src="images/btn_cancle.gif" onclick="location.href='/';" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';" hspace="5">

	</td></tr>
	</table>

	</form>

	<br><br>

</td></tr>
</table>

<%@include file="footer.jsp"%>

