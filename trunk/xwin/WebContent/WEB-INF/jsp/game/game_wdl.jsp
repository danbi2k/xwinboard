<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.game.*" %>
<%@ page import="java.util.*" %>

<%@include file="../header.jsp"%>

<script>
var gameType = 'wdl'
</script>
<%
	List<League> leagueList = (List<League>) request.getAttribute("leagueList");
	
	String leagueId = (String) request.getParameter("leagueId");
	leagueId = leagueId == null ? "" : leagueId;
%>

<%
 
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
<form name="CartFrm" method="post">
<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_gamelist.gif"></td><td>1~10경기까지 자유롭게 조합배팅이 가능합니다.</td>

	<td align="right">
		<table cellpadding="0" cellspacing="0">
		<tr><td>리그선택 : 
	<select name="GameGroup" style="color:white;background-color:black;" onchange="FnGetGameList('wdl', this.value);">
		<option value="">--전체--</option>
		<%
		if (leagueList != null && leagueList.size() > 0) {
			for (League league : leagueList) {
		%>
			<option value='<%=league.getId()%>' style='' <%=leagueId.equals(league.getId()) ? "selected" : ""%>><%=league.getName()%></option>
		<%
			}
		}
		%>
	</select></td>

			<td><img src="images/btn_reload.gif" onclick="FnEmptyGameWdlCart('wdl')" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';" hspace="5"></td>
		</tr></table>
	</td>
	</table>
</td></tr>
<tr><td valign="top" align="center">

	<table width="900" bgcolor="#d9d8d6" cellspacing="1" cellpadding="3">

	<colgroup>
		<col align="center" width="100">

		<col align="center" width="*">
		<col align="center" width="180">
		<col align="center" width="80">
		<col align="center" width="180">
		<col align="center" width="50">
	</colgroup>

	<tr bgcolor="#ce892c">
		<td height=34 style="color:white;"><b>경기일시</b></td>

		<td style="color:white;"><b>리그</b></td>
		<td style="color:white;"><b>승</b></td>
		
			<td style="color:white;"><b>무</b></td>
		
		<td style="color:white;"><b>패</b></td>
		<td style="color:white;"><b>상태</b></td>
	</tr>

	</table>

	<!-- ***************************************************** -->
	<div id="gameListDiv"></div>
<!-- --------------------------------------------------------------------------- -->

</tr>
<tr><td align="center" style="padding-top:10px;">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_betcart.gif"></td><td></td>
	</table>
</td></tr>

<tr><td align="center">
<!-- ---------------------------------------------------------------------- -->
<table width="900" cellpadding="3" cellspacing="1" bgcolor="#0a0a0a">
<tr><td width="555" align="center" valign="top">
		<div id="gameCartDiv">		
		</div>		
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
				<tr><td>
				<input type="text" class="member" size="10" name="BetAmt" maxlength="7" value="5000" style="IME-MODE: disabled;text-align:right;" onkeydown="" onkeyup="only123(this);FnCalcCart()">원
				</td>
				</tr></table>
				</form>
			</td></tr>
		<tr><td style="border-bottom:1 solid #d9d8d6;">&nbsp;</td>
			<td colspan="3" style="border-bottom:1 solid #d9d8d6;" align="left">

				<table width="">
				<tr>
				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='5000';FnCalcCart();">5천</span></td>
				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='10000';FnCalcCart();">1만</span></td>

				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='20000';FnCalcCart();">2만</span></td>
				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='30000';FnCalcCart();">3만</span></td>
				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:white;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='50000';FnCalcCart();">5만</span></td>
				</tr>
				<tr>
				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='100000';FnCalcCart();">10만</span></td>
				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='200000';FnCalcCart();">20만</span></td>

				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='300000';FnCalcCart();">30만</span></td>
				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='500000';FnCalcCart();">50만</span></td>
				<td><span style="width:40;height:16;background:url('images/btn_money_bg2.gif');color:orange;font-size:11px;text-align:center;padding-top:2;margin-right:3;cursor:hand" onclick="CartFrm.BetAmt.value='1000000';FnCalcCart();">100만</span></td>
				</tr>
				</table>
			
			</td>
		</tr>

		<tr><td style="color:darkorange;border-bottom:1 solid #d9d8d6;">배당율</td>
			<td style="color:darkorange;border-bottom:1 solid #d9d8d6;border-right:1 solid #d9d8d6;"><b>× <div id="rateDiv" style="display:inline" value='0'>0.00</div></b></td>
			<td style="color:darkorange;border-bottom:1 solid #d9d8d6;">예상배당금</td>
			<td style="color:darkorange;border-bottom:1 solid #d9d8d6;"><b><div id="expectDiv" style="display:inline">0</div> 원</b></td></tr>
		<tr><td style="color:darkorange;border-bottom:1 solid #d9d8d6;">잔여 머니</td>
			<td style="color:darkorange;border-bottom:1 solid #d9d8d6;border-right:1 solid #d9d8d6;"><div id="balanceDiv" style="display:inline">0</div> 원</td>

			<td style="color:darkorange;border-bottom:1 solid #d9d8d6;">배팅후 머니</td>
			<td style="color:darkorange;border-bottom:1 solid #d9d8d6;"><div id="afterDiv" style="display:inline">0</div> 원</td></tr>

		</table>
		<table width="100%">
		<tr><td align="right">
			
				<img src="images/btn_buy.gif" id="btn_buy" onclick="FnBetting()" style="filter:gray();">
			
		</td></tr>

		</table>
		
		<br>

	</td>
</tr>
</table>
<script>
FnGetGameList('wdl');
FnDrawCart();
</script>
<!-- ---------------------------------------------------------------------- -->
</td></tr>
</table>
</form>
<%@include file="../footer.jsp"%>