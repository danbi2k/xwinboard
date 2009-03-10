<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.xwin.domain.game.*"%>
<%@ page import="com.xwin.infra.util.*"%>
<%@ page import="com.xwin.domain.*"%>
<%@ page import="java.util.*"%>
<%@page import="com.xwin.web.controller.admin.AdminGameController"%>
<%
%>

<script>
var targetCheck = 0;
</script>

<%@ include file="../admin_header.jsp"%>

<form name="SMSFORM" method="post">
<table>
	<tr>
		<td colspan="2">문자전송 (<%=XwinUtil.comma3(Admin.SMS_REMAIN)%>)</td>
	</tr>
	<tr>
		<td colspan="2">
		<textarea name="msg" rows="7" cols="16" onKeyUp="checkBytes()" onFocus="checkBytes()"></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2"><input type="text" name="bytes" size="4" maxlength="6" value="0/80" readonly></td>
	</tr>
	<!--
	<tr>
		<td><select name="tel_kind">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="018">018</option>
			<option value="019">019</option>
		</select>-<input type="text" name="tel_phone" size="9" maxlength="9" onKeyUp="addHipen(this)"> <input type="button" name="bt1" onClick="AddCheck();" value="입력"></td>
	<tr>-->
	<tr>
		<td width="36%">송신대상</td>
		<td>
			<input type="radio" name="target" checked onclick="targetCheck=0;document.SMSFORM.phone.disabled=false"> 단일송신
			<input type="radio" name="target" onclick="targetCheck=1;document.SMSFORM.phone.value='';document.SMSFORM.phone.disabled=true"> 전체송신
		</td>
	</tr>
	<tr>
		<td width="36%">
		<select name="search">
			<option value="userId">아이디</option>
			<option value="nickName">닉네임</option>
		</select>
		</td>
		<td><input type="text" name="keyword" size="15" maxlength="15"><input type="button" onclick="searchPhoneNumber()" value="검색"></td>
	</tr>
	<tr>
		<td width="36%">수신번호</td>
		<td><input type="text" name="phone" size="15" maxlength="15" value=""></td>
	</tr>
	<!--
	<tr>
		<td><input type="text" name="tel_count" value="0" size="3" maxlength="4" style="text-align:right" readonly>
		<select name="remote_phone" style="width:110;" size="3" multiple></select> <button onClick="DelCheck();">삭제</button></td>
	</tr>
	-->
	<tr>
		<td>발신번호</td>
		<td><input type="text" name="callback" size="15" maxlength="15" onKeyUp="onlyNumber(this)" value="<%=SiteConfig.SITE_PHONE%>"></td>
	</tr>
	<tr>
		<td colspan="2"><input type="button" name="submit1" value="전송" onClick="onSubmit();">	<input type="reset" name="Submit5" value="취소"></td>
	</tr>
</table>
</form>


<script language="Javascript">
<!--
	function searchPhoneNumber()
	{
		var query = "mode=searchPhoneNumber";
		query += "&search=" + SMSFORM.search.value;
		query += "&keyword=" + SMSFORM.keyword.value;

		var http = new JKL.ParseXML("adminSms.aspx", query);
		var result = http.parse();

		if (result.resultXml.code == 0) {
			if (result.resultXml.message)
				SMSFORM.phone.value = result.resultXml.message;
			else
				SMSFORM.phone.value = "";
		}
	}

	// 문자메시지 바이트수 계산
	function checkBytes() {

		var bodyVal = document.SMSFORM.msg.value;
		var bodyLen = bodyVal.length;
		var bytesLen = 0;
		var validBodyLen = 0;
		var validBytesLen = 0;

		var ALERT_MSG = "80bytes 이상의 메시지는 전송하실 수 없습니다";
		var MaxBytes		= 80

		for (var i = 0; i < bodyLen; i++) {

			var oneChar = bodyVal.charAt(i);
			
			if (escape(oneChar).length > 4) {
			
				bytesLen += 2;
			
			} else if (oneChar!='\r' || oneChar!='\n') {
				
				bytesLen++;
			}

			if(bytesLen <= MaxBytes)	{
			
				validBodyLen = i + 1;
				validBytesLen = bytesLen;
			
			}
		}

		if(bytesLen > MaxBytes) {
		
			alert(ALERT_MSG);
			var realBodyVal = bodyVal.substr(0, validBodyLen);
			document.SMSFORM.msg.value = realBodyVal;
			var bytesVal = validBytesLen + "/"+MaxBytes;

		} else {
			
			bytesVal = bytesLen + "/"+MaxBytes;
		
		}
		
		document.SMSFORM.bytes.value = bytesVal;
		document.SMSFORM.msg.focus();
	}

	function onlyNumber(obj) {

		var str = obj.value;
		
		if (checkNumber(str) == false) {
			alert("숫자만입력해 주세요");
			obj.value = "";
			return;
		}
	}
	

	// 숫자 check 
	function checkNumber(str)
	{
		for( var i=0; i < str.length; i++) {
			var ch = str.substring( i, i+1 );
			if( (ch < "0" || ch > "9") && ch != "." ) 
				return false;              
		}    
		return true;
	}

	function getLength(str) {

		var count = 0 ;													//메시지의 바이트를 저장하는 변수
		for (var i = 0; i < str.length; i++) {							// 0-127 1byte, 128~ 2byte

			if ( str.charCodeAt(i) > 127) {
				count += 2;
			} else {
				count++;
			}
		}

		return count;
	}

	function onSubmit() {
		
		var Obj = document.SMSFORM;

		// 문자내용 체크
		if (!Obj.msg.value) {
			alert("문자내용이 존재하지 않습니다.");
			Obj.msg.focus();
			return;

		}
			
		// 수신번호 체크
		if (targetCheck==0 && Obj.phone.value.length < 10) {
			
			alert("수신번호가 존재하지 않습니다");
			Obj.phone.focus();
			return;
			
		}

		// 송신번호 체크
		if (Obj.callback.value == "") {

			alert("발신번호를 입력하세요");
			Obj.callback.focus();
			return;
			
		}

		var query = "";
		if (targetCheck == 0)
			query += "mode=sendSms";
		else
			query += "mode=sendSmsAllMember";
		query += "&message=" + Obj.msg.value;
		query += "&phone=" + Obj.phone.value;
		query += "&callback=" + Obj.callback.value;
		
		var http = new JKL.ParseXML("adminSms.aspx", query);
		var result = http.parse();

		alert(result.resultXml.message);
	}

	function reLayer() {
		
		if (document.SMSFORM.re_chk.checked == true) {

			reserveLayer.style.display = "inline";
			document.SMSFORM.submit1.value = "예약";

		} else {

			reserveLayer.style.display = "none";
			document.SMSFORM.sms_year.value		= year;
			document.SMSFORM.sms_month.value	= month;
			document.SMSFORM.sms_day.value		= date;
			document.SMSFORM.sms_hour.value		= "";
			document.SMSFORM.sms_min.value		= "";
			document.SMSFORM.submit1.value = "전송";

		}
	}

//-->
</script>
   

<%@ include file="../admin_footer.jsp"%>