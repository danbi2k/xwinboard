<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>

<head>
<title>10xBet</title>
    <Meta Http-Equiv="Content-Type" Content="Text/Html; Charset=Euc-Kr">
    <Meta Http-Equiv="Imagetoolbar" Content="No">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" content="-1">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
	<META HTTP-EQUIV="Refresh" Content="1800; URL=/member/logout.asp?auto=1">

    <link rel="stylesheet" href="common/default.css">
    <script language="JavaScript" src="common/default.js"></script>
</head>
<script language="javascript" src="common/game.js"></script>
<script language="javascript" src="common/member.js"></script>

<body style="margin:0" oncontextmenu="return false" onload="self.resizeTo(document.body.scrollWidth , document.body.scrollHeight);">

<form name="CartFrm" method="post">
<table width="900" cellpadding="3" cellspacing="1" bgcolor="#0a0a0a">
<tr><td width="555" align="center" valign="top">
		<table width="550" bgcolor="#d9d8d6" cellspacing="1" bgcolor="#0a0a0a">

		<colgroup>
			<col align="left" width="50">
			<col width="*">
			<col align="center" width="50">
			<col align="center" width="60">
		</colgroup>

		<tr bgcolor="#ce892c" align="center">
			<td style="color:white"><input type="checkbox" name="GameDel" onclick="CheckAll(CartFrm.GameDel);">No.</td>

			<td style="color:white"><b>리그</td>		
			<td style="color:white"><b>선택</td>
			<td style="color:white"><b>배당율</td>
		</tr>

		<tr bgcolor="black">
			<td colspan="4" height="110" align="center" style='line-height:30px;'>배팅할 경기를 선택하세요!<br>최대 10 경기까지 복수선택 가능합니다.</td>

		</tr>

		</table>
		
	</td>
	<td width="345" align="right">

		<table width="340" style="border:1 solid #d9d8d6" cellpadding="5" cellspacing="0">
		<colgroup>
			<col width="100" align="right">
			<col width="80" align="right">

			<col width="80" align="right">
			<col width="80" align="right">
		</colgroup>
		<tr><td style="color:darkorange;">배팅금액</td>
			<td colspan="3" align="left">
				<table cellpadding="0" cellspacing="0">
				<tr><td><input type="" class="member" size="10" name="BetAmt" maxlength="7" value="5,000" style="IME-MODE: disabled;text-align:right;" onkeyup="only123(this);" onblur="comma(this);btn_buy.style.filter='gray()';btn_apply.style.filter='';">원</td>
					<td><img src="images/btn_apply.gif" id="btn_apply" onclick="FnCartApply(CartFrm);" style="filter:gray();cursor:hand;" hspace="5"></td>

				</tr></table>
			</td></tr>
		<tr><td style="border-bottom:1 solid #d9d8d6;">&nbsp;</td>
			<td colspan="3" style="border-bottom:1 solid #d9d8d6;" align="left">

				<table width="">
				<tr>
				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='5,000';FnCartApply(CartFrm);">5천</span></td>
				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='10,000';FnCartApply(CartFrm);">1만</span></td>

				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='20,000';FnCartApply(CartFrm);">2만</span></td>
				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='30,000';FnCartApply(CartFrm);">3만</span></td>
				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='50,000';FnCartApply(CartFrm);">5만</span></td>
				</tr>
				<tr>
				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='100,000';FnCartApply(CartFrm);">10만</span></td>
				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='200,000';FnCartApply(CartFrm);">20만</span></td>

				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='300,000';FnCartApply(CartFrm);">30만</span></td>
				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='500,000';FnCartApply(CartFrm);">50만</span></td>
				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='1,000,000';FnCartApply(CartFrm);">100만</span></td>
				</tr>
				</table>
			
			</td>
		</tr>

		<tr><td style="color:darkorange;border-bottom:1 solid #d9d8d6;">배당율</td>
			<td style="color:darkorange;border-bottom:1 solid #d9d8d6;border-right:1 solid #d9d8d6;"><b>× 0.00</td>
			<td style="color:darkorange;border-bottom:1 solid #d9d8d6;">예상배당금</td>
			<td style="color:darkorange;border-bottom:1 solid #d9d8d6;"><b>0 원</td></tr>
		<tr><td style="color:darkorange;border-bottom:1 solid #d9d8d6;">잔여 머니</td>
			<td style="color:darkorange;border-bottom:1 solid #d9d8d6;border-right:1 solid #d9d8d6;">0 원</td>

			<td style="color:darkorange;border-bottom:1 solid #d9d8d6;">배팅후 머니</td>
			<td style="color:darkorange;border-bottom:1 solid #d9d8d6;">0 원</td></tr>

		</table>

		<table width="100%">
		<tr><td align="right">
			
				<img src="images/btn_buy.gif" id="btn_buy" onclick="alert('배팅카트가 비어있습니다.');" style="filter:gray();">
			
		</td></tr>

		</table>
		
		<br>

	</td>
</tr>
</table>
</form>


</body>
</html>