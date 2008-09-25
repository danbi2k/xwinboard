<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.game.*" %>
<%@ page import="java.util.*" %>

<%@include file="../header.jsp"%>

<%
	List<GameWdl> gameWdlList = (List<GameWdl>) request.getAttribute("gameWdlList");
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

<form name="frm">
<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_gamelist.gif"></td><td>1~10경기까지 자유롭게 조합배팅이 가능합니다.</td></td>

	<td align="right">
		<table cellpadding="0" cellspacing="0">
		<tr><td>리그선택 : 
	<select name="GameGroup" style="color:white;background-color:black;" onchange="FnGetGameList(this.value);">
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

			<td><img src="images/btn_reload.gif" onclick="document.location.reload();" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';" hspace="5"></td>
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
		<td height=34 style="color:white;"><b>경기일시</td>

		<td style="color:white;"><b>리그</td>
		<td style="color:white;"><b>승</td>
		
			<td style="color:white;"><b>무</td>
		
		<td style="color:white;"><b>패</td>
		<td style="color:white;"><b>상태</td>
	</tr>

	</table>

	<!-- ***************************************************** -->
	<div id="gameListDiv"></div>
<!-- --------------------------------------------------------------------------- -->

</tr>
<tr><td align="center" style="padding-top:10px;">
	<table width="900" style="border-bottom:1 solid #909090;">
	<tr><td width="100"><img src="images/title_betcart.gif"></td><td></td></td>
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
<script>
FnGetGameList();
FnDrawCart();
</script>
<!-- ---------------------------------------------------------------------- -->
</td></tr>
</table>
</form>
<%@include file="../footer.jsp"%>