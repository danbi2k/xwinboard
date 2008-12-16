<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String status = XwinUtil.nvl(request.getParameter("status"));
	String gameType = XwinUtil.nvl(request.getParameter("gameType"));
%>
<%@include file="../header.jsp"%>
<!--
<table width="985" height="26" bgcolor="#333333" style="border:1 solid #efefef;">
<tr>
	<td align="center" width="60">Notice</td>
	<td width="*">공지사항나오는곳...</td>
	<td align="center" width="80">[이전][다음]</td>
</tr>
</table>

-->

<form name="frm" action="myBet.php">
<input type="hidden" name="mode" value="viewMyBettingList"/>
<table width="960" style="margin-top:7;margin-bottom:7;border:1 solid #909090;" bgcolor="#0a0a0a">
<tr><td align="center">

	<table width="900" style="border-bottom:1 solid #909090;">

	<tr><td width="100"><img src="images/title_mybet.gif"></td><td>배팅 내역 및 결과입니다.</td>
	<td align="right">
		<table cellpadding="0" cellspacing="0">
		<tr><td>
			경기종류:
			<select name="gameType" style="color:white;background-color:black;" onchange="FnGetMyBetList(0);">
				<option value="">--전체--</option>
				<option value='wdl' <%=gameType.equals("wdl")?"selected":""%> style='color:#b0b0b0;'>승무패</option>
				<option value='handy' <%=gameType.equals("handy")?"selected":""%> style='color:#b0b0b0;'>핸디캡</option>
			</select>
			상태 :
			<select name="status" style="color:white;background-color:black;" onchange="FnGetMyBetList(0);">
				<option value="">--전체--</option>
				<option value='<%=Code.BET_STATUS_RUN%>' <%=status.equals(Code.BET_STATUS_RUN)?"selected":""%> style='color:#b0b0b0;'><%=Code.getValue(Code.BET_STATUS_RUN)%></option>
				<option value='<%=Code.BET_STATUS_SUCCESS%>' <%=status.equals(Code.BET_STATUS_SUCCESS)?"selected":""%> style='color:orange;'><%=Code.getValue(Code.BET_STATUS_SUCCESS)%></option>
				<option value='<%=Code.BET_STATUS_FAILURE%>' <%=status.equals(Code.BET_STATUS_FAILURE)?"selected":""%> style='color:#505050;'><%=Code.getValue(Code.BET_STATUS_FAILURE)%></option>
				<option value='<%=Code.BET_STATUS_CANCEL%>' <%=status.equals(Code.BET_STATUS_CANCEL)?"selected":""%> style='color:#a47842;'><%=Code.getValue(Code.BET_STATUS_CANCEL)%></option>
				<option value='<%=Code.BET_STATUS_RETURN%>' <%=status.equals(Code.BET_STATUS_RETURN)?"selected":""%> style=''><%=Code.getValue(Code.BET_STATUS_RETURN)%></option></select></td>
			<td><img src="images/btn_reload.gif" onclick="location.href=location.href;" style="cursor:hand;filter:gray();" onmouseover="this.style.filter='';" onmouseout="this.style.filter='gray()';" hspace="5"></td>

		</tr></table>
	</td>
	</table>
</td></tr>
<tr><td valign="top" align="center" height="300">

		<div id="myBetListDiv">
		</div>

<table width="850" height="30">
<tr><td align="center">

    <!-----[ 페이징 ]--------------------------------------------//-->
	
    <!-----[ 페이징 ]--------------------------------------------//-->
</td></tr>
</table>

</td></tr>
</table>
</form>

<script>
FnGetMyBetList(0);
</script>

<%@include file="../footer.jsp"%>