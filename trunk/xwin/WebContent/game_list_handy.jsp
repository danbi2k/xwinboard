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


<form name="frm">


	<table width="900" bgcolor="#9A9492" cellspacing="1" cellpadding="3">

	<colgroup>
		<col bgcolor="#0a0a0a" align="center" width="100">
		<col bgcolor="#0a0a0a" width="*">
		<col bgcolor="#0a0a0a" width="180" align="right">
		<col bgcolor="#0a0a0a" width="80"  align="center" >
		<col bgcolor="#0a0a0a" width="180">
		<col bgcolor="#0a0a0a" width="50"  align="center">
	</colgroup>
	
	<tr height="34" bgcolor="#001126">

		<td>08-09-24 11:10</td>
		<td>
			<table cellpadding="0" cellspacing="2"><tr><td><img src="symbol/58.gif" style="display:none" onload="this.style.display='';"></td>
			<td>미국 메이저리그</tr>
			</table>
		</td>
		<td>LA 다저스 <b style="font-size:15px;">□</b> <input type="checkbox" name="Game_7706" style="display:none">1.60<span style="width:8;">&nbsp;</span>

		</td>
		<td>
			<b style="color:darkorange;">-1.5</b><input type="checkbox" name="Game_7706" style="display:none;">
			
		</td>
		<td><span style="width:8;">&nbsp;</span>
			2.00 <b style="font-size:15px;">□</b> <input type="checkbox" name="Game_7706" style="display:none">샌디에이고
		</td>

		<td>접수마감</td>
	</tr>
	
	<tr height="34" bgcolor="#001126">
		<td>08-09-24 11:10</td>
		<td>
			<table cellpadding="0" cellspacing="2"><tr><td><img src="symbol/58.gif" style="display:none" onload="this.style.display='';"></td>
			<td>미국 메이저리그</tr>

			</table>
		</td>
		<td>시애틀 <b style="font-size:15px;">□</b> <input type="checkbox" name="Game_7709" style="display:none">1.80<span style="width:8;">&nbsp;</span>
		</td>
		<td>
			<b style="color:darkorange;">+1.5</b><input type="checkbox" name="Game_7709" style="display:none;">

			
		</td>
		<td><span style="width:8;">&nbsp;</span>
			1.80 <b style="font-size:15px;">□</b> <input type="checkbox" name="Game_7709" style="display:none">LA 에인절스
		</td>
		<td>접수마감</td>
	</tr>
	
	<tr height="34" >

		<td>08-09-24 11:15</td>
		<td>
			<table cellpadding="0" cellspacing="2"><tr><td><img src="symbol/58.gif" style="display:none" onload="this.style.display='';"></td>
			<td>미국 메이저리그</tr>
			</table>
		</td>
		<td>샌프란시스코<input type="checkbox" name="Game_7712" value="1"  onclick="FnGameBet('7712',0);">1.70<span style="width:8;">&nbsp;</span>

		</td>
		<td>
			<b style="color:darkorange;">-1.5</b><input type="checkbox" name="Game_7712" style="display:none;">
			
		</td>
		<td><span style="width:8;">&nbsp;</span>
			1.90<input type="checkbox" name="Game_7712" value="2"  onclick="FnGameBet('7712',2);">콜로라도
		</td>
		<td><font color="darkorange">접수중</td>

	</tr>
	
	</table>


</form>


<script>
function FnGameBet(GameNo,index){
	
	var obj = eval("document.all.frm.Game_"+ GameNo);
	for(var i=0;i<obj.length;i++){ obj[i].checked = i==index & obj[index].checked; }
	if(obj[index].checked){
		parent.GameCart.location.href = "game_cart.asp?GameNo="+ GameNo +"&Bet="+ obj[index].value;
	}else{
		parent.GameCart.location.href = "game_cart.asp?GameDel="+ GameNo;
	}
	
}
</script>

</body>
</html>