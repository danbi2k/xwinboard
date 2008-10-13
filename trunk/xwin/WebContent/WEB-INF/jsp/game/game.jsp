<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.xwin.domain.game.*" %>
<%@ page import="java.util.*" %>

<%@include file="../header.jsp"%>

<%
	String type = request.getParameter("type");
%>
<script>
var gameType = '<%=type%>'
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
	<select name="leagueId" style="color:white;background-color:black;" onchange="FnGetGameList('wdl', this.value);">
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

	<div id="gameListDiv"></div>

</tr>
<TABLE cellSpacing=5 cellPadding=5 width="960" bgColor=#212021 border=0>
<TBODY>
	<TR>
		<TD bgColor=#000000>
			<TABLE cellSpacing=2 cellPadding=6 align=center border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG src="images/icon02.gif" align=absMiddle><B>선택하신 경기&nbsp;
							<IMG style="CURSOR: pointer;display:none" onclick="location.href='betting.aspx?mode=viewBettingCart'" src="images/sub02.gif" align=absMiddle> 
							<IMG style="CURSOR: pointer" onclick=FnDeleteCart('<%=type%>') src="images/sub03.gif" align=absMiddle></B>
						</TD>
					</TR>
					</TBODY>
			</TABLE>
		</TD>
	</TR>
</TBODY>
</TABLE>
<br>
<div id="gameCartDiv"></div>
<br>	
<TABLE cellSpacing=5 cellPadding=5 width="960" bgColor=#212021 border=0>
<TBODY>
	<TR>
		<TD bgColor=#000000>
			<TABLE cellSpacing=2 cellPadding=1 align=center border=0>
			<TBODY>
				<TR>
					<TD>배팅금액</TD>
					<TD>
						: <INPUT class=input14 name=BetAmt size=19 value="5,000" onkeyup="FnCalcCart()">
					</TD>
					<TD align=middle><IMG style="CURSOR: pointer" onclick="FnBetting()" src="images/btn_bat.gif"></TD>
				</TR>
				<TR>
					<TD align=middle>예상배당율</TD>
					<TD>: <B><SPAN id=rateDiv value=0>0.00</SPAN></B></TD>
					<TD align=middle><IMG style="CURSOR: pointer;display:none" onclick="FnAddAllCart()" src="images/btn_in.gif"></TD>
				</TR>
				<TR>
					<TD>예상적중금</TD>
					<TD>: <B><SPAN id=expectDiv>0</SPAN> 원</B></TD>
					<TD align=middle></TD>
				</TR>
			</TBODY>
			</TABLE>
		</TD>
	</TR>
</TBODY>
</TABLE>

<script>
function reload()
{
	FnGetGameList('<%=type%>', CartFrm.leagueId.value);	
}

reload();
setInterval("reload()", 60000);
FnDrawCart();
</script>
<!-- ---------------------------------------------------------------------- -->
</td></tr>
</table>
</form>
<%@include file="../footer.jsp"%>