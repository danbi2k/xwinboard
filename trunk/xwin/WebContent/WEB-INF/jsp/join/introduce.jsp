<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../header.jsp"%>

<table width="960" height="400" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">

	<tr><td width="100"><img src="images/title_introduce.gif"></td>
	</table>
</td></tr>
<tr><td valign="top" align="center">

	<form name="intro">
	<input name="password" type="hidden" value=""/>
	<table width="800" style="margin-top:10">
	<tr><td><b>추천장이용약관</b></td></tr>
	</table>
	<table width="800" bgcolor="#333333" cellpadding="5" style="border:1 solid #909090;">
	<tr><td style="line-height:20px;">
<span style="width:100%;height:160;OVERFLOW:auto">
<b style='color:white'>1.</b> No1Bet(이하 회사)은 안전한 신규회원 모집을 위해 '추천장' 시스템을 적용하고 있습니다.<br>
<b style='color:white'>2.</b> 회원님은 가까운 지인의 핸드폰으로 추천장을 문자로 발송하여 신규회원 가입을 권유 할 수 있습니다.<br>
<b style='color:white'>3.</b> 추천장을 받은분이 회원으로 가입하였을 경우 추천장을 보낸 회원님은 추천인 자격을 가집니다.<br>
<b style='color:white'>4.</b> 추천인은 본인이 추천한 회원이 배팅을 하였을 경우 배팅금액의 3%를 포인트로 적립 받습니다.<br>
<b style='color:white'>5.</b> 포인트는 배팅이 결과처리 된 후에 자동 적립 됩니다. (취소된 배팅은 적립되지 않습니다)<br>
<b style='color:white'>6.</b> 추천장은 회원님의 배팅 실적에 따라 주기적으로 지급됩니다.<br>
<b style='color:white'>7.</b> 추천장은 5자의 무작위 문자열로 구성되며 추천장과 추천인의 ID를 사용하여 접속한 후 회원가입을 진행 합니다.<br>
<b style='color:white'>8.</b> 보다 안전하고 발전적인 사이트 운영을 위해 적극적인 활용을 부탁드립니다.<br>
	</span>
	</td></tr>
	</table>
	<table width="800">
	<tr></tr>
	</table>

	<table width="800" style="margin-top:10">
	<tr><td><b>추천내역보기</b>&nbsp;&nbsp;&nbsp;※ 총추천인을 클릭하시면 회원님께 추천받으신분들 목록이 나옵니다.</td></tr>
	</table>

	<table width="800" bgcolor="#333333" cellpadding="5" style="border:1 solid #909090;">
	<tr>
		<td>총추천인</td>
		<td><a onclick="openIntroduceList()"><%=member.getIntroduceCount()%> 명</a></td>
		<td>총추천인배팅횟수</td>
		<td><%=member.getIntroduceBettingCount()%> 번</td>
		<td>총추천인배팅금액</td>
		<td><%=XwinUtil.comma3(member.getIntroduceBettingMoney())%> 원</td>
	</tr>
	<tr>
		<td>총추천인포인트</td>
		<td><%=XwinUtil.comma3(member.getIntroduceBettingPoint())%> 원</td>
		<td>현보유포인트</td>
		<td><%=XwinUtil.comma3(member.getPoint())%> 원</td>
		<td colspan="2"><input type="button" value="머니전환" onclick="exchangePoint(<%=member.getPoint()%>)"/></td>
	</tr>
	</table>

	<table width="800" style="margin-top:10">
	<tr><td><b>추천정보입력</b></td></tr>
	</table>

	<table width="800" bgcolor="#333333" cellpadding="5" style="border:1 solid #909090;">
	<colgroup>
	<col width="150" align="center">
	<col width="650">

	</colgroup>
	<tr><td>남은 추천장 수</td>
		<td><table cellpadding="0" cellspacing="0"><tr>
			<td><%=member.getIntroLetter()%> 장</td>
			</tr></table>
		</td></tr>
	<tr><td>추천할 휴대폰번호</td>
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
			추천장을 발송할 휴대폰 번호를 입력하십시오
			</td></tr>
	</table>

	<table width="800" style="margin-top:10">
	<tr><td align="center">
		<input type="button" onclick="introduce()" value="추천하기">
	</td></tr>
	</table>

	</form>

	<br><br>

</td></tr>
</table>

<script>
function openIntroduceList()
{
	alert("준비중");	
}

function introduce()
{
	var frm = document.intro;
	if (frm.phone1.value == "" || frm.phone2.value == "" || frm.phone3.value == "") {
		alert("휴대폰 번호를 입력하세요");
		return;
	}

	var query = "mode=introduce";
	query += "&mobile=" + frm.phone1.value + frm.phone2.value + frm.phone3.value;
	var http = new JKL.ParseXML("introduce.aspx", query);
	var result = http.parse();

	alert(result.resultXml.message);
	if (result.resultXml.code == 0)
		location.reload();	
}
</script>

<%@include file="../footer.jsp"%>